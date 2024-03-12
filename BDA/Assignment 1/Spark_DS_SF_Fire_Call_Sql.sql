-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Assignment 1
-- MAGIC ### Piyush Bhupendra Parsai
-- MAGIC ### MIS: 712352029

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 1. Load the given data file and create a Spark data frame

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Read the csv file and load the data in fire_df data frame
-- MAGIC fire_df = spark.read \
-- MAGIC     .format("csv") \
-- MAGIC         .option("header", "true") \
-- MAGIC             .option("inferschema", "true") \
-- MAGIC                 .load("/databricks-datasets/learning-spark-v2/sf-fire/sf-fire-calls.csv")

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Cache the data frame
-- MAGIC c_fire_df = fire_df.cache()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Total record count
-- MAGIC c_fire_df.count()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Print schema
-- MAGIC c_fire_df.printSchema()
-- MAGIC

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Display content of data frame
-- MAGIC display(fire_df)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Register DataFrame as a SQL temporary view for different data query oeprations
-- MAGIC fire_df.createOrReplaceTempView("temp_fire_calls_view")

-- COMMAND ----------

-- Run a DML query to get first 10 records
select * from temp_fire_calls_view limit 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 2. Create database and load the data frame in SQL table

-- COMMAND ----------

-- Create data base
create database if not exists fire_db

-- COMMAND ----------

-- Create table to import data from the temperory view of data set
create table if not exists fire_db.fire_calls_tbl (CallNumber integer,
UnitID string,
IncidentNumber integer,
CallType string,
CallDate date,
WatchDate date,
CallFinalDisposition string,
AvailableDtTm string,
Address string,
City string,
ZipcodeofIncident integer,
Battalion string,
StationArea string,
Box string,
OrigPriority string,
Priority string,
FinalPriority integer,
ALSUnit boolean,
CallTypeGroup string,
NumAlarms integer,
UnitType string,
Unitsequenceincalldispatch integer,
FirePreventionDistrict string,
SupervisorDistrict string,
Neighborhood string,
Location string,
RowID string,
Delay double)

-- COMMAND ----------

-- Describe the table 
DESCRIBE fire_db.fire_calls_tbl

-- COMMAND ----------

-- Load data from the temperory view created from the data frame
insert into fire_db.fire_calls_tbl select * from temp_fire_calls_view

-- COMMAND ----------

-- Run a query on new table to get top 10 rows
select * from fire_db.fire_calls_tbl limit 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC # 3. Use the Spark data frame to answer the following questions

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 1. How many distinct type of calls were made to the fire department?

-- COMMAND ----------

-- To find distinct type of calls, count the distinct entries in `CallType` column and store as `call_type_count`
select count (distinct CallType) as call_type_count from fire_db.fire_calls_tbl

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 2. What are distinct type of calls were made to the fire department?

-- COMMAND ----------

-- List all distinct `CallType`
select distinct CallType from fire_db.fire_calls_tbl

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 3. Find out all responses or delayed times greater than 5 mins?

-- COMMAND ----------

-- Select all entries where `Delay` is greater than 5
select * from fire_db.fire_calls_tbl where Delay > 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 4. What is most common call type 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC

-- COMMAND ----------

-- Group by `CallType` and select count of the `CallType` as `call_count`, 
-- then sort by `call_count` in descending order
-- and select the 1st entry to find most common call type
select CallType, count(CallType) as call_count from fire_db.fire_calls_tbl
group by CallType 
order by call_count desc
limit 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 5. What zip codes accounted for the most common calls?

-- COMMAND ----------

-- For the zip codes for most common calls, we are ignoring null zip codes.
-- In sub query, we are finding the most common call type in place of hardcoding it to 'Medical Incident' as found in previous query
Select distinct ZipcodeofIncident as zip_code_incedent
from  fire_db.fire_calls_tbl
where CallType = (
    select CallType from
      (
        select CallType, count(CallType) as call_count
        from fire_db.fire_calls_tbl
        group by CallType
        order by call_count desc
        limit 1
      )
  ) and ZipcodeofIncident is not null

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 6. What San Franciso neighbourhoods are in the zip codes 94102 and 94103

-- COMMAND ----------

select distinct Neighborhood from fire_db.fire_calls_tbl where ZipcodeofIncident in (94102, 94103)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 7. What was sum of all calls, avarage, min and max of the call response times?

-- COMMAND ----------

-- Find sum, average, min and max of Delay column to find call response times. Upto 2 decimal places
select
  round(sum(Delay), 2) as sum,
  round(avg(Delay), 2) as average,
  round(min(Delay), 2) as min,
  round(max(Delay), 2) as max
from fire_db.fire_calls_tbl

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 8. How many distinct year of data are in the CSV file?

-- COMMAND ----------

select count(distinct year(CallDate)) as distinct_years from fire_db.fire_calls_tbl

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 9. What week of the year in 2018 had most fire calls

-- COMMAND ----------

select weekofyear(CallDate) as week_of_year, count(CallNumber) as count from fire_db.fire_calls_tbl 
where year(CallDate) = 2018 
group by weekofyear(CallDate) 
order by count desc
limit 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ## 10. What neighbourhood in San Francisco had the worst response time in 2018

-- COMMAND ----------

-- Worst response time is rounded to 2 deciaml place
select Neighborhood, round(max(Delay), 2) as worst_response_time from fire_db.fire_calls_tbl 
where year(CallDate) = 2018
group by Neighborhood
order by worst_response_time desc
limit 1
