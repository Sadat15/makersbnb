

class ResetTables # for RSpec tests
  def reset
    seed_sql = File.read('spec/seeds/seeds.sql')
    # non Mac OS users may need these 2 env variables
    # user = ENV['PGUSER1']
    # password = ENV['PGPASSWORD']
    connection = PG.connect({ 
      host: '127.0.0.1',
      dbname: 'makersbnb',
      user: user,
      password: password 
    })
    connection.exec(seed_sql)
  end
end

