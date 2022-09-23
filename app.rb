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
require 'bcrypt'

DatabaseConnection.connect('makersbnb_test')


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    repo = SpaceRepository.new
    @spaces = repo.all
    if session[:user_id] != nil
      @session = session[:user_id]
    end
    return erb(:index)
  end

  get '/account' do 
    if session[:user_id] != nil
      @session = session[:user_id]
    else
      return redirect('/login')
    end

    if session[:user_id] == nil
      return redirect('/login')
    else
      space_repo = SpaceRepository.new
      booking_repo = BookingRepository.new
      user_repo = UserRepository.new
      @user = user_repo.find_by_user_id(session[:user_id])
      @user_spaces = space_repo.find_by_user_id(session[:user_id])
      @user_booking_requests = []
      result_set = booking_repo.find_by_user_id(session[:user_id])
      result_set.each do |booking|
        @user_booking_requests << space_repo.find_by_id(booking.space_id)
      end
      return erb(:account)
    end
  end

  post '/add_space' do
    space = Space.new
    space.user_id = session[:user_id]
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


  get '/space/:id' do
    repo = SpaceRepository.new
    @space = repo.find_by_id_with_dates(params[:id])
    user_repo = UserRepository.new
    @host = user_repo.find_by_id(@space.user_id)
    if session[:user_id] != nil
      @session = session[:user_id]
    end
    return erb(:space)
  end

  post '/book_space' do
    if session[:user_id] != nil
      @session = session[:user_id]
    end
    booking = Booking.new
    booking.date_id = params[:date]
    booking.user_id = session[:user_id]
    booking.space_id = params[:space_id]
    booking.confirmed = false
    repo = BookingRepository.new
    repo.create(booking)
    return erb(:request_sent)

  end

  get '/login' do
    if session[:user_id] != nil
      @session = session[:user_id]
    end
    if params[:error] == 'credentials_wrong'
      @error = true
    end
    return erb(:login)
  end

  post '/login' do
    if session[:user_id] != nil
      @session = session[:user_id]
    end
    repo = UserRepository.new
    result = repo.sign_in(params[:email], params[:password])
    if result == "successful"
      user = repo.find_by_email(params[:email])
      session[:user_id] = user.id
      redirect '/'
    else
      redirect '/login?error=credentials_wrong'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      @session = session[:user_id]
    end
    session.clear
    redirect '/'
  end
end
