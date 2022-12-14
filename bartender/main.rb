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
  # data = HTTParty.get("http://www.thecocktaildb.com/api/json/v1/#{ENV['API_KEY']}/search.php?s=margarita").parsed_response

  # # Generate sample recipe
  # first_drink = data['drinks'][0]
  # first_drink_ingredients = {}
  # first_drink_ingredients_amt = {}

  # first_drink.each_pair do |key, val|
  #   if key.include?('ingredient')
  #     first_drink_ingredients[key] = val 
  #   end
  # end

  # first_drink.each_pair do |key, val|
  #   if key.include?('measure')
  #     first_drink_ingredients_amt[key] = val 
  #   end
  # end

  # ingredients = first_drink_ingredients.to_s.gsub('=>', ':')
  # ingredients = ingredients.gsub('nil', 'null')
  # ingredients_amt = first_drink_ingredients_amt.to_s.gsub('=>', ':')
  # ingredients_amt = ingredients_amt.gsub('nil', 'null')

  # run_sql("INSERT INTO recipes(name, instructions,
  #   ingredients,
  #   ingredients_amt,
  #   image_url) VALUES ($1, $2, $3, $4, $5)", [first_drink['strDrink'], first_drink['strInstructions'], ingredients, ingredients_amt, first_drink['strDrinkThumb']])

  # results = run_sql("SELECT * FROM recipes")

  # recipe = {
  #   "name" => results[0]['name'],
  #   "instructions" => results[0]['instructions'],
  #   "ingredients" => results[0]['ingredients'],
  #   "ingredients_amt" => results[0]['ingredients_amt'],
  #   "image_url" => results[0]['image_url']
  # }

  # ingredients = JSON.parse recipe['ingredients']
  # ingredients_amt = JSON.parse recipe['ingredients_amt']

  # run_sql("INSERT INTO recipes(name, instructions, ingredient_1, ingredient_2, ingredient_3, ingredient_4, ingredient_5, ingredient_6, ingredient_7, ingredient_8, ingredient_9, ingredient_10, ingredient_11, ingredient_12, ingredient_13, ingredient_14, ingredient_15, ingredient_1_amt, ingredient_2_amt, ingredient_3_amt, ingredient_4_amt, ingredient_5_amt, ingredient_6_amt, ingredient_7_amt, ingredient_8_amt, ingredient_9_amt, ingredient_10_amt, ingredient_11_amt, ingredient_12_amt, ingredient_13_amt, ingredient_14_amt, ingredient_15_amt, image_url) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33)", [first_drink['strDrink'], first_drink['strInstructions'], first_drink['strIngredient1'], first_drink['strIngredient2'], first_drink['strIngredient3'], first_drink['strIngredient4'], first_drink['strIngredient5'], first_drink['strIngredient6'], first_drink['strIngredient7'], first_drink['strIngredient8'], first_drink['strIngredient9'], first_drink['strIngredient10'], first_drink['strIngredient11'], first_drink['strIngredient12'], first_drink['strIngredient13'], first_drink['strIngredient14'], first_drink['strIngredient15'], first_drink['strMeasure1'], first_drink['strMeasure2'], first_drink['strMeasure3'], first_drink['strMeasure4'], first_drink['strMeasure5'], first_drink['strMeasure6'], first_drink['strMeasure7'], first_drink['strMeasure8'], first_drink['strMeasure9'], first_drink['strMeasure10'], first_drink['strMeasure11'], first_drink['strMeasure12'], first_drink['strMeasure13'], first_drink['strMeasure14'], first_drink['strMeasure15'], first_drink['strDrinkThumb']])

  # run_sql("INSERT INTO recipes(name, instructions,
  #   ingredients,
  #   ingredients_amt,
  #   image_url) VALUES ($1, $2, $3, $4, $5)", [first_drink['strDrink'], first_drink['strInstructions'], first_drink['strDrink'], first_drink['strDrink'], first_drink['strDrink']])

  # recipes = run_sql("SELECT * FROM recipes")

  recipes = all_recipes()
  p recipes

  # Generate sample data
  # generate_data()

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

  p parsed_recipes.length

  erb :index, locals: {
    recipes: parsed_recipes
  }

  # erb :index, locals: {
  #   recipes: recipes
  #   # ingredients: ingredients,
  #   # ingredients_amt: ingredients_amt
  # }
end

get '/recipes/new' do
  erb :'recipes/new'
end

post '/recipes' do
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