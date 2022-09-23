# this class is to reset the tables in the test database
# tests to be run on macOS only
class ResetTables
  def reset
    seed_sql = File.read('spec/seeds/seeds.sql')
    connection = PG.connect({ 
      host: '127.0.0.1',
      dbname: 'makersbnb_test'
    })
    connection.exec(seed_sql)
  end
end
