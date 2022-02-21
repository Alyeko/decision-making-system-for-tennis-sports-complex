--=================================================================================--
-- This file contains the constraints for the Abrabo Tennis Sports Complex database
-- where constraints are used to apply rules to any data that is entered, to ensure that
-- there is no missing data and no duplicate data 
-- i.e. we aim for 'one-fact-one-place'
-- There are 4 types of constraints in this file
-- 1. Primary keys
-- 2. Foreign keys
-- 3. Unique constraints
-- 4. Check constraints
--================================================================================--

--1. Primary Keys
   
-- Primary Keys
-- NB we use ID values (substitute primary keys) as these make joining tables easier 
-- and comparing numbers when matching primary and foreign keys is quicker
-- however UNIQUE constraints should also existing for every table
-- to make sure that that the real primary key is unique - i.e.
-- different in every row
-- primary keys can be created in any order as they don't depend on other constraints in the way that
-- foreign keys do

--the tennis_sports_complex_table 1.
alter table ucesoan.tennis_sports_complex 
add constraint tennis_sports_complex_pk 
primary key(tennis_sports_complex_id);

--the stadia table 2. 
alter table ucesoan.stadia 
add constraint stadia_pk 
primary key (stadium_id);

--the courts table 3. 
alter table ucesoan.courts 
add constraint courts_pk 
primary key(court_id);

--the floodlights table 4. 
alter table ucesoan.floodlights 
add constraint floodlights_pk 
primary key(light_id);

--the seating table 5. 
alter table ucesoan.seating 
add constraint seating_pk 
primary key(seating_id);

--the floodlight_values table 6.
alter table ucesoan.floodlight_values
add constraint floodlight_values_pk
primary key(floodlight_value_id);	

--the stadium_condition table 7. 
alter table ucesoan.stadium_condition
add constraint stadium_condition_pk
primary key(stadium_condition_id);

--the court_condition table 8.
alter table ucesoan.court_condition
add constraint court_condition_pk
primary key(court_condition_id);
	
--the floodlight_condition table 9.
alter table ucesoan.floodlight_condition
add constraint floodlight_condition_pk
primary key(light_condition_id);

--the seating_condition table 10.
alter table ucesoan.seating_condition
add constraint seating_condition_pk
primary key(seating_condition_id);

--the users table 11.
alter table ucesoan.users
add constraint user_pk
primary key(user_id);

--the parameters table 12.
alter table ucesoan.parameters
add constraint parameters_pk
primary key(parameter_id);

--the criticality table 13. 
alter table ucesoan.criticality
add constraint criticality_pk
primary key(criticality_id);
	
--asset_health_indicator table 14. 
alter table ucesoan.asset_health_indicator
add constraint health_pk
primary key(asset_health_indicator_id);

--================================================================================--
--2. Foreign keys
-- These reference the primary keys so that you can't get a 'child' created without a parent 
-- e.g. no room without a building, no building without a university
-- the corresponding primary key constraints must be created first
-- Not all tables have a foregin key and some tables have 2 or more foreign keys
--================================================================================
--Tables with location component are as follows--
--=================================================================================
--the stadia table, need the tennis_sports_complex before creating a stadium
alter table ucesoan.stadia
add constraint stadia_tennis_sports_complex_fk
foreign key(tennis_sports_complex_id)
references ucesoan.tennis_sports_complex(tennis_sports_complex_id);

--the courts table, need the stadium before creating a court
alter table ucesoan.courts
add constraint courts_stadia_fk
foreign key(stadium_id)
references ucesoan.stadia(stadium_id);

--the seating table, need the stadium before creating the seating
alter table ucesoan.seating
add constraint seating_stadia_fk	
foreign key(stadium_id)
references ucesoan.stadia(stadium_id);

--the floodlights table, need to have the stadia before creating the floodlights
alter table ucesoan.floodlights
add constraint floodlights_stadia_fk
foreign key(stadium_id) 
references ucesoan.stadia(stadium_id);

--==================================================================================--
--Tables with criticality--
--==================================================================================--
--the tennis_sports_complex table- need to have criticality value before it can be created
alter table ucesoan.tennis_sports_complex
add constraint tennis_sports_complex_criticality_fk
foreign key(criticality) 
references ucesoan.criticality(criticality_id);


--the stadia table- need to need to have criticality value before it can be created
alter table ucesoan.stadia 
add constraint stadia_criticality_fk
foreign key(criticality) 
references ucesoan.criticality(criticality_id);

