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
    dates date[],
    user_id int,
    constraint fk_user foreign key (user_id) references users(id) on delete cascade
);

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    date date,
    user_id int,
    space_id int, 
    confirmed boolean,
    constraint fk_user foreign key (user_id) references users(id) on delete cascade,
    constraint fk_space foreign key (space_id) references spaces(id) on delete cascade
);