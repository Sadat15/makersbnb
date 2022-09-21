## Project Specification

### Headline specifications
- Users can list multiple spaces.

- Users should be able to name their space, provide a short description of the space, and a price per night.

- Users should be able to offer a range of dates where their space is available.

- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.

- Nights for which a space has already been booked should not be available for users to book that space.

- Until a user has confirmed a booking request, that space can still be booked for that night.

Initial table names / columns
- users
  - id, name, email, password

- spaces
  - id, owner_id, name, description, price_per_night, date_range

- bookings
  - id, date, user_id, space_id, confirmed