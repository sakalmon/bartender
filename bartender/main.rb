require 'sinatra'
require 'httparty'
require 'pg'
require './db/db'

get '/' do
  data = HTTParty.get('http://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita').parsed_response

  # Generate sample recipe
  first_drink = data['drinks'][0]
  first_drink_ingredients = {}
  first_drink_ingredients_amt = {}

  first_drink.each_pair do |key, val|
    if key.start_with?('strIngredient')
      first_drink_ingredients[key] = val 
    end
  end

  first_drink.each_pair do |key, val|
    if key.start_with?('strMeasure')
      first_drink_ingredients_amt[key] = val 
    end
  end

  ingredients = first_drink_ingredients.to_s.gsub('=>', ':')
  ingredients = ingredients.gsub('nil', 'null')
  ingredients_amt = first_drink_ingredients_amt.to_s.gsub('=>', ':')
  ingredients_amt = ingredients_amt.gsub('nil', 'null')

  run_sql("INSERT INTO recipes(name, instructions,
    ingredients,
    ingredients_amt,
    image_url) VALUES ($1, $2, $3, $4, $5)", [first_drink['strDrink'], first_drink['strInstructions'], ingredients, ingredients_amt, first_drink['strDrinkThumb']])

  results = run_sql("SELECT * FROM recipes")

  recipe = {
    "name" => results[0]['name'],
    "instructions" => results[0]['instructions'],
    "ingredients" => results[0]['ingredients'],
    "ingredients_amt" => results[0]['ingredients_amt'],
    "image_url" => results[0]['image_url']
  }

  ingredients = JSON.parse recipe['ingredients']
  ingredients_amt = JSON.parse recipe['ingredients_amt']

  # run_sql("INSERT INTO recipes(name, instructions, ingredient_1, ingredient_2, ingredient_3, ingredient_4, ingredient_5, ingredient_6, ingredient_7, ingredient_8, ingredient_9, ingredient_10, ingredient_11, ingredient_12, ingredient_13, ingredient_14, ingredient_15, ingredient_1_amt, ingredient_2_amt, ingredient_3_amt, ingredient_4_amt, ingredient_5_amt, ingredient_6_amt, ingredient_7_amt, ingredient_8_amt, ingredient_9_amt, ingredient_10_amt, ingredient_11_amt, ingredient_12_amt, ingredient_13_amt, ingredient_14_amt, ingredient_15_amt, image_url) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33)", [first_drink['strDrink'], first_drink['strInstructions'], first_drink['strIngredient1'], first_drink['strIngredient2'], first_drink['strIngredient3'], first_drink['strIngredient4'], first_drink['strIngredient5'], first_drink['strIngredient6'], first_drink['strIngredient7'], first_drink['strIngredient8'], first_drink['strIngredient9'], first_drink['strIngredient10'], first_drink['strIngredient11'], first_drink['strIngredient12'], first_drink['strIngredient13'], first_drink['strIngredient14'], first_drink['strIngredient15'], first_drink['strMeasure1'], first_drink['strMeasure2'], first_drink['strMeasure3'], first_drink['strMeasure4'], first_drink['strMeasure5'], first_drink['strMeasure6'], first_drink['strMeasure7'], first_drink['strMeasure8'], first_drink['strMeasure9'], first_drink['strMeasure10'], first_drink['strMeasure11'], first_drink['strMeasure12'], first_drink['strMeasure13'], first_drink['strMeasure14'], first_drink['strMeasure15'], first_drink['strDrinkThumb']])

  # run_sql("INSERT INTO recipes(name, instructions,
  #   ingredients,
  #   ingredients_amt,
  #   image_url) VALUES ($1, $2, $3, $4, $5)", [first_drink['strDrink'], first_drink['strInstructions'], first_drink['strDrink'], first_drink['strDrink'], first_drink['strDrink']])

  # recipes = run_sql("SELECT * FROM recipes")
  # ingredients = 
  p ingredients
  erb :index, locals: {
    recipe: recipe,
    ingredients: ingredients,
    ingredients_amt: ingredients_amt
  }
end





