require 'sinatra'
require 'httparty'

get '/' do
  data = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita').parsed_response
  p data['drinks'][0]
  erb :index
end





