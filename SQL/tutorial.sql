use world;
show tables;
describe city;

-- query 1
select count(distinct(language)) from countrylanguage;

-- query 2
select count(ID) from city where countrycode = 'USA';

-- query 3
select Name from country where `LifeExpectancy` = (select Max(`LifeExpectancy`) from country);

-- query  4
select name from city where name like 'a%' limit 20;

-- query 5
select * from city where population < 100000 and countrycode = 'IND' order by district;

-- 6
select distinct(language) from countrylanguage order by language asc;

-- 7
select count(language) from countrylanguage where language = 'english';

-- 8
select avg(population) from country where capital between 100 and 200;

-- 9
select count(code), continent, avg(population) from country group by continent;