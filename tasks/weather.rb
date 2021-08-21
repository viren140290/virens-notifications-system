require 'httparty'
require 'json'

class Party
  include HTTParty
  base_uri ENV['PUSHOVER_API']
end

response = HTTParty.get(ENV['WEATHER_URL'])

body = JSON.parse(response.body)
max_temp = 0.0
min_temp = 200.0
daily_list = body["list"].first(8)
snow = false
rain = false

daily_list.each{ |temp|
  min_temp = temp["main"]["temp_min"] if temp["main"]["temp_min"] < min_temp
  max_temp = temp["main"]["temp_max"] if temp["main"]["temp_max"] > max_temp
  snow = true if temp["weather"][0]["description"].include? "snow"
  rain = true if temp["weather"][0]["description"].include? "rain"
}

isSnow = "Its going to snow" if snow
isRain = "Its going to Rain" if rain
temperature = "Max temp: #{max_temp}, Min temp: #{min_temp}, #{isSnow} #{isRain}"

Party.post("/1/messages.json",
:query => {
  :token => ENV['TOKEN'],
  :user => ENV['USER'],
  :message => temperature,
  :title => 'Weather'
})

Party.post("/1/messages.json",
:query => {
  :token => ENV['TOKEN'],
  :user => ENV['USER'],
  :message => temperature,
  :title => 'Weather'
})
