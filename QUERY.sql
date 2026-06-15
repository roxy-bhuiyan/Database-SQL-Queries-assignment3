-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup
-- DESCRIPTION: Full DDL + DML + Queries Solution
-- =========================================================================


-- DROP TABLES IF THEY ALREADY EXIST TO PREVENT CONFLICTS
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id serial,
    full_name varchar(100) NOT NULL,
    email varchar(150) NOT NULL,
    role varchar(50) NOT NULL,
    phone_number varchar(20),
 
    -- constraint to make 'user_id' the Primary Key
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    -- constraint to ensure 'email' values are never duplicated
    CONSTRAINT uq_users_email UNIQUE (email),
    -- constraint to restrict 'role' to specific allowed strings
    CONSTRAINT chk_users_role CHECK (role IN (
         'Ticket Manager',
         'Football Fan'))
);


-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
CREATE TABLE matches (
    match_id serial,
    fixture varchar(200) NOT NULL,
    tournament_category varchar(100) NOT NULL,
    base_ticket_price numeric(10, 2) NOT NULL,
    match_status varchar(50) NOT NULL,

  
    -- constraint to make 'match_id' the Primary Key
    CONSTRAINT pk_matches PRIMARY KEY (match_id),
    -- check constraint to prevent negative ticket prices
    CONSTRAINT chk_matches_price CHECK (base_ticket_price >= 0),
    -- check constraint to restrict 'match_status' values
    CONSTRAINT chk_matches_status CHECK (
        match_status IN (
            'Available',
            'Selling Fast',
            'Sold Out',
            'Postponed'
        )
    )
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
  booking_id serial,
  user_id int NOT NULL,
  match_id int NOT NULL,
  seat_number varchar(20),
  payment_status varchar(50),
  total_cost numeric(10, 2) NOT NULL,

  
  -- constraint to make 'booking_id' the Primary Key
  CONSTRAINT pk_bookings PRIMARY KEY (booking_id),
  -- Foreign Key constraint linking 'user_id' to the Users table
  CONSTRAINT fk_bookings_user FOREIGN key (user_id) REFERENCES Users (user_id),
  -- Foreign Key constraint linking 'match_id' to the Matches table
  CONSTRAINT fk_bookings_match FOREIGN key (match_id) REFERENCES matches (match_id),
  -- check constraint to ensure 'total_cost' is non-negative
  CONSTRAINT chk_bookings_cost CHECK (total_cost >= 0),
  -- check constraint to restrict 'payment_status' values
  CONSTRAINT chk_bookings_pay_status CHECK (
    payment_status IN (
        'Pending', 
        'Confirmed', 
        'Cancelled', 
        'Refunded')
  )
);





