require_relative './database_connection'
require_relative './space'

class SpaceRepository

  # this method doesn't return places that haven't got dates they are available
  def all_with_dates
    sql = 'SELECT spaces.id AS space_id, name, description, price_per_night, user_id, dates.id AS date_id, dates.date FROM spaces JOIN spaces_dates ON spaces.id = spaces_dates.space_id JOIN dates ON dates.id = spaces_dates.date_id;'
    result_set = DatabaseConnection.exec_params(sql, [])
    all_spaces = []
    result_set.each do |record|
      if all_spaces.any? { |space| space.id == record['space_id'] }
        all_spaces.map do |space|
          if space.id == record['space_id']
            space.dates[record['date_id']] = record['date']
          end
        end
      else
        space = Space.new
        space.id = record['space_id']
        space.user_id = record['user_id']
        space.description = record['description']
        space.name = record['name']
        space.price_per_night = record['price_per_night']
        space.dates = {record['date_id'] => record['date']}
        all_spaces << space
      end
      
    end
    return all_spaces
  end

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
      all_spaces << space
    end

    return all_spaces
  end

  def create(space)
    # create new space
    sql = 'INSERT INTO spaces (user_id, description, name, price_per_night) VALUES ($1, $2, $3, $4);'
    sql_params = [space.user_id, space.description, space.name, space.price_per_night]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def add_available_dates(space_id, dates)
    dates.each do |date|
      sql1 = 'SELECT dates.id FROM dates WHERE date = $1;'
      sql_params1 = [date]
      result_set = DatabaseConnection.exec_params(sql1, sql_params1)
      date_id = result_set[0]['id']
      sql2 = 'INSERT INTO spaces_dates (space_id, date_id) VALUES ($1, $2);'
      sql_params2 = [space_id, date_id]
      DatabaseConnection.exec_params(sql2, sql_params2)
    end
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
    return space
  end

  def find_by_id_with_dates(id)
    sql = 'SELECT spaces.id AS space_id, name, description, price_per_night, user_id, dates.id AS date_id, dates.date FROM spaces JOIN spaces_dates ON spaces.id = spaces_dates.space_id JOIN dates ON dates.id = spaces_dates.date_id WHERE spaces.id = $1;'
    result_set = DatabaseConnection.exec_params(sql, [id])
    space = Space.new
    space.id = result_set[0]['space_id']
    space.user_id = result_set[0]['user_id']
    space.name = result_set[0]['name']
    space.description = result_set[0]['description']
    space.price_per_night = result_set[0]['price_per_night']
    result_set.each do |record|
      space.dates[record['date_id']] = record['date']
    end
    return space
  end

  def find_by_user_id_with_dates(user_id)
    
    sql = 'SELECT spaces.id AS space_id, name, description, price_per_night, user_id, dates.id AS date_id, dates.date FROM spaces JOIN spaces_dates ON spaces.id = spaces_dates.space_id JOIN dates ON dates.id = spaces_dates.date_id WHERE spaces.user_id = $1;'
    
    sql_params= [user_id]
    spaces = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    result_set.each do |row|
      next if spaces.any? { |space| space.id == row['space_id'] }
      
      space = Space.new
      space.id = row['space_id']
      space.user_id = row['user_id']
      space.name = row['name']
      space.description = row['description']
      space.price_per_night = row['price_per_night']
      result_set.each do |record|
        space.dates[record['date_id']] = record['date']
      end
      spaces << space
    end
    return spaces
  end
  
  def find_by_user_id(user_id)
    
    sql = 'SELECT spaces.id AS space_id, name, description, price_per_night, user_id FROM spaces WHERE spaces.user_id = 1;'
    sql_params= [user_id]
    spaces = []
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    result_set.each do |row|
      space = Space.new
      space.id = row['space_id']
      space.user_id = row['user_id']
      space.name = row['name']
      space.description = row['description']
      space.price_per_night = row['price_per_night']
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
