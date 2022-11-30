USE institute;
CREATE TABLE instructor (ID int, name varchar(50), dept_name varchar(50), salary int);
SELECT * from instructor;
INSERT INTO instructor VALUES (22222, "Eintein", "Physics", 95000);
INSERT INTO instructor VALUES (12121, "Wu", "Finance", 90000);
SELECT ID, dept_name FROM instructor WHERE salary > 92000;
SET SQL_SAFE_UPDATES = 0;
UPDATE instructor SET salary = 97000 WHERE name = "Eintein";
DELETE FROM instructor WHERE ID = 12121;

