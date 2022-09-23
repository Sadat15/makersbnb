require_relative 'user'
require 'bcrypt'

class UserRepository
  def all
    # Returns all user objects
    users = []
    sql = 'SELECT * FROM users;'
    params = [] 
    result_set = DatabaseConnection.exec_params(sql, params)

    result_set.each do |record|
      user = User.new
      user.id = record['id']
      user.name = record['name']
      user.email = record['email']
      user.password = record['password']

      users << user
    end

    return users
  end

  def find_by_user_id(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)

    user = User.new
    record = result_set[0]
    user.id = record['id']
    user.name = record['name']
    user.email = record['email']
    user.password = record['password']

    return user
  end

  def find_by_email(email)
    # Returns a specified user object
    sql = 'SELECT * FROM users WHERE email = $1;'
    params = [email]

    result_set = DatabaseConnection.exec_params(sql, params)

    if result_set.ntuples == 0
      return nil
    else
      user = User.new

      record = result_set[0]

      user.id = record['id']
      user.name = record['name']
      user.email = record['email']
      user.password = record['password']

      return user
    end
  end
    
  def find_by_id(id)
    # Returns a specified user object
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)

    if result_set.ntuples == 0
      return nil
    else
      user = User.new

      record = result_set[0]

      user.id = record['id']
      user.name = record['name']
      user.email = record['email']
      user.password = record['password']

      return user
    end
  end

  def create(user)
    # Creates new user and adds it to database
    # Returns nothing
    encrypted_password = BCrypt::Password.create(user.password)

<<<<<<< HEAD
    sql = 'INSERT INTO users (name, password, email) VALUES ($1, $2, $3);'
    params = [user.name, encrypted_password, user.email]
=======
    sql = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3)'
    params = [user.name, user.email, encrypted_password]
>>>>>>> 6cdd14b (Sign up page working)

    DatabaseConnection.exec_params(sql, params)

    return nil
  end

  def sign_in(submitted_email, submitted_password)
    user = find_by_email(submitted_email)

    return nil if user.nil?

    # user.password in next line is the encrypted password in the database
    hash_check = BCrypt::Password.new(user.password) 

    if hash_check == submitted_password      
      return "successful"
    else
      return "failure"
    end
  end
end
