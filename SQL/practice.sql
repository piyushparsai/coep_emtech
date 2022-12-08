USE demo;
drop table countries;
CREATE TABLE countries (country_id INT PRIMARY KEY AUTO_INCREMENT, country_name VARCHAR(50), region_id INT UNIQUE NOT NULL);
describe countries;


CREATE DATABASE example3;
USE example3;

CREATE TABLE department(department_id INT primary key, department_name varchar(50));

CREATE TABLE job(job_id INT primary key, job_name varchar(50));

CREATE TABLE IF NOT EXISTS employee (
	employee_id INT PRIMARY KEY, 
	first_name VARCHAR(50), 
	last_name VARCHAR(50), 
    email VARCHAR(100) UNIQUE NOT NULL, 
    job_id INT, FOREIGN KEY fk_job_id (job_id) REFERENCES job(job_id), 
    department_id INT, FOREIGN KEY fk_dept_id (department_id) REFERENCES department(department_id), 
    salary INT);

-- select without table
SELECT "This is SQL exersise";
select 5, 10, 15;
select 10 + 15;
select 10 + 15 - 5 * 2;


