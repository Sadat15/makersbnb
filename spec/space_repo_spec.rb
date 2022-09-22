require 'space_repository'
require_relative './reset_tables'

describe SpaceRepository do 
  before(:each) do 
    ResetTables.new.reset
  end

  it "lists all available spaces" do
    repo = SpaceRepository.new
    spaces = repo.all
    expect(spaces.first.id).to eq '1'
    expect(spaces.first.user_id).to eq '2'
    expect(spaces.first.name).to eq 'House'
    expect(spaces.first.description).to eq 'Lovely house at the seaside'
    expect(spaces.first.price_per_night).to eq '80'
    expect(spaces.first.dates).to eq '{2022-10-05,2022-10-07,2022-11-15}'
    expect(spaces.length).to eq 3
  end

  it "creates a new space" do
    repo = SpaceRepository.new
    space = Space.new
    space.user_id = '1'
    space.name = 'Cabin in the Woods'
    space.description = "A lovely, cozy place."
    space.price_per_night = '100'
    space.dates = '{"2022-11-05", "2022-11-07"}'
    repo.add(space)
    expect(repo.all.length).to eq 4
    expect(repo.all.last.name).to eq "Cabin in the Woods"
    space.dates = '{"2022-11-05", "2022-11-07"}'
  end

  it "finds the space by its id" do
    repo = SpaceRepository.new
    space = repo.find_by_id('1')
    expect(space.id).to eq '1'
    expect(space.name).to eq 'House'
    expect(space.dates).to eq '{2022-10-05,2022-10-07,2022-11-15}'
  end

  it "deletes the space by its id" do
    repo = SpaceRepository.new
    repo.delete('1')
    expect(repo.all.length).to eq 2
    expect(repo.all.first.id).to eq '2'
    expect(repo.all.first.name).to eq 'Flat'
  end

  xit "updates the date range of a given space" do
    repo = SpaceRepository.new
    repo.update_avail('1', '???')
    space = repo.find_by_id('1')
    expect(space.dates).to eq
  end
end
