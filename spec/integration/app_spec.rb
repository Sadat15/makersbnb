require './app'
require "rack/test"

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
      expect(response.body).to include('<a href="/login"><button>Log in/Log out</button></a>')
      expect(response.body).to include('<a href="/signup"><button>Sign up</button></a>')
    end
  end

  context 'GET /space/:id' do
    it "should return a space listing by finding the id" do
      response = get('/space/1')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>House by 2</h1>')
      expect(response.body).to include('<p>Description: Lovely house at the seaside</p>')
      expect(response.body).to include('<p>Price per night: £80</p>')
      expect(response.body).to include('<p>Dates available: 2022-10-05, 2022-10-07, 2022-11-15</p>')
    end
  end 

  context 'POST /book_space' do
    it "should return a page that tells you the booking request was successful" do
      response = post('/book_space', date: '2022-10-05', user_id: 1, space_id: 1)
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Booking request sent successfully. Please await confirmation by the host.</p>')
    end
  end
end
