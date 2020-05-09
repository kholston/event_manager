require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'



def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  url = 'www.commoncause.org/take-action/find-elected-officials'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting #{url}"
  end
end


puts 'Event Manager Initialized!'
puts ' '
filename = 'event_attendees.csv'

contents = CSV.open filename, headers: true, header_converters: :symbol

template_letter = File.read 'form_letter.erb'
erb_template = ERB.new template_letter

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  puts form_letter
end
