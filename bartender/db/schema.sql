CREATE DATABASE bartender_db;
\c bartender_db

CREATE TABLE recipes(
  id SERIAL PRIMARY KEY,
  name TEXT,
  instructions TEXT,
  ingredients JSON,
  ingredients_amt JSON,
  image_url TEXT
);

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  password_digest TEXT
);

CREATE TABLE likes(
  id SERIAL PRIMARY KEY,
  user_id INTEGER,
  recipe_id INTEGER
);