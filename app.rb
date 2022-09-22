require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user'
require_relative 'lib/user_repository'
require_relative 'lib/space'
require_relative 'lib/space_repository'
require_relative 'lib/booking'
require_relative 'lib/booking_repository'
require_relative 'lib/database_connection'
require 'bcrypt'

DatabaseConnection.connect('makersbnb_test')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:index)
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    repo = UserRepository.new
    user = User.new

    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]
    
    repo.create(user)

    return nil

    redirect_to '/login'

  end  

  get '/login' do
    return erb(:login)
  end

end
