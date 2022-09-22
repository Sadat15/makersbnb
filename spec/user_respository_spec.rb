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
    
    expect(users.length).to eq(3)
    expect(users.first.id).to eq('1')
    expect(users.first.name).to eq('Jonas')
    expect(users.first.email).to eq('jonas@somewhere.com')
    expect(users.first.password).to eq(
      '$2a$12$4V/xPwwTy/Y4itSd2GjY7OqmB4EN3z5p.JcWkBagoN2TUqjYeTGI6'
      )
  end

  it '#find finds one user specified by email' do
    repo = UserRepository.new    
    user = repo.find_by_email('anna@world.com')
    
    expect(user.id).to eq('2')
    expect(user.name).to eq('Anna')
    expect(user.email).to eq('anna@world.com')
    expect(user.password).to eq('$2a$12$YlqyPMdbTUMCOiISU834D.mXHMzrpBTIjDGbJwTAr5B/49ZViTAGK')
  end

  it '#create creates a user' do
    repo = UserRepository.new
    user = User.new
    user.name = ('Bob')
    user.email = ('bob@mortimer.com')
    user.password = ('password')
    repo.create(user)
    users = repo.all

    expect(users.length).to eq(4)
    expect(users.last.id).to eq('4')
    expect(users.last.name).to eq('Bob')
    expect(users.last.email).to eq('bob@mortimer.com')
    expect(users.last.password).not_to eq('password')
  end

  it '#sign_in confirms user submitted password is valid (via BCrypt) based on encrypted password in database' do
    repo = UserRepository.new    
    user = User.new
    user.name = ('Gary')
    user.email = ('gary@example.com')
    user.password = ('passowrd')
    repo.create(user)
    result = repo.sign_in(user.email, user.password)

    expect(result).to eq("successful")
  end
end
