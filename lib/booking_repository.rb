require "booking"
require "database_connection"



class BookingRepository

  def to_boolean(str)
    return true if str == 't'
    return false if str == 'f'
  end
  
  def find_by_id(id)
    sql = 'SELECT * FROM bookings WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    booking = Booking.new
    booking.id = result_set[0]['id']
    booking.date = result_set[0]['date']
    booking.user_id = result_set[0]['user_id']
    booking.space_id = result_set[0]['space_id']
    booking.confirmed = to_boolean(result_set[0]['confirmed'])

    return booking
  end

  def find_by_user_id(user_id)
    sql = 'SELECT * FROM bookings WHERE user_id = $1;'
    sql_params = [user_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    all_bookings = []
    result_set.each do |record|
      booking = Booking.new
      booking.id = record['id']
      booking.date = record['date']
      booking.user_id = record['user_id']
      booking.space_id = record['space_id']
      booking.confirmed = to_boolean(record['confirmed'])

      all_bookings << booking
    end
    return all_bookings
  end

  def find_by_space_id(space_id)
    sql = 'SELECT * FROM bookings WHERE space_id = $1;'
    sql_params = [space_id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    all_bookings = []
    result_set.each do |record|
      booking = Booking.new
      booking.id = record['id']
      booking.date = record['date']
      booking.user_id = record['user_id']
      booking.space_id = record['space_id']
      booking.confirmed = to_boolean(record['confirmed'])

      all_bookings << booking
    end
    return all_bookings
  end

  def create(booking)
    sql = 'INSERT INTO bookings (date, user_id, space_id, confirmed) VALUES ($1, $2, $3, $4);'
    sql_params = [booking.date, booking.user_id, booking.space_id, false]
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