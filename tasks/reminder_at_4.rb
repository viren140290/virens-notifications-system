require 'httparty'
require 'json'

class Party
  include HTTParty
  base_uri ENV['PUSHOVER_API']
end


summary =  "Check Phone and headphones battery levels"
Party.post("/1/messages.json",
:query => {
  :token => ENV['TOKEN'],
  :user => ENV['USER'],
  :message => summary,
  :title => 'Dollar to Rupee'
  })
