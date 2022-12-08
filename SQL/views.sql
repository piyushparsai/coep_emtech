use demo;
select * from employee where salary = 10000;

create view jobs_10000 as select job from employee where salary = 10000;

select * from jobs_10000;

create view mixed as select employee.job, student.id from employee, student;
select * from mixed;

alter view jobs_10000 as select * from employee where salary = 10000;
select * from jobs_10000;

drop view mixed;