--the courts table- need to need to have criticality value before it can be created
alter table ucesoan.courts
add constraint courts_criticality_fk
foreign key(criticality)
references ucesoan.criticality(criticality_id);

--the floodlights table-need to need to have criticality value before it can be created
alter table ucesoan.floodlights
add constraint floodlights_criticality_fk
foreign key(criticality)
references ucesoan.criticality(criticality_id);

--the seating table-need to need to have criticality value before it can be created
alter table ucesoan.seating
add constraint seating_criticality_fk
foreign key(criticality)
references ucesoan.criticality(criticality_id);

--=======================================================================================
--stadium_condition table
--=======================================================================================
--the stadium_condition table, need to have a valid stadium(stadium_id) before the stadium_condition can be done
alter table ucesoan.stadium_condition
add constraint stadium_condition_stadium_fk
foreign key(stadium_id)
references ucesoan.stadia(stadium_id);

--the stadium_condition table, need to have the valid list of conditions (asset health values) for the roof condition
alter table ucesoan.stadium_condition
add constraint stadium_condition_roof_fk
foreign key(roof_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);


--the stadium_condition table, need to have the valid list of conditions (asset health values) for the seating condition
alter table ucesoan.stadium_condition
add constraint stadium_condition_seating_fk
foreign key(seating_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the stadium_condition table, need to have the valid list of conditions (asset health values) for the disabled_access_condition
alter table ucesoan.stadium_condition
add constraint stadium_condition_disabled_access_fk
foreign key(disabled_access_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the stadium_condition table, need to have the valid list of conditions (asset health values) for the washroom_condition
alter table ucesoan.stadium_condition
add constraint stadium_condition_washroom_fk
foreign key(washroom_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the stadium_condition table, need to have the valid list of conditions (asset health values) for the surveillance_condition
alter table ucesoan.stadium_condition	
add constraint stadium_condition_surveillance_fk
foreign key(surveillance_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);


--the stadium_condition table needs to have  a valid asset health value to create a floodlight_condition report */
alter table ucesoan.stadium_condition
add constraint stadium_condition_floodlight_fk
foreign key (floodlight_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);


--the stadium_condition table, need to have the valid list of conditions (asset health values) for the giant_screen_condition
alter table ucesoan.stadium_condition	
add constraint stadium_condition_giant_screen_fk
foreign key(giant_screen_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);


--the stadium_condition table, need to have a valid user to create a stadium_condition report 
alter table ucesoan.stadium_condition	
add constraint stadium_condition_user_fk
foreign key(user_id)
references ucesoan.users(user_id);

--================================================================================--
--the court_condition table
--================================================================================--
--the court_condition table, needs to have a valid court(court_id) before the court_condition can be done
alter table ucesoan.court_condition
add constraint court_condition_court_fk
foreign key(court_id)
references ucesoan.courts(court_id);

--the court_condition table needs to have  a valid asset health value to create a net_condition report */
alter table ucesoan.court_condition
add constraint court_condition_net_fk
foreign key (net_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the court_condition table needs to have  a valid asset health value to create a umpire_chair_condition report */
alter table ucesoan.court_condition
add constraint court_condition_umpire_chair_fk
foreign key (umpire_chair_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the court_condition table needs to have  a valid asset health value to create a players_bench_condition report */
alter table ucesoan.court_condition
add constraint court_condition_players_bench_fk
foreign key (players_bench_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the court_condition table needs to have  a valid asset health value to create a hawkeye_technology_condition report */
alter table ucesoan.court_condition
add constraint court_condition_hawkeye_fk
foreign key (hawkeye_technology_condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the court_condition table, needs to have a valid user to create a court_condition report */
alter table ucesoan.court_condition	
add constraint stadium_condition_user_fk
foreign key(user_id)
references ucesoan.users(user_id);

--================================================================================
--the seating condition table
--================================================================================
--the seating_condition table, needs to have a valid seating(seating_id) before the seating_condition can be done
alter table ucesoan.seating_condition 
add constraint seating_condition_seating_fk
foreign key(seating_id)
references ucesoan.seating(seating_id);

--the seating_condition table needs to have a valid condition to create a seating condition report--
alter table ucesoan.seating_condition
add constraint seating_condition_fk
foreign key(condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the seating_condition table, needs to have a valid user to create a seating_condition report --
alter table ucesoan.seating_condition	
add constraint seating_condition_user_fk
foreign key(user_id)
references ucesoan.users(user_id);

--=====================================================================================
--floodlight condition table
--=====================================================================================
--the floodlight_condition table, needs to have a valid floodlight(light_id) before the floodlight_condition can be donealter table ucesoan.floodlight_condition 
alter table ucesoan.floodlight_condition
add constraint floodlight_condition_floodlight_fk
foreign key(light_id)
references ucesoan.floodlights(light_id);

--the floodlight_condition table needs to have a valid condition to create a floodlight_condition report--
alter table ucesoan.floodlight_condition
add constraint floodlight_condition_fk
foreign key(condition)
references ucesoan.asset_health_indicator(asset_health_indicator_id);

--the floodlight_condition table, needs to have a valid user to create a floodlight_condition report --
alter table ucesoan.floodlight_condition	
add constraint floodlight_condition_user_fk
foreign key(user_id)
references ucesoan.users(user_id);

--======================================================================================
--the floodlight_values table
--======================================================================================
--the floodlight_values table- need a floodlight for the value--
alter table ucesoan.floodlight_values
add constraint floodlight_values_floodlight
foreign key(floodlight_id)
references ucesoan.floodlights(light_id);

--======================================================================================
--3. Unique Constraints


-- NB we use ID values (substitute primary keys) as these make joining tables easier 
-- and comparing numbers when matching primary and foreign keys is quicker
-- however UNIQUE constraints should also existing for every table
-- to make sure that that the real primary key is unique - i.e.
-- different in every row
-- unique constraints can be created in any order as they don't depend on other constraints in the way that
-- foreign keys do
 
-- there should be as many unique constraints as there are tables
--======================================================================================

--the floodlights table- no two floodlights in the exact same location--
alter table ucesoan.floodlights
add constraint floodlights_unique
unique(location);

--the courts table- no two courts in the same exact location--
alter table ucesoan.courts
add constraint courts_unique
unique(location);

--the tennis_sports_complex table- no two sports complex in the same excat location--
alter table ucesoan.tennis_sports_complex
add constraint tennis_sports_complex_unique
unique(location);

--the stadia table- no two stadia with the same name
alter table ucesoan.stadia
add constraint stadia_unique
unique(stadium_name);


--the seating table- no two seating in the same exact location
alter table ucesoan.seating
add constraint seating_unique
unique(location);

--the asset_health_indicator table - the indicator text must be different from each other 
alter table ucesoan.asset_health_indicator
add constraint health_description_unique
unique(asset_health_indicator_description);

--the court condition table - you can't have the same user doing a report for the same court on the same date 
alter table ucesoan.court_condition
add constraint court_condition_unique 
unique(user_id, court_id, report_date);

--the stadium condition table - you can't have the same user doing a report for the same stadium on the same date 
alter table ucesoan.stadium_condition
add constraint stadium_condition_unique 
unique(user_id, stadium_id, report_date);

--the floodlight condition table - you can't have the same user doing a report for the same floodlight on the same date 
alter table ucesoan.floodlight_condition
add constraint floodlight_condition_unique 
unique(user_id, light_id, report_date);

--the seating condition table - you can't have the same user doing a report for the same seating on the same date 
alter table ucesoan.seating_condition
add constraint seating_condition_unique 
unique(user_id, seating_id, report_date);

--the floodlight_values table- you can't have different values with the same timestamp and floodlight_id
alter table ucesoan.floodlight_values
add constraint floodlight_values_unique
unique(floodlight_id, reading_timestamp);

--the users table - each user name needs to be unique--
alter table ucesoan.users
add constraint user_name_unique
unique(user_name);

--the parameters table - combination of parameter name, subname and date must be unique */
alter table ucesoan.parameters
add constraint parameters_unique 
unique(parameter_type, parameter_name, parameter_subname, date_created);

--=======================================================================================================================
--4. Check constraints
-- Check Constraints
-- These are used to make sure that values are restricted -e.g. so that users don't type in abbreviations that then aren't
-- understooed by the system

-- Using this type of constraint is only advised when you are 100% sure that you know all the possible values that could be used
-- Otherwise use a lookup table

--==================================================================================================================
--the court types can have only three values--
alter table ucesoan.courts
add constraint court_type_check
check (court_type in ('clay','hard','grass'));