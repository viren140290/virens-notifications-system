require 'httparty'
require 'json'

class Party
  include HTTParty
  base_uri ENV['PUSHOVER_API']
end

response = HTTParty.get(ENV['WORK_TO_HOME_URL'])

body = JSON.parse(response.body)
summary = body["routes"][0]["summary"]
time = body["routes"][0]["legs"][0]["duration"]["text"]
total = "Traffic via " + summary + " will take " + time

Party.post("/1/messages.json",
:query => {
  :token => ENV['TOKEN'],
  :user => ENV['USER'],
  :message => total,
  :title => 'Route from Work to Home'
  })
