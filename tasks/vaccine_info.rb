require 'httparty'
require 'json'

class Party
  include HTTParty
  base_uri ENV['PUSHOVER_API']
end

response = HTTParty.get("https://www.vaccinespotter.org/api/v0/states/KS.json")

body = JSON.parse(response.body)
# puts body
postal_codes = [66209,66251,66211,66224,66223,66213,66207,66210,66206,66212,66221,66214,66215,66085,66204,66208,66062,66225,66282,66283,66285,66222,66276,66250,66203,66219,66202,66201,66205,66051,66063,66216,66220,66160,66217,66013,66103,66218,66106,66105,66286,66227,66118,66061,66226,66031,66102,66110,66119,66113,66101,66111,66117,66083,66112,66115,66030,66104,66018,66012,66036,66109,66053,66021,66052,66007,66025]

postal_code_arr = postal_codes.map {|item| item.to_s}

# puts body['features'].size
filtered_items = body['features'].select do |item|
  postal_code_arr.include?(item['properties']['postal_code']) && item['properties']['appointments_available'] == true
end

forms = {}
valid_appointments = filtered_items.map do |item|
  if item['properties']['provider'] != 'walgreens'
    forms[item['properties']['provider']] = item['properties']['url']
    details = "#{item['properties']['provider']} #{item['properties']['city']} #{item['properties']['postal_code']}"
  end
end

appointments = valid_appointments.compact.join("\n ")

form_data = []
forms.each do |k,v|
  form_data.push("#{k}: #{v}")
end

form_data_str = form_data.compact.join("\n ")


if !appointments.strip.empty?
  appointment_bot = "Vaccine Spots now available \n #{appointments} \n \n Vaccine Forms \n #{form_data_str}"


  # Real Notifications
  Party.post("/1/messages.json",
  :query => {
    :token => ENV['TOKEN'],
    :user => ENV['USER'],
    :message => appointments,
    :title => 'Appointments'
  })

  Party.post("/1/messages.json",
  :query => {
    :token => ENV['TOKEN'],
    :user => ENV['USER'],
    :message => appointments,
    :title => 'Appointments'
  })
  url = "https://api.telegram.org/#{ENV['BOT_ID']}:#{ENV['BOT_SECRET']}/sendMessage"
  Party.post(url,
  :query => {
    :text => appointment_bot,
    :chat_id => ENV['CHAT_ID']
  })
end
