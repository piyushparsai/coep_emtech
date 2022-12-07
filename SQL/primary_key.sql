USE institute;
DESCRIBE instructor;
ALTER TABLE instructor ADD PRIMARY KEY (ID);
CREATE TABLE deperatmentN (dept_name varchar(60) primary key , building varchar(60), budget int);
describe deperatmentN;
alter table deperatmentN drop primary key;

insert into deperatmentN values ('a', 'b', 1);
select * from deperatmentN;

alter table deperatmentN add primary key (dept_name);
delete from deperatmentN where budget = 1;
set SQL_SAFE_UPDATES=0;

create table person (id int, name varchar(60), address varchar(60), job varchar(40), salary int, primary key (name, job, salary));
describe person; 

create table demo (id int primary key, name varchar(50) unique);
describe demo;

alter table deperatmentN add unique key (building);
describe deperatmentN;

alter table instructor add unique key (name, dept_name);
describe instructor;