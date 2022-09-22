require_relative './database_connection'
require_relative './space'


class SpaceRepository

  def all
    sql = 'SELECT * FROM spaces;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_spaces = []
    result_set.each do |record|
      space = Space.new
      space.id = record['id']
      space.user_id = record['user_id']
      space.description = record['description']
      space.name = record['name']
      space.price_per_night = record['price_per_night']
      space.dates = record['dates']

      all_spaces << space
    end
    return all_spaces
  end

  def add(space)
    sql = 'INSERT INTO spaces (user_id, description, name, price_per_night, dates) VALUES ($1, $2, $3, $4, $5)'
    sql_params = [space.user_id, space.description, space.name, space.price_per_night, space.dates]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def find_by_id(id)
    sql = 'SELECT * FROM spaces WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
    space = Space.new
    space.id = result_set[0]['id']
    space.user_id = result_set[0]['user_id']
    space.name = result_set[0]['name']
    space.description = result_set[0]['description']
    space.price_per_night = result_set[0]['price_per_night']
    space.dates = result_set[0]['dates']
    return space
  end

  def find_by_user_id(user_id)
    sql = 'SELECT * FROM spaces WHERE user_id = $1;'
    sql_params= [user_id]
    spaces = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    result_set.each do |row|
      space = Space.new
      space.id = row['id']
      space.user_id = row['user_id']
      space.name = row['name']
      space.description = row['description']
      space.price_per_night = row['price_per_night']
      space.dates = row['dates']

      spaces << space
    end
    return spaces
  end

  def delete(id)
    sql = 'DELETE FROM spaces WHERE id = $1;'
    DatabaseConnection.exec_params(sql, [id])
    return nil
  end

  def update_avail(id, date)
    # need to do!
    return nil
  end
end