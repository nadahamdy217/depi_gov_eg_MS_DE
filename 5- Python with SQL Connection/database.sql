CREATE DATABASE user_database;
go

use user_database;
go

CREATE TABLE Users (
    user_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    year_of_birth INT
);

