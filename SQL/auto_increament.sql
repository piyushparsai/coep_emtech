create database demo;
use demo;
create table student (id int primary key, name varchar(50) not null);
describe student;

drop table student;
create table student(id int primary key auto_increment, name varchar(50) not null);
insert into student (name) values ('Tim');
select * from student;

insert into student values (3, 'Wayne');
insert into student (name) values ('Patrick');

alter table student auto_increment=50;