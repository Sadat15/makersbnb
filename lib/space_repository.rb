require_relative './database_connection'
require_relative 'space'

class SpaceRepository

  def all
    sql = 'SELECT * FROM spaces;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_spaces = []
    result_set.each do | record |
      space = Space.new
      space.id = record['id']
      space.user_id = record['user_id']
      space.description = record['description']
      space.name = record['name']
      space.price_per_night = record['price_per_night']
      space.date_range = record['date_range']

      all_spaces << space
    end

    return all_spaces

  end

  def add(space)
    sql = 'INSERT INTO spaces (user_id, description, name, price_per_night, date_range) VALUES ($1, $2, $3, $4, $5)'
    sql_params = [space.user_id, space.description, space.name, space.price_per_night, space.date_range]
    DatabaseConnection.exec_params(sql, sql_params)
  end

end