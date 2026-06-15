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
    CONSTRAINT chk_users_role CHECK (role IN ('Ticket Manager', 'Football Fan'))
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


