use institute;
select * from department;
select * from instructor;
insert into department values ("Biology", "a", 1);
insert into department values ("Computers", "b", 2);

alter table instructor add constraint fk_dept foreign key (dept_name) references department(dept_name); 
delete from instructor where dept_name = 'physics';
alter table department add primary key (dept_name);

create table subject (id int, name varchar(60), dept_name varchar(60), constraint fk_dept_sub foreign key (dept_name) references department(dept_name));
describe subject;