use demo;
create table employee (id int primary key auto_increment, job varchar(50) not null, salary int default 10000);
insert into employee (id, job) values (1, "Manager");

insert into employee(job) values ("Developer");
select * from employee;

insert into employee(job, salary) values("QA", 25000);