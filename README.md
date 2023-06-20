# invoice-generator-script-ruby
Invoice generator that allows me to create multiple Purchase Orders for my part-time job.
Saving me 20 minutes every time I would need to generate purchase orders

---
# Installation
## Requirements
[Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)

or check Ruby version in your terminal
```
ruby -v
```

## Installation

> 1. gh repo clone invoice-generator-script-ruby

---

# Why?
Currently it was taking me 20 minutes+ to create and send off multiple purchase orders in order to get paid.
> This project has taught me a few things about creating and manipulating data through various LibreOffice/Microsoft Office type of file types.
> Creating multiple files on mass
> How to think about building a basic application very specific to my needs
> FUN

---
# How to use

## 1. add in raw data via inputs.json
![alt text](https://res.cloudinary.com/dhxonutdu/image/upload/v1687223213/small-projects/inputs-json-ruby-invoice-script_eijjvz.png)


```
"invoice_number": (1)
"po_number": (2)
"job_number": (3)
"job_description": (4)
"quantity": (5)
"price": (6)
"totalprice": (7) 
```
## 2. Result
![alt text](https://res.cloudinary.com/dhxonutdu/image/upload/v1687223212/small-projects/output-ruby-invoice-script_hshoal.png)


## 3. run script
```
`cd invoices`
`ruby generator.rb`
```
