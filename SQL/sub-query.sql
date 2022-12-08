use demo;
select * from employee;
select * from employee where salary > 15000;
select * from employee where salary > (select salary from employee where job = 'developer');
select * from employee where salary < (select salary from employee where job = 'qa');
