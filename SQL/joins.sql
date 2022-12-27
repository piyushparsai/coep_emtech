use institute;
select * from department;
select * from instructor;
insert into instructor values (1, 'Tom', 'Biology', 20), (2, 'Harry', 'Computers', 30);

select * from department;
insert into department values ('chemisty', 'c', 3), ('mathematics', 'd', 4);

-- inner join
select instructor.name, instructor.dept_name, department.building from department inner join instructor on instructor.dept_name = department.dept_name;

-- left join
select instructor.name, instructor.dept_name, department.building from department left join instructor on instructor.dept_name = department.dept_name;

-- right join
select instructor.name, instructor.dept_name, department.building from instructor right join department on instructor.dept_name = department.dept_name;
