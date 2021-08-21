require 'httparty'
require 'json'

class Party
  include HTTParty
  base_uri ENV['PUSHOVER_API']
end

response = HTTParty.get("https://api.exchangeratesapi.io/latest?base=USD")

body = JSON.parse(response.body)
summary =  body["rates"]["INR"]
Party.post("/1/messages.json",
:query => {
  :token => ENV['TOKEN'],
  :user => ENV['USER'],
  :message => summary,
  :title => 'Dollar to Rupee'
  })
