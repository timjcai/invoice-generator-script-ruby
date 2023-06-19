require "json"

filepath = './inputs.json'

beatles = {
  beatles: [
    {
      first_name: "John", last_name: "Lennon", instrument: "Guitar"
    }, {
      first_name: "Paul", last_name: "McCartney", instrument: "Bass Guitar"
    }
]}

File.open(filepath, "wb") do |file|
  file.write(JSON.generate(beatles))
end


beatles = JSON.parse(File.read(filepath))

p beatles
