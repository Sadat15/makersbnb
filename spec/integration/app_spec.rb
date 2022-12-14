require './app'
require 'rack/test'


def reset_tables
  seed_sql = File.read('spec/seeds/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test'})
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.

  before(:each) do 
    reset_tables
  end

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include("Flat in Central London")
      expect(response.body).to include("Room in terraced house")
      expect(response.body).to include("Lovely house at the seaside")
      expect(response.body).to include('<a href="/signup" class="btn btn-danger">Sign up</a>')
      expect(response.body).to include('<a href="/login" class="btn btn-danger">Log in</a>')

    end
  end

  # context 'GET /account' do
  #   it 'should return the account page' do
  #     response = get('/account')
  #     expect(response.status).to eq (200)
  #     expect(response.body).to include('<p>Lovely house at the seaside</p>')
  #   end
  # end

  context 'GET /space/:id' do
    it "should return a space listing by finding the id" do
      response = get('/space/1')
      expect(response.status).to eq 200
      expect(response.body).to include('<p>Description: Lovely house at the seaside</p>')
      expect(response.body).to include('<p>Price per night: £80</p>')
      expect(response.body).to include('Dates available:')
      expect(response.body).to include('2022-10-05')
    end
  end 

  context 'POST /book_space' do
    it "should return a page that tells you the booking request was successful" do
      response = post('/book_space', date: '14', user_id: 1, space_id: 1)
      expect(response.status).to eq(200)
      expect(response.body).to include('Booking request sent successfully. Please await confirmation by the host.')
    end
  end

  context 'GET /login' do
    it "displays a login page" do
      response = get('/login')
      expect(response.status).to eq 200
      expect(response.body).to include ("<form action='/login' method='POST'>")
      expect(response.body).to include ('<input type="email" class="form-control" name="email" placeholder="Enter email">')
      expect(response.body).to include ('<input type="password" class="form-control" name="password" placeholder="Password">')
    end
  end

  context 'POST /login' do
    it "sends and checks the login information" do
      response = post(
        '/login',
        email: 'jonas@somewhere.com',
        password: 'lovelyday'
        )
      follow_redirect!
      expect(last_response.status).to be 200
      expect(last_response.body).to include("Lovely house at the seaside")
      # expect(response.body).to include("Sign out")
    end
  end

  context 'GET /signup' do
    it 'should get the sign up page' do
      response = get('/signup')

      expect(response.status).to eq 200
      expect(response.body).to include('<form method="post" action="/signup">')
      expect(response.body).to include('<input type="text" class="form-control" name="name" placeholder="James Smith">')
      expect(response.body).to include('<input type="email" class="form-control" name="email" placeholder="james@makersbnb.com">')
      expect(response.body).to include('<input type="password" class="form-control" name="password" placeholder="Password">')

    end
  end
  
    context 'POST /signup' do
      it 'should add a new user to the database' do
        response = post('/signup',
        email: 'test@test.com',
        name: 'Lucy',
        password: '123456'
        )
  
        expect(response.status).to eq 200
        expect(response.body).to include('<p>Sign up was successful.</p>')
      end


    xit "sends and checks the login information" do
      response = post(
        '/login',
        email: 'jonas@somewhere.com',
        password: 'lovelyday123'
        )
      follow_redirect!
      expect(last_response.status).to be 200
      expect(last_response.body).to include("Error, please try again")
      expect(last_response.body).to include ("<input type='email' name='email' placeholder='Your email'>")
    end
  end

  context 'GET /logout' do
    it "logs a user out" do
      response1 = post(
        '/login',
        email: 'jonas@somewhere.com',
        password: 'lovelyday'
        )
      response2 = get('/logout')
      expect(response2.status).to be 302
    end
  end
end
