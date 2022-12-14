require 'dotenv/load'
require 'sinatra'
require 'bcrypt'
require 'httparty'
require 'pg'
require 'json'
require './db/db'

# Models
require './models/recipe'
require './models/user'

# Controllers
require './controllers/recipes_controller'
require './controllers/sessions_controller'
require './controllers/users_controller'

# Helpers
require './helpers/sessions_helper'

enable :sessions


