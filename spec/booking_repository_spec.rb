require "booking_repository.rb" 
def reset_tables
  seed_sql = File.read('spec/seeds/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test'})
  connection.exec(seed_sql)
end
  
describe BookingRepository do 
  before(:each) do 
    reset_tables
  end

  it "finds booking by its id" do
    repo = BookingRepository.new
    result = repo.find_by_id('1')
    expect(result.id).to eq '1'
    expect(result.date).to eq '2022-10-05'
    expect(result.user_id).to eq '1'
    expect(result.space_id).to eq '1'
    expect(result.confirmed).to eq true
  end

  it "finds booking by its user_id" do
    repo = BookingRepository.new
    result_set = repo.find_by_user_id('1')
    expect(result_set.first.id).to eq '1'
    expect(result_set.first.date).to eq '2022-10-05'
    expect(result_set.first.user_id).to eq '1'
    expect(result_set.first.space_id).to eq '1'
    expect(result_set.first.confirmed).to eq true
  end

  it "finds booking by its space_id" do
    repo = BookingRepository.new
    result_set = repo.find_by_space_id('1')
    expect(result_set.first.id).to eq '1'
    expect(result_set.first.date).to eq '2022-10-05'
    expect(result_set.first.user_id).to eq '1'
    expect(result_set.first.space_id).to eq '1'
    expect(result_set.first.confirmed).to eq true
    end

  it "creates a new booking" do
    repo = BookingRepository.new
    booking = Booking.new
    booking.user_id = '2'
    booking.space_id = '2'
    booking.date = '2022-10-25'
    repo.create(booking)
    result = repo.find_by_user_id('2')
    expect(result.length).to eq 2
    expect(result.last.confirmed).to be false
    expect(result.last.date).to eq '2022-10-25'
  end

  it "changes the booking status to confirmed" do
    repo = BookingRepository.new
    result_before = repo.find_by_id('3')
    repo.confirm('3')
    result_after = repo.find_by_id('3')
    expect(result_before.confirmed).to eq false
    expect(result_after.confirmed).to eq true
  end
end
