# Bartender
A full-stack web application that allows users to search for cocktail recipes as well as post their own.
## [Try out Bartender!](https://bartender.fly.dev/)
## :blue_book: Plan for developing the app
### 1. Features a user might want
* Search and view a recipe
* Create their own recipe
* Update a recipe
* Delete a recipe
* Signup/Login
* Like a recipe
* Save a recipe
* Add recipe ingredients to shopping list
### 2. Pages
* Home
* Signup
* Login
* Create recipe
* Edit recipe
* Search results for recipes
* Saved recipes
* Shopping list
### 3. Required Tasks
![Tasks](https://github.com/sakalmon/bartender/blob/main/Tasks.png)
### 4. Wireframes
#### Home Page - Logged In
![Home Page Wireframe Logged In](https://github.com/sakalmon/bartender/blob/main/Wireframe-Home-Page-Logged-In.png)
#### Home Page - Logged Out
![Home Page Wireframe Logged Out](https://github.com/sakalmon/bartender/blob/main/Wireframe-Home-Page-Logged-Out.png)
### 5. Deployment
The app is required to be hosted on the internet.
* App - Deploy to [Fly.io](https://fly.io/) using `flyctl deploy`
* Database tables - Connect and execute commands using `flyctl postgres connect -a [database]`
### 6. Things to watch out for
* Scope/feature creep
* Implementing overly ambitious features
* Committing private API keys to Github (don't do it!)
## Approach Taken
* Wireframe the desired app layout
* Write HTML structure using above wireframes
* Style the app just enough so that backend code can be developed and tested
* Implement backend features
* Finalise styling
* Deploy app
* Setup remote database
* Test app
## Entity Relationship Diagram
![ERD](https://github.com/sakalmon/bartender/blob/main/entity-relationship-diagram.png?raw=true)
## :rocket: Tecnologies Used
* TheCocktailDB API (HTTParty)
* Password hashing (Bcrypt)
* User sessions
* RDBMS (Postgresql)
* JSON for storing data
* Sinatra Web Framework (Ruby)
* Environment variable for API key
* [Fly.io](https://fly.io/) for hosting the app
* MVC structure
## :beetle: Bugs
* Error in console on pages where the search bar is missing (create recipe, shopping list, etc.). This is due to JS trying to add an event listener to the search bar but on some pages, the search bar is not present.
## :star: Future features
* Show the correct author and date of the recipe (using placeholders for now)
* Redirect the user to the saved recipes page when they save a recipe
* Un-like a recipe
* Un-save a recipe
* Account page for updating user details (email, password, etc.)
* Share a recipe
