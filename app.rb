require 'sinatra/base'
require 'sinatra/reloader'
require 'date'
require_relative 'lib/user'
require_relative 'lib/user_repository'
require_relative 'lib/space'
require_relative 'lib/space_repository'
require_relative 'lib/booking'
require_relative 'lib/booking_repository'
require_relative 'lib/database_connection'

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

  get '/account' do 
    # if session[:user_id] == nil
    #   return redirect('/login')
    # else
      session[:user_id]= 1
      space_repo = SpaceRepository.new
      booking_repo = BookingRepository.new
      user_repo = UserRepository.new
      @user = user_repo.find_by_user_id(session[:user_id])
      @user_spaces_with_dates = space_repo.find_by_user_id_with_dates(session[:user_id])
      @user_spaces_without_dates = space_repo.find_by_user_id(session[:user_id])
      @user_booking_requests = []
      result_set = booking_repo.find_by_user_id(session[:user_id])
      result_set.each do |booking|
        @user_booking_requests << space_repo.find_by_id(booking.space_id)
      end


      return erb(:account)
    # end
  end

  post '/add_space' do
    space = Space.new
    space.user_id = 1
    space.name = params[:name]
    space.description = params[:description]
    space.price_per_night = params[:price_per_night]
    repo = SpaceRepository.new
    repo.create(space)
    
    redirect '/account'
  end
 
  post '/update_dates' do
    space_id = params[:space]
    dates_array = params[:dates].split(",")
    dates = []
    dates_array.each do |date|
      dates << Date.strptime(date, '%m/ %d/ %Y').strftime('%Y-%m-%d').tr('"', "'") 
    end
    
    repo = SpaceRepository.new
    repo.add_available_dates(space_id, dates)
    redirect '/account'
  end

  

  get '/space/:id' do
    repo = SpaceRepository.new
    @space = repo.find_by_id_with_dates(params[:id])
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
