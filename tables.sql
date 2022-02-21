--===============================================================================================================================================--
--dropping and creating the schema--
drop schema if exists ucesoan cascade;
create schema ucesoan;
--===============================================================================================================================================--
--1. create the tennis_sports_complex table--

drop table if exists ucesoan.tennis_sports_complex;
create table ucesoan.tennis_sports_complex(
	tennis_sports_complex_id serial,
	tennis_sports_complex_name character varying (100) not null,
	year_founded integer,
	founders_name character varying (100),
	criticality integer not null);

--add the geometry column - 2D in this case--
select AddGeometryColumn('ucesoan','tennis_sports_complex','location',27700, 'geometry',2);

--===============================================================================================================================================--
--2. create the stadia table--

drop table if exists ucesoan.stadia;
create table ucesoan.stadia(
	stadium_id serial,
	stadium_name character varying (200) not null,
	tennis_sports_complex_id integer not null,
	criticality integer not null);

--add the geometry column - 3D in this case--
select AddGeometryColumn('ucesoan','stadia','location',27700, 'geometry',3);

--===============================================================================================================================================--
--3. create the courts table--

drop table if exists ucesoan.courts;
create table ucesoan.courts(
	court_id serial,
	court_type character varying(50) not null,
	court_installation_date date,   
	stadium_id integer not null,
	criticality integer not null);

--add the geometry column - 2D in this case--
--alter table ucesoan.courts drop column if exists location;
select AddGeometryColumn('ucesoan','courts','location',27700, 'geometry',2);

--===============================================================================================================================================--
--4. create the floodlights table--
drop table if exists ucesoan.floodlights;
create table ucesoan.floodlights(
	light_id serial,
	light_name character varying (50) not null,
	light_brand character varying (200) not null,
	light_installation_date date,
	stadium_id integer, 
	criticality integer not null);

-- add the geometry columns - 3D point in this case --
select AddGeometryColumn('ucesoan','floodlights','location',0, 'point',3);

--===============================================================================================================================================--
--5. create the seating table--
drop table if exists ucesoan.seating;
create table ucesoan.seating(
	seating_id serial,
	seating_name character varying (200) not null,
	stadium_id integer not null,
	criticality integer not null);

-- add the geometry columns - 2D in this case  --
select AddGeometryColumn('ucesoan','seating','location',27700, 'geometry',2);

--===============================================================================================================================================--
--6. create the floodlight_values table--
drop table if exists ucesoan.floodlight_values;
create table ucesoan.floodlight_values(
	floodlight_value_id serial, 
	floodlight_id integer, 
	reading_timestamp timestamp,
	value_lumens double precision);

--================================================================================================================================================--
--7. create the stadium_condition--
drop table if exists ucesoan.stadium_condition;
create table ucesoan.stadium_condition
(stadium_condition_id serial not null,
stadium_id integer not null,
roof_condition integer not null,
seating_condition integer not null,
disabled_access_condition integer not null,
washroom_condition integer not null,
surveillance_condition integer not null,
floodlight_condition integer not null,
giant_screen_condition integer not null,
user_id integer not null,
report_date date not null default CURRENT_DATE);

--===============================================================================================================================================--
--8. create the court_condition table--
drop table if exists ucesoan.court_condition;
create table ucesoan.court_condition
(court_condition_id serial not null,
court_id integer not null,
net_condition integer not null,
umpire_chair_condition integer not null,
players_bench_condition integer not null,
hawkeye_technology_condition integer not null,
user_id integer not null,
report_date date not null default CURRENT_DATE);

--=================================================================================================================================================--
--9. create the floodlight_condition--

drop table if exists ucesoan.floodlight_condition;
create table ucesoan.floodlight_condition
(light_condition_id serial not null,
light_id integer not null,
condition integer not null,
user_id integer not null,
report_date date not null default CURRENT_DATE);

--==================================================================================================================================================--
--10. create the seating_condition table--

drop table if exists ucesoan.seating_condition;
create table ucesoan.seating_condition
(seating_condition_id serial not null,
seating_id integer not null,
condition integer not null,
user_id integer not null,
report_date date not null default CURRENT_DATE);

--===================================================================================================================================================--
--11. create the users table--

drop table if exists ucesoan.users;
create table ucesoan.users
(user_id serial not null,
user_name character varying(100) not null);

--===================================================================================================================================================--
--12. create the parameters table--
-- create the parameters table 
-- note that we have a default date of CURRENT_DATE - so if the user doesn't insert a date the
-- parameter is assumed to be valid from the date it is inserted
-- (until a later parameter value comes along)


drop table if exists ucesoan.parameters;
create table ucesoan.parameters 
(parameter_id serial,
parameter_type character varying (100),
parameter_name character varying (150),
parameter_subname character varying (150),
parameter_value double precision,
parameter_units character varying (100),
date_created date default CURRENT_DATE);

--====================================================================================================================================================--
--13. create the criticality table--

-- create the criticality table 
-- note that even though criticality_id is a serial we can override this later on
-- so that we can have criticality values of 1 to 4 as per the IAM guidance

drop table if exists ucesoan.criticality;
create table ucesoan.criticality
(criticality_id serial not null,
criticality character varying(500) not null);

--====================================================================================================================================================--
--14. create the asset_health_indicator table--

-- create the asset_health_indicator table 
-- note that even though assets_health_indicator_id is a serial we can override this later on
-- so that we can have asset health values of 1 to 4 as per the IAM guidance

drop table if exists ucesoan.asset_health_indicator;
create table ucesoan.asset_health_indicator 
(asset_health_indicator_id serial not null,
asset_health_indicator_description character varying(500));

--====================================================================================================================================================--