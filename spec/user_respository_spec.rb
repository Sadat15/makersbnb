require 'user'
require 'user_repository'
require_relative './reset_tables'

describe UserRepository do
  before(:each) do
    ResetTables.new.reset
  end

  it '#all finds all users' do
    repo = UserRepository.new
    users = repo.all
    
    expect(users.length).to eq()
    expect(users.first.id).to eq()
    expect(users.first.name).to eq()
    expect(users.first.email).to eq()
    expect(users.first.password).to eq(# encrypted password)
  end

  it '#find finds one user specified by email' do
    repo = UserRepository.new    
    user = repo.find_by_email()
    
    expect(user.id).to eq()
    expect(user.name).to eq()
    expect(user.email).to eq()
    expect(user.password).to eq(# encrypted password)
  end

  it '#create creates a user' do
    repo = UserRepository.new
    user = User.new
    user.name = ()
    user.email = ()
    user.password = ()
    repo.create(user)
    users = repo.all

    expect(users.length).to eq()
    expect(users.last.id).to eq()
    expect(users.last.name).to eq()
    expect(users.last.email).to eq()
    expect(users.last.password).not_to eq()
  end

  it '#sign_in confirms user submitted password is valid (via BCrypt) based on encrypted password in database' do
    repo = UserRepository.new    
    user = User.new
    user.name = ()
    user.email = ()
    user.password = ()
    repo.create(user)
    result = repo.sign_in(user.email, user.password)

    expect(result).to eq("successful")
  end
end
