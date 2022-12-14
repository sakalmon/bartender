require 'sinatra'
require 'httparty'
require 'pg'
require './db/db'
require 'dotenv/load'
require 'json'
require './models/recipe'
require './models/users'
require 'bcrypt'
require './helpers/sessions_helper'

enable :sessions

get '/' do
  recipes = all_recipes()
  parsed_recipes = []

  recipes.each do |recipe|
    drink = {}
    recipe.each_pair do |key, val|
      if key == 'ingredients' || key == 'ingredients_amt'
        drink[key] = JSON.parse val
      else
        drink[key] = val
      end
    end
    parsed_recipes.push drink
  end

  erb :index, locals: {
    recipes: parsed_recipes
  }
end

get '/recipes/new' do
  if !logged_in?
    redirect '/'
  end

  erb :'recipes/new'
end

post '/recipes' do
  if !logged_in?
    redirect '/'
  end

  name = params['name']

  ingredient_1 = params['ingredient-1']
  ingredient_2 = params['ingredient-2']
  ingredient_3 = params['ingredient-3']
  ingredient_4 = params['ingredient-4']
  ingredient_5 = params['ingredient-5']

  amt_1 = params['amt-1']
  amt_2 = params['amt-2']
  amt_3 = params['amt-3']
  amt_4 = params['amt-4']
  amt_5 = params['amt-5']

  instructions = params['instructions']

  image_url = params['image-url']

  ingredients = {
    'ingredient_1' => ingredient_1,
    'ingredient_2' => ingredient_2,
    'ingredient_3' => ingredient_3,
    'ingredient_4' => ingredient_4,
    'ingredient_5' => ingredient_5
  }

  ingredients_json = JSON.generate(ingredients)

  amts = {
    'amt_1' => amt_1,
    'amt_2' => amt_2,
    'amt_3' => amt_3,
    'amt_4' => amt_4,
    'amt_5' => amt_5
  }

  amts_json = JSON.generate(amts)

  run_sql("INSERT INTO recipes(name, instructions,
    ingredients,
    ingredients_amt,
    image_url) VALUES ($1, $2, $3, $4, $5)", [name, instructions, ingredients_json, amts_json, image_url])

  redirect '/'
end

get '/recipes/:id/edit' do
  if !logged_in?
    redirect '/'
  end

  id = params['id']
  recipe = get_recipe(id)

  ingredients = JSON.parse recipe['ingredients']
  amts = JSON.parse recipe['ingredients_amt']  

  if ingredients['ingredient_1']
    ingredient_1 = ingredients['ingredient_1']
    ingredient_2 = ingredients['ingredient_2']
    ingredient_3 = ingredients['ingredient_3']
    ingredient_4 = ingredients['ingredient_4']
    ingredient_5 = ingredients['ingredient_5']
    amt_1 = amts['amt_1']
    amt_2 = amts['amt_2']
    amt_3 = amts['amt_3']
    amt_4 = amts['amt_4']
    amt_5 = amts['amt_5']
  else
    ingredient_1 = ingredients['strIngredient1']
    ingredient_2 = ingredients['strIngredient2']
    ingredient_3 = ingredients['strIngredient3']
    ingredient_4 = ingredients['strIngredient4']
    ingredient_5 = ingredients['strIngredient5']
    amt_1 = amts['strMeasure1']
    amt_2 = amts['strMeasure2']
    amt_3 = amts['strMeasure3']
    amt_4 = amts['strMeasure4']
    amt_5 = amts['strMeasure5']
  end

  erb :'recipes/edit', locals: {
    recipe: recipe,
    ingredient_1: ingredient_1,
    ingredient_2: ingredient_2,
    ingredient_3: ingredient_3,
    ingredient_4: ingredient_4,
    ingredient_5: ingredient_5,
    amt_1: amt_1,
    amt_2: amt_2,
    amt_3: amt_3,
    amt_4: amt_4,
    amt_5: amt_5,
  }  
end

put '/recipes/:id' do
  if !logged_in?
    redirect '/'
  end

  id = params['id']
  name = params['name']

  ingredient_1 = params['ingredient-1']
  ingredient_2 = params['ingredient-2']
  ingredient_3 = params['ingredient-3']
  ingredient_4 = params['ingredient-4']
  ingredient_5 = params['ingredient-5']

  amt_1 = params['amt-1']
  amt_2 = params['amt-2']
  amt_3 = params['amt-3']
  amt_4 = params['amt-4']
  amt_5 = params['amt-5']

  instructions = params['instructions']
  
  image_url = params['image_url']

  ingredients = {
    'ingredient_1' => ingredient_1,
    'ingredient_2' => ingredient_2,
    'ingredient_3' => ingredient_3,
    'ingredient_4' => ingredient_4,
    'ingredient_5' => ingredient_5,
  }

  ingredients_json = JSON.generate(ingredients)

  amts = {
    'amt_1' => amt_1,
    'amt_2' => amt_2,
    'amt_3' => amt_3,
    'amt_4' => amt_4,
    'amt_5' => amt_5,
  }

  amts_json = JSON.generate(amts)

  update_recipe(id, name, ingredients_json, amts_json, instructions, image_url)

  redirect '/'
end

delete '/recipes/:id' do
  if !logged_in?
    redirect '/'
  end

  id = params['id']
  delete_recipe(id)

  redirect '/'
end

get '/users/new' do
  erb :'users/new'
end

post '/users' do
  first_name = params['first-name']
  last_name = params['last-name']
  email = params['email']
  password = params['password']

  new_user(first_name, last_name, email, password)

  redirect '/'
end

get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  email = params['email']
  password = params['password']

  user = find_user_by_email(email)

  if user && BCrypt::Password.new(user['password_digest']) == password
    session['user_id'] = user['id']

    redirect '/'
  else
    redirect '/sessions/new'
  end
end

delete '/sessions' do
  session['user_id'] = nil

  redirect '/'
end

get '/recipes/search_results' do
  query = params['query']

  results = search_recipe(query)

  erb :'/recipes/search_results', locals: {
    recipes: results
  }
end