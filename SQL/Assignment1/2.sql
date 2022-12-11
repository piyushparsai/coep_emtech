drop database If exists insurance;

-- Create database 'insurance' and use it
CREATE DATABASE insurance;
USE insurance;

-- Create tables for person, car, accident, owns and participated
CREATE TABLE person(driver_id INT PRIMARY KEY, name VARCHAR(50) NOT NULL, address VARCHAR(100) NOT NULL);
CREATE TABLE car (license VARCHAR(10) PRIMARY KEY, model VARCHAR(50) NOT NULL, manufacture_year YEAR);
CREATE TABLE owns (driver_id INT NOT NULL, license VARCHAR(10) NOT NULL UNIQUE,
	FOREIGN KEY fk_own_driver_id(driver_id) REFERENCES person(driver_id),
    FOREIGN KEY fk_own_license(license) REFERENCES car(license));
CREATE TABLE participated (report_number INT PRIMARY KEY, license VARCHAR(10) NOT NULL, driver_id INT NOT NULL, damage_amount INT NOT NULL DEFAULT 0,
	FOREIGN KEY fk_part_driver_id(driver_id) REFERENCES person(driver_id),
    FOREIGN KEY fk_part_license(license) REFERENCES car(license));
CREATE TABLE accident (report_number INT PRIMARY KEY, location VARCHAR(50),
    FOREIGN KEY fk_acc_report_number(report_number) REFERENCES participated(report_number));

INSERT INTO person VALUES
    (1, 'Raj', 'Indore'),
    (2, 'Ajay', 'Nagpur'),
    (3, 'Bala', 'Pune'),
    (4, 'John Smith', 'Agra');
    
INSERT INTO car VALUES
    ('A1B2C1', 'Maruti', 2010),
    ('A1B2C2', 'Honda', 2011),
    ('A1B2C3', 'Mazda', 2012),
    ('A1B2C4', 'Hyundai', 2020),
    ('A2B3C4', 'Honda', 2021),
    ('M1M2M3', 'Mazda', 2019);

INSERT INTO owns VALUES
   (1, 'A1B2C1'),
   (2, 'A1B2C2'),
   (3, 'A1B2C3'),
   (2, 'A1B2C4'),
   (4, 'A2B3C4'),
   (4, 'M1M2M3');

INSERT INTO participated VALUES
   (1, 'A2B3C4', 2, 1500),
   (2, 'A1B2C2', 1, 1000),
   (3, 'A2B3C4', 2, 2100);

INSERT INTO accident VALUES 
    (1, 'Noida'),
    (2, 'Delhi'),
    (3, 'Patna');


-- c) Add a new accident to the database; assume any values for required attributes
INSERT INTO participated VALUES(4, 'A1B2C1', 2, 20);
INSERT INTO accident VALUES (4, 'Delhi');

-- d) Find report numbers for all the accidents in which the cars belonging to “John Smith” were involved. ( subquery)
SELECT report_number FROM participated WHERE license in (SELECT license FROM owns WHERE driver_id = (SELECT driver_id FROM person WHERE name = 'John Smith'));

-- e) Delete the Mazda belonging to “John Smith”.
DELETE FROM owns WHERE driver_id = (SELECT driver_id FROM person WHERE name = 'John Smith') AND
    license IN (SELECT license FROM car WHERE model = 'mazda');

-- f) Create a view to get date and locations of all accidents.
CREATE VIEW dam_and_location AS SELECT accident.location, participated.damage_amount FROM accident, participated WHERE accident.report_number = participated.report_number;
select * from dam_and_location;

use insurance;

-- g) Find the name and addresses of owners of cars involved in accidents for which damage amount is greater than $2000.
SELECT name, address FROM person WHERE driver_id = (SELECT driver_id FROM owns WHERE license = (SELECT license FROM participated WHERE damage_amount > 2000));

-- h) Add car prices in the appropriate relation.
ALTER TABLE car ADD COLUMN price INT DEFAULT 5000;

-- i) Create view to have the information of persons and their cars .
CREATE VIEW person_car AS SELECT person.driver_id, person.name, person.address, car.license, car.model, car.manufacture_year, car.price FROM person, car, owns 
	WHERE person.driver_id = owns.driver_id AND car.license = owns.license;
SELECT * FROM person_car;

-- j) Rename the name of the table person to owners.
RENAME TABLE person to owners;

-- k) Change the type of attribute damage amount from int to numeric.
ALTER TABLE participated MODIFY damage_amount NUMERIC;

-- l) Delete all values in accident table but keep the relation in schema.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM accident;

-- m) Modify the accident table to increase the report number by one for each new insertion.
ALTER TABLE accident MODIFY report_number INT AUTO_INCREMENT;
