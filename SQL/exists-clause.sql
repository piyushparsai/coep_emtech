use demo;
create table if not exists student(id int, name varchar(50));

select * from student;

-- sub queries
select * from employee where exists (select * from student where id = 20) ;