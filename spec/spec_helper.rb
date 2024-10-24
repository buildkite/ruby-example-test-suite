require 'yaml'
require 'json'

begin
  skip_data = File.read('skipped.json')
  skip = JSON.parse(skip_data)
rescue
  skip = []
end

skip_location = skip.reduce({}) { |m, t| m[t["location"]] = true; m }

puts "disabled tests"
puts skip_location.keys

RSpec.configure do |c|
  c.around :example do |example|
    next if skip_location[example.location]
    example.run
  end
end
