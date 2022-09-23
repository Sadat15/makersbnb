# this class is to reset the tables in the test database
# tests to be run on macOS only
class ResetTables
  def reset
    seed_sql = File.read('spec/seeds/seeds.sql')
    connection = PG.connect({ 
      host: '127.0.0.1',
<<<<<<< HEAD
      dbname: 'makersbnb',
      # user: user,
      # password: password 
=======
      dbname: 'makersbnb_test'
>>>>>>> 7db085dfe66a41a722ff372a29cc2f7e9e52881c
    })
    connection.exec(seed_sql)
  end
end
