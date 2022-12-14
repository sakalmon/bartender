def new_user(first_name, last_name, email, password)
  password_digest = BCrypt::Password.create(password)

  run_sql("INSERT INTO users(first_name, last_name, email, password_digest) VALUES ($1, $2, $3, $4)", [first_name, last_name, email, password_digest])
end