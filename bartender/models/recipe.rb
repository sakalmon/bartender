def all_recipes
  results = run_sql("SELECT * FROM recipes")

  # results.each do |result|
    
  # end

  # recipes.push {
  #   "name" => results[0]['name'],
  #   "instructions" => results[0]['instructions'],
  #   "ingredients" => results[0]['ingredients'],
  #   "ingredients_amt" => results[0]['ingredients_amt'],
  #   "image_url" => results[0]['image_url']
  # }

  # ingredients = JSON.parse recipe['ingredients']
  # ingredients_amt = JSON.parse recipe['ingredients_amt']
end

def generate_data
  data = HTTParty.get("http://www.thecocktaildb.com/api/json/v1/#{ENV['API_KEY']}/search.php?s=margarita").parsed_response

  drinks = []

  drinks_data = data['drinks']

  drinks_data.each do |drink_data|
    ingredients = {}
    ingredients_amt = {}

    name = drink_data['strDrink']
    instructions = drink_data['strInstructions']
    image_url = drink_data['strDrinkThumb']
    
    drink_data.each_pair do |key, val|
      if key.include?('Ingredient')
        ingredients[key] = val
      end
      if key.include?('Measure')
        ingredients_amt[key] = val
      end
    end

    ingredients_json = JSON.generate(ingredients)
    ingredients_amt_json = JSON.generate(ingredients_amt)

    drink = {
      'name' => name,
      'ingredients' => ingredients_json,
      'ingredients_amt' => ingredients_amt_json,
      'instructions' => instructions,
      'image_url' => image_url
    }

    drinks.push(drink)
  end

  drinks.each do |drink|
    run_sql("INSERT INTO recipes(name, instructions, ingredients, ingredients_amt, image_url) VALUES ($1, $2, $3, $4, $5)", [drink['name'], drink['instructions'], drink['ingredients'], drink['ingredients_amt'], drink['image_url']])
  end
end