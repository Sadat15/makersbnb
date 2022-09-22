require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user'
require_relative 'lib/user_repository'
require_relative 'lib/space'
require_relative 'lib/space_repository'
require_relative 'lib/booking'
require_relative 'lib/booking_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('makersbnb')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    repo = SpaceRepository.new
    @spaces = repo.all
    return erb(:index)
  end

  get '/account' do 
    # if session[:user_id] == nil
    #   return redirect('/login')
    # else

      # space_repo = SpaceRepository.new
      # booking_repo = BookingRepository.new
      # user_repo = UserRepository.new
      # @user = user_repo.find_by_user_id(session[:user_id])
      # @user_spaces = space_repo.find_by_user_id(session[:user_id])
      # @user_booking_requests = booking_repo.find_by_user_id(session[:user_id])
      
      return erb(:account)
    # end
  end

  post '/add_space' do
    # space = Space.new
    # space.user_id = session[:user_id]
    # space.name = params[:name]
    # space.description = params[:description]
    # space.price_per_night = params[:price_per_night]
    # dates = params[:dates]

    # repo = SpaceRepository.new
    # repo.add(space)
    # redirect '/account'
    
    redirect '/account'
  end

end
