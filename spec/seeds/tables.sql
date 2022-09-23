DROP TABLE IF EXISTS users, spaces, dates, bookings, spaces_dates;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name text NOT NULL,
    email text UNIQUE NOT NULL,
    password text NOT NULL
);

CREATE TABLE spaces (
    id SERIAL PRIMARY KEY,
    name text NOT NULL,
    description text NOT NULL,
    price_per_night int NOT NULL,
    user_id int,
    constraint fk_user foreign key (user_id) references users(id) on delete cascade
);

CREATE TABLE dates (
  id SERIAL PRIMARY KEY,
  date date
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    date_id int,
    user_id int,
    space_id int, 
    confirmed boolean,
    constraint fk_user foreign key (user_id) references users(id) on delete cascade,
    constraint fk_space foreign key (space_id) references spaces(id) on delete cascade,
    constraint fk_date foreign key (date_id) references dates(id) on delete cascade
);

-- The Join Table

CREATE TABLE spaces_dates (
  space_id int,
  date_id int,
  constraint fk_space foreign key(space_id) references spaces(id) on delete cascade,
  constraint fk_date foreign key(date_id) references dates(id) on delete cascade,
  PRIMARY KEY (space_id, date_id)
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    date_id int,
    user_id int,
    space_id int, 
    confirmed boolean,
    constraint fk_user foreign key (user_id) references users(id) on delete cascade,
    constraint fk_space foreign key (space_id) references spaces(id) on delete cascade,
    constraint fk_date foreign key (date_id) references dates(id) on delete cascade
);

