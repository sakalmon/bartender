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