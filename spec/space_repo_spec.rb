require 'space_repository'
require 'database_connection'

describe SpaceRepository do 
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

  # find(id)
  # delete space
  # date_range(update) *sql query*
  
end

