
require_relative './database_connection'
require_relative './booking'


class BookingRepository

  def to_boolean(str)
    return true if str == 't'
    return false if str == 'f'
  end
  
  def find_by_id(id)
    sql = 'SELECT bookings.id AS booking_id, user_id, space_id, confirmed, date_id, dates.date FROM bookings JOIN dates ON dates.id = bookings.date_id WHERE bookings.id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    booking = Booking.new    
    booking.date = result_set[0]['date']
    booking.date_id = result_set[0]['date_id']
    booking.id = result_set[0]['booking_id']
    booking.user_id = result_set[0]['user_id']
    booking.space_id = result_set[0]['space_id']
    booking.confirmed = to_boolean(result_set[0]['confirmed'])

    return booking
  end

  def find_by_user_id(user_id)
    sql = 'SELECT bookings.id AS booking_id, user_id, space_id, confirmed, date_id, dates.date FROM bookings JOIN dates ON dates.id = bookings.date_id WHERE bookings.user_id = $1;'
    sql_params = [user_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    all_bookings = []
    result_set.each do |record|
      booking = Booking.new      
      booking.date = record['date']
      booking.date_id = record['date_id']
      booking.id = record['booking_id']
      booking.user_id = record['user_id']
      booking.space_id = record['space_id']
      booking.confirmed = to_boolean(record['confirmed'])

      all_bookings << booking
    end
    return all_bookings
  end

  def find_by_space_id(space_id)
    sql = 'SELECT bookings.id AS booking_id, user_id, space_id, confirmed, date_id, dates.date FROM bookings JOIN dates ON dates.id = bookings.date_id WHERE bookings.space_id = $1;'
    sql_params = [space_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    all_bookings = []
    result_set.each do |record|
      booking = Booking.new
      booking.date = record['date']
      booking.date_id = record['date_id']
      booking.id = record['booking_id']
      booking.user_id = record['user_id']
      booking.space_id = record['space_id']
      booking.confirmed = to_boolean(record['confirmed'])

      all_bookings << booking
    end
    return all_bookings
  end

  def create(booking)
    sql = 'INSERT INTO bookings (date_id, user_id, space_id, confirmed) VALUES ($1, $2, $3, $4);'
    sql_params = [booking.date_id, booking.user_id, booking.space_id, false]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def confirm(booking_id)
    sql = "UPDATE bookings SET confirmed = true WHERE bookings.id = $1;"
    sql_params = [booking_id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
