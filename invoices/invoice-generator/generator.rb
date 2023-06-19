require 'Caracal'
require 'date'
require 'csv'
require 'json'

cur_date = Date.today
filepath = "inputs.json"

serialized_invoices = File.read(filepath)
invoices = JSON.parse(serialized_invoices)
allinvoices = invoices['invoices']

# def entries
#   entries = []
#   filepath = "invoice-generator/inputs.csv"
#   CSV.foreach(filepath) do |row|
#     entries.push(row)
#   end
#   entries
# end

def table_1(date, po_number, total)
  due_date = date + 14
  [['Work Date:', date], ['Due Date:', due_date], ['PO Number:', po_number], ['Balance Due', total]]
end

def table_2(jobdescription, quantity, amount)
  result = [['Item', 'Quantity', 'Rate', 'Amount'], [jobdescription, quantity, "$#{amount}AUD", "$#{quantity * amount}AUD"]]
end

def create_invoice(number, date, po_number, total, jobnumber, jobdescription, quantity, amount)
  Caracal::Document.save "Invoice##{number}-P.O.##{po_number}.docx" do |docx|
    #styling
    docx.style do
      id      'Heading1'
      name    'heading 1'
      font    'Arial'
      bottom  6
      top     6
    end
    docx.style do
      id      'Heading2'
      name    'heading 2'
      font    'Arial'
      bottom  0
      top     0
    end
    docx.style do
      id      'Paragraph'
      name    'paragraph'
      font    'Arial'
      bottom  0
      top     0
    end

    # header
    docx.h1 "TAX INVOICE ##{number}" do
      align :right
      color '333333'
      size  40
      bold  true
    end
    docx.h2 "Tim Jianger Cai" do
      align :right
      color '333333'
      size  24
      bold  true
    end
    docx.p  "ABN: 37 676 346 082" do
      align :right
      color '333333'
      size  20
    end
    docx.p
    docx.hr

    #summary
    c1 = Caracal::Core::Models::TableCellModel.new margins: { top: 0, bottom: 100, left: 0, right: 200 } do
      h2 'Bill to:' do
        size  24
        bold  true
      end
      p  'ABN Group Pty Ltd'
      p  'ABN: 82 130 382 188'
      p
    end
    c2 = Caracal::Core::Models::TableCellModel.new margins: { top: 0, bottom: 100, left: 0, right: 200 } do
      h2 'Ship to:' do
        size  24
        bold  true
      end
      p  '82 Lorimer Street,'
      p  'Docklands VIC 3008'
    end
    c3 = Caracal::Core::Models::TableCellModel.new margins: { top: 0, bottom: 100, left: 0, right: 200 } do
      table table_1(date, po_number, total), border_size: 4 do
        cell_style rows[-1], bold: true, background: 'F3F3F3'
        cell_style cols[0],  align: :right, bold: true
        cell_style cells,    size: 20, margins: { top: 100, bottom: 0, left: 100, right: 100 }
      end
    end

    docx.table [[c1, c2, c3]] do
      cell_style cols[0], width: 3000
      cell_style cols[1], width: 3000
    end
    docx.hr
    docx.p

    # invoice details
    docx.table table_2(jobdescription, quantity, amount), border_size: 4 do
      border_top do
        color   '000000'
        line    :double
        size    8
        spacing 2
      end
      cell_style rows[0], background: '333333', color: 'FFFFFF'
      cell_style cols[0], width: 6000, bold: true, align: :left
      cell_style cols[1], align: :center
      cell_style cols[2], align: :center
      cell_style cols[3], align: :center
    end

    docx.p
    docx.p
    docx.p  'Notes:'
    docx.p  "Job Number: #{jobnumber}"
  end
end

allinvoices.each do |invoice|
  create_invoice(invoice['invoice_number'],cur_date, invoice['po_number'], invoice['totalprice'], invoice['job_number'], invoice['job_description'], invoice['quantity'], invoice['price'])
end
# create_invoice(6, cur_date, '123470', '$54.00 AUD', '123491234', entries)
