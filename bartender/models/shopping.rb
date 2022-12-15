def add_to_shopping_list(user_id, recipe_id)
  results = get_recipe(recipe_id)

  ingredients = JSON.parse results['ingredients']
  amts = JSON.parse results['ingredients_amt']

  shopping_list = Hash[ingredients.values.zip(amts.values)]
  shopping_list_json = JSON.generate shopping_list

  run_sql("INSERT INTO shopping_lists(user_id, shopping_list) VALUES ($1, $2)", [user_id, shopping_list_json])
end

def get_shopping_list(user_id)
  results = run_sql("SELECT shopping_list FROM shopping_lists WHERE user_id = $1", [user_id])

  shopping_lists = []

  results.each do |list|
    list.values.each do |value|
      shopping_lists.push JSON.parse(value)
    end
  end
  shopping_lists
end

def clear_shopping_list()
  user_id = session['user_id']

  run_sql("DELETE FROM shopping_lists WHERE user_id = $1", [user_id])
end