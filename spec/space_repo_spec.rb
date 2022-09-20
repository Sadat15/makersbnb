require 'space_repository'
require 'database_connection'
require_relative './reset_tables'

describe SpaceRepository do 
  before(:each) do
    ResetTables.new.reset
  end

  it "lists all available spaces" do
    repo = SpaceRepository.new
    spaces = repo.all
    expect(spaces.first.id).to eq 1
    expect(spaces.first.user_id).to eq ''
    expect(spaces.first.date_range).to eq ''
    expect(spaces.length).to eq ''
  end

  it "creates a new space" do
    repo = SpaceRepository.new
    space = Space.new
    space.user_id = '1'
    space.name = 'Cabin in the Woods'
    space.description = "A lovely, cozy place."
    space.price_per_night = '100'
    space.date_range = '[2022-10-10, 2022-11-05)'
    repo.add(space)
    expect(repo.all.length).to eq ''
    expect(repo.all.last.name).to eq "Cabin in the Woods"
    expect(repo.all.last.date_range).to eq '[2022-10-10, 2022-11-05)'
  end

  it "finds the space by its id" do
    repo = SpaceRepository.new
    space = repo.find_by_id('1')
    expect(space.id).to eq '1'
    expect(space.name).to eq ''
    expect(space.date_range).to eq ''
  end

  it "deletes the space by its id" do
    repo = SpaceRepository.new
    repo.delete('1')
    expect(repo.all.length).to eq
    expect(repo.all.first.id).to eq '2'
    expect(repo.all.first.name).to eq ''
  end

  it "updates the date range of a given space" do
    repo = SpaceRepository.new
    repo.update_avail('1', '2022-10-12')
    space = repo.find_by_id('1')
    expect(space.date_range).to eq
  end
end

