require 'csv'
puts 'Event Manager Initialized!'
puts ' '
filename = 'event_attendees.csv'

contents = CSV.open filename, headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]
  puts "#{name} #{zipcode}"

end
