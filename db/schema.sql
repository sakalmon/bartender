CREATE DATABASE bartender;
\c bartender

CREATE TABLE recipes(
  id SERIAL PRIMARY KEY,
  name TEXT,
  instructions TEXT,
  ingredient_1 TEXT,
  ingredient_2 TEXT,
  ingredient_3 TEXT,
  ingredient_4 TEXT,
  ingredient_5 TEXT,
  ingredient_6 TEXT,
  ingredient_7 TEXT,
  ingredient_8 TEXT,
  ingredient_9 TEXT,
  ingredient_10 TEXT,
  ingredient_11 TEXT,
  ingredient_12 TEXT,
  ingredient_13 TEXT,
  ingredient_14 TEXT,
  ingredient_15 TEXT,
  ingredient_1_amt TEXT,
  ingredient_2_amt TEXT,
  ingredient_3_amt TEXT,
  ingredient_4_amt TEXT,
  ingredient_5_amt TEXT,
  ingredient_6_amt TEXT,
  ingredient_7_amt TEXT,
  ingredient_8_amt TEXT,
  ingredient_9_amt TEXT,
  ingredient_10_amt TEXT,
  ingredient_11_amt TEXT,
  ingredient_12_amt TEXT,
  ingredient_13_amt TEXT,
  ingredient_14_amt TEXT,
  ingredient_15_amt TEXT,
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