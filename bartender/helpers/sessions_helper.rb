def logged_in?
  if session['user_id']
    true
  else
    false
  end
end

def current_user
  if logged_in?
    find_user_by_id(session['user_id'])
  else
    nil
  end
end

def author?(recipe_id)
  user_id = session['user_id']

  puts "current user id: #{current_user['id']}, author id: #{recipe_id}"
  if current_user['id'] == recipe_id
    true
  else
    false
  end
end