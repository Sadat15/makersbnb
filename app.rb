require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  # ------------------
  # testing layout.erb
  # ------------------

  get '/index_test' do
    erb :index_test 
  end
  
  get '/layout_test' do
    erb :layout_test
  end
end
