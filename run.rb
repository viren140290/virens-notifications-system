require 'sinatra'
require 'httparty'
require 'pry'
require 'active_record'
# This is just a simple HTTP library which gives methods for HTTP verbs like `GET` and `POST`.
class Party
  include HTTParty
  base_uri ENV['PUSHOVER_API']
end

get '/test' do
  content_type :json
  { :test => 'test' }.to_json
end

post '/viren' do
  content_type :json

    val = Party.post("/1/messages.json",
    :query => {
      :token => ENV['TOKEN'],
      :user => ENV['USER'],
      :message => JSON.parse(request.body.read)['password'],
      :title => 'Hello'
      }
    )
    { :test => val['status'] }.to_json
end

post '/instagram' do
  content_type :json

    val = Party.post("/1/messages.json",
    :query => {
      :token => ENV['TOKEN'],
      :user => ENV['USER'],
      :message => JSON.parse(request.body.read)['password'],
      :title => 'Hello'
      }
    )
    { :test => val['status'] }.to_json
end
