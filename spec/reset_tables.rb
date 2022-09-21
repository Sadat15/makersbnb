# for now we need to run all tests on a macOS
# if running tests on a Linux system,
# we may need to update the the #reset method
# to take environment variables for the database access credentials
class ResetTables # for RSpec tests
  def reset
    seed_sql = File.read('spec/seeds/seeds.sql')

    connection = PG.connect({ 
      host: '127.0.0.1',
      dbname: 'makersbnb_test',
    })
    connection.exec(seed_sql)
  end
end
