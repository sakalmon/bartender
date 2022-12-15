def all_recipes
  run_sql("SELECT * FROM recipes ORDER BY id")
end

def all_recipes_with_likes
  run_sql("SELECT * FROM recipes LEFT JOIN (SELECT recipe_id, COUNT(*) AS likes FROM likes GROUP BY recipe_id) AS likes_count ON recipes.id = likes_count.recipe_id")
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

def new_recipe(name, instructions, ingredients, amounts, image_url)
  run_sql("INSERT INTO recipes(name, instructions, ingredients, ingredients_amt, image_url) VALUES ($1, $2, $3, $4, $5)", [name, instructions, ingredients, amounts, image_url])
end

def get_recipe(id)
  run_sql("SELECT * FROM recipes WHERE id = $1", [id])[0]
end

def update_recipe(id, name, ingredients_json, amts_json, instructions, image_url)
  run_sql("UPDATE recipes SET name = $2, ingredients = $3, ingredients_amt = $4, instructions = $5, image_url = $6 WHERE id = $1" , [id, name, ingredients_json, amts_json, instructions, image_url])
end

def delete_recipe(id)
  run_sql("DELETE FROM recipes WHERE id = $1", [id])
end

def search_recipe(query)
  data = HTTParty.get("http://www.thecocktaildb.com/api/json/v1/#{ENV['API_KEY']}/search.php?s=#{query}").parsed_response

  drinks = []

  drinks_data = data['drinks']

  if !drinks_data
    redirect '/'
  end
  
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

  recipes = drinks

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
  parsed_recipes
end

def like_recipe(user_id, recipe_id)
  run_sql("INSERT INTO likes(user_id, recipe_id) VALUES ($1, $2)", [user_id, recipe_id])
end

def get_likes(recipe_id)
  run_sql("SELECT COUNT(*) FROM likes WHERE recipe_id = $1", [recipe_id])
end