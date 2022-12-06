-- Create database practice
CREATE DATABASE practice;

-- Use the database
USE practice;

-- Create tables for entities person, car and accident
CREATE TABLE person (driver_id varchar(50), name varchar(50), address varchar(50));
CREATE TABLE car (license_no int, model varchar(50), year int);
CREATE TABLE accident (report_no int, location varchar(50));

-- Create tables for relations
CREATE TABLE owns (driver_id varchar(50), license_no int);
CREATE TABLE participated (report_no int, license_no int, driver_id varchar(50), damage_amt int);

-- Assign primary key constraints for entities tables
ALTER TABLE person ADD PRIMARY KEY (driver_id);
ALTER TABLE car ADD PRIMARY KEY (license_no);
ALTER TABLE accident ADD PRIMARY KEY (report_no);

-- Assign forgain keys to make relations between entities
-- Update relations for owns table
ALTER TABLE owns ADD FOREIGN KEY (driver_id) REFERENCES person(driver_id);
ALTER TABLE owns ADD FOREIGN KEY (license_no) REFERENCES car(license_no);

-- Update relations for participated table
ALTER TABLE participated ADD FOREIGN KEY (report_no) REFERENCES accident(report_no);
ALTER TABLE participated ADD FOREIGN KEY (license_no) REFERENCES car(license_no);
ALTER TABLE participated ADD FOREIGN KEY (driver_id) REFERENCES person(driver_id);
