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

INSERT INTO recipes(
  name,
  instructions,
  ingredients,
  ingredients_amt,
  image_url)
  VALUES
    ('Margarita', 'Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.', '{"strIngredient1":"Tequila","strIngredient2":"Triple sec","strIngredient3":"Lime juice","strIngredient4":"Salt","strIngredient5":null,"strIngredient6":null,"strIngredient7":null,"strIngredient8":null,"strIngredient9":null,"strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null}', '{"strMeasure1":"1 1/2 oz ","strMeasure2":"1/2 oz ","strMeasure3":"1 oz ","strMeasure4":null,"strMeasure5":null,"strMeasure6":null,"strMeasure7":null,"strMeasure8":null,"strMeasure9":null,"strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null}', 'https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg'),
    ('Blue Margarita', 'Rub rim of cocktail glass with lime juice. Dip rim in coarse salt. Shake tequila, blue curacao, and lime juice with ice, strain into the salt-rimmed glass, and serve.', '{"strIngredient1":"Tequila","strIngredient2":"Blue Curacao","strIngredient3":"Lime juice","strIngredient4":"Salt","strIngredient5":null,"strIngredient6":null,"strIngredient7":null,"strIngredient8":null,"strIngredient9":null,"strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null}', '{"strMeasure1":"1 1/2 oz ","strMeasure2":"1 oz ","strMeasure3":"1 oz ","strMeasure4":"Coarse ","strMeasure5":null,"strMeasure6":null,"strMeasure7":null,"strMeasure8":null,"strMeasure9":null,"strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null}', 'https://www.thecocktaildb.com/images/media/drink/bry4qh1582751040.jpg'), 
    ('Tommy''s Margarita', 'Shake and strain into a chilled cocktail glass.', '{"strIngredient1":"Tequila","strIngredient2":"Lime Juice","strIngredient3":"Agave syrup","strIngredient4":null,"strIngredient5":null,"strIngredient6":null,"strIngredient7":null,"strIngredient8":null,"strIngredient9":null,"strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null}', '{"strMeasure1":"4.5 cl","strMeasure2":"1.5 cl","strMeasure3":"2 spoons","strMeasure4":null,"strMeasure5":null,"strMeasure6":null,"strMeasure7":null,"strMeasure8":null,"strMeasure9":null,"strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null}', 'https://www.thecocktaildb.com/images/media/drink/loezxn1504373874.jpg'),
    ('Whitecap Margarita', 'Place all ingredients in a blender and blend until smooth. This makes one drink.', '{"strIngredient1":"Ice","strIngredient2":"Tequila","strIngredient3":"Cream of coconut","strIngredient4":"Lime juice","strIngredient5":null,"strIngredient6":null,"strIngredient7":null,"strIngredient8":null,"strIngredient9":null,"strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null}', '{"strMeasure1":"1 cup ","strMeasure2":"2 oz ","strMeasure3":"1/4 cup ","strMeasure4":"3 tblsp fresh ","strMeasure5":null,"strMeasure6":null,"strMeasure7":null,"strMeasure8":null,"strMeasure9":null,"strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null}', 'https://www.thecocktaildb.com/images/media/drink/srpxxp1441209622.jpg'),
    ('Strawberry Margarita', 'Rub rim of cocktail glass with lemon juice and dip rim in salt. Shake schnapps, tequila, triple sec, lemon juice, and strawberries with ice, strain into the salt-rimmed glass, and serve.', '{"strIngredient1":"Strawberry schnapps","strIngredient2":"Tequila","strIngredient3":"Triple sec","strIngredient4":"Lemon juice","strIngredient5":"Strawberries","strIngredient6":"Salt","strIngredient7":null,"strIngredient8":null,"strIngredient9":null,"strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null}', '{"strMeasure1":"1/2 oz ","strMeasure2":"1 oz ","strMeasure3":"1/2 oz ","strMeasure4":"1 oz ","strMeasure5":"1 oz ","strMeasure6":null,"strMeasure7":null,"strMeasure8":null,"strMeasure9":null,"strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null}', 'https://www.thecocktaildb.com/images/media/drink/tqyrpw1439905311.jpg'),
    ('Smashed Watermelon Margarita', 'In a mason jar muddle the watermelon and 5 mint leaves together into a puree and strain. Next add the grapefruit juice, juice of half a lime and the tequila as well as some ice. Put a lid on the jar and shake. Pour into a glass and add more ice. Garnish with fresh mint and a small slice of watermelon.', '{"strIngredient1":"Watermelon","strIngredient2":"Mint","strIngredient3":"Grapefruit Juice","strIngredient4":"Lime","strIngredient5":"Tequila","strIngredient6":"Watermelon","strIngredient7":"Mint","strIngredient8":null,"strIngredient9":null,"strIngredient10":null,"strIngredient11":null,"strIngredient12":null,"strIngredient13":null,"strIngredient14":null,"strIngredient15":null}', '{"strMeasure1":"1/2 cup","strMeasure2":"5","strMeasure3":"1/3 Cup","strMeasure4":"Juice of 1/2","strMeasure5":"1 shot","strMeasure6":"Garnish with","strMeasure7":"Garnish with","strMeasure8":null,"strMeasure9":null,"strMeasure10":null,"strMeasure11":null,"strMeasure12":null,"strMeasure13":null,"strMeasure14":null,"strMeasure15":null}', 'https://www.thecocktaildb.com/images/media/drink/dztcv51598717861.jpg');

ALTER TABLE likes
ADD CONSTRAINT unique_likes
UNIQUE(user_id, recipe_id);

ALTER TABLE recipes
ADD COLUMN author_id INTEGER;