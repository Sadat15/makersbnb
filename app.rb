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

  get '/space/:id' do
    repo = SpaceRepository.new
    @space = repo.find_by_id(params[:id])
    return erb(:space)
  end

  post '/book_space' do
    booking = Booking.new
    booking.date = params[:date]
    booking.user_id = session[:user_id]
    booking.space_id = params[:space_id]
    booking.confirmed = false
    repo = BookingRepository.new
    repo.create(booking)
    return erb(:request_sent)
  end

end