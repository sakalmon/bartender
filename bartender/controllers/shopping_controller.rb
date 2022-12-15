get '/shopping' do
  if !logged_in?
    redirect '/sessions/new'
  end

  user_id = session['user_id']

  shopping_lists = get_shopping_list(user_id)

  erb :'/shopping/index', locals: {
    shopping_lists: shopping_lists
  }
end

post '/shopping/:id' do
  if !logged_in?
    redirect '/sessions/new'
  end

  user_id = session['user_id']
  recipe_id = params['id']

  add_to_shopping_list(user_id, recipe_id)

  redirect '/shopping'
end