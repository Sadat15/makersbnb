TRUNCATE TABLE users, spaces, bookings RESTART IDENTITY;

INSERT INTO users (name, email, password) VALUES 
('Jonas', 'jonas@somewhere.com', '$2a$12$4V/xPwwTy/Y4itSd2GjY7OqmB4EN3z5p.JcWkBagoN2TUqjYeTGI6'),
-- real password is 'lovelyday'
('Anna', 'anna@world.com', '$2a$12$YlqyPMdbTUMCOiISU834D.mXHMzrpBTIjDGbJwTAr5B/49ZViTAGK'),
-- real password is 'appletree'
('David', 'david@london.com', '$2a$12$iAcq.9qSDIrl6JYE/tyPzeMcuq/hYq1Iem8QXMh3zZrLEp/5l54Rq');
-- real password is 'citylife'

INSERT INTO spaces (name, description, price_per_night, dates, user_id) VALUES
('House', 'Lovely house at the seaside', 80, '{"2022-10-05", "2022-10-07", "2022-11-15"}', 2),
('Flat', 'Flat in Central London', 125, '{"2022-10-12", "2022-10-25"}', 3),
('Room', 'Room in terraced house', 60, '{"2022-10-01", "2022-10-02", "2022-10-03", "2022-10-04", "2022-10-05", "2022-10-06"}', 1);

INSERT INTO bookings (date, user_id, space_id, confirmed) VALUES
('2022-10-05', 1, 1, true),
('2022-10-07', 3, 1, true),
('2022-10-02', 2, 3, false);
