--===================================================================================================================================================================
-- INSERT DATA SCRIPTS
-- for data insert, you MUST create the values in the primary key (parent) tables first
-- so that you can reference them when creating the values in the foreign key (child) tables
-- in other words - to create a window you first need the window cost
-- to create a condition survey on the window, you need to have the window first 
-- so before writing insert scripts it is useful to have a sketched out ER diagram
-- so that you can see the order in which to insert data

--  when you are then creating the 'child' record you can refer to the parent record using a nested insert to get the ID of the reuqired parent
-- to do that you need to know the exact row of the parent table
-- note that ID values (from serial) can't be relied on - if you make an insert mistake it doesn't reuse the ID values
-- for the parent there must only be ONE record
-- so you need to know the real identifier in the parent table to get hold of the right record 
-- you can find this by looking at the unique constraints for the table
--===================================================================================================================================================================
-- START WITH THE PARAMETERS TABLES 
-- insert the different parameters that are needed by the system
-- use the default date

--===================================================================================================================================================================
--floodlight parameters--

insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('fault', 'floodlight', 'min lumens value', 5000, 'lumens'),
('fault', 'floodlight', 'max lumens value', 10000, 'lumens'),
('comfort', 'floodlight', 'min lumens value', 30000, 'lumens'), 	
('comfort', 'floodlight', 'max lumens value', 60000, 'lumens'),  
('fault', 'floodlight', 'replacement age', 5, 'years'),
('replacement cost', 'floodlight', 'Ikea', 1500, '£ each');
--==================================================================================================================================================================
--court parameters
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('cost', 'court', 'clay', 3000, '£'),
('cost', 'court', 'hard', 1500, '£'),
('cost', 'court', 'grass', 3000, '£'),

('rennovation cost', 'court', 'clay', 2000, '£'),
('rennovation cost', 'court', 'hard', 1000, '£'),
('rennovation cost', 'court', 'grass', 2500, '£'), 

('net replacement cost', 'court', 'clay', 200, '£'),
('net replacement cost', 'court', 'hard', 200, '£'),
('net replacement cost', 'court', 'grass', 200, '£'),

('players bench replacement cost', 'court', 'clay', 250, '£'),
('players bench replacement cost', 'court', 'hard', 250, '£'),
('players bench replacement cost', 'court', 'grass', 250, '£'),

('umpire chair replacement cost', 'court', 'clay', 150, '£'),
('umpire chair replacement cost', 'court', 'hard', 150, '£'),
('umpire chair replacement cost', 'court', 'grass', 150, '£');
--==================================================================================================================================================================
--comfort parameters--
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('comfort', 'stadium', 'inside stadium requirements per person', 0.4, 'sq m'),
('comfort', 'stadium', 'outside stadium requirements per person', 0.5, 'sq m');

--==================================================================================================================================================================
-- staff members at the complex
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('population', 'tennis_sports_complex','staff',250,'people'),
('population', 'tennis_sports_complex', 'sponsors',50, 'people');

--==================================================================================================================================================================
--technological devices--
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('technology-hawkeye installation cost', 'court', 'hard', 1500, '£ each'),
('technology-hawkeye installation cost', 'court', 'clay', 2000, '£ each'),
('technology-hawkeye installation cost', 'court', 'grass', 2500, '£ each'),
('technology-hawkeye replacement cost', 'court', 'hard', 1000, '£ each'),
('technology-hawkeye replacement cost', 'court', 'clay', 2000, '£ each'),
('technology-hawkeye replacement cost', 'court', 'grass', 2500, '£ each'),

('technology-surveillance installation cost', 'stadium', 'Alyeko Stadium', 750, '£ each'),
('technology-surveillance installation cost', 'stadium', 'Ralfni Stadium', 750, '£ each'),
('technology-surveillance installation cost', 'stadium', 'Crossledge Stadium', 750, '£ each'),
('technology-surveillance replacement cost', 'stadium', 'Alyeko Stadium', 350, '£ each'),
('technology-surveillance replacement cost', 'stadium', 'Ralfni Stadium', 350, '£ each'),
('technology-surveillance replacement cost', 'stadium', 'Crossledge Stadium', 350, '£ each'),

('technology-giant screen installation cost', 'stadium', 'Alyeko Stadium', 800, '£ each'),
('technology-giant screen installation cost', 'stadium', 'Ralfni Stadium', 800, '£ each'),
('technology-giant screen installation cost', 'stadium', 'Crossledge Stadium', 800, '£ each'),
('technology-giant screen replacement cost', 'stadium', 'Alyeko Stadium', 500, '£ each'),
('technology-giant screen replacement cost', 'stadium', 'Ralfni Stadium', 500, '£ each'),
('technology-giant screen replacement cost', 'stadium', 'Crossledge Stadium', 500, '£ each'), 

('technology-surveillance installation cost', 'tennis sports complex', 'Abrabo Tennis Sports Complex', 800, '£ each'),
('technology-surveillance replacement cost', 'tennis sports complex', 'Abrabo Tennis Sports Complex', 400, '£ each');
--==================================================================================================================================================================
--income parameters
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('income', 'inside stadium', 'ticket cost', 100, '£ per seat'),
('income', 'outside stadium', 'ticket cost', 70, '£ per seat');

--==================================================================================================================================================================
--relative weightings
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('weighting', 'stadia','courts',3,'times as important'),
('weighting', 'stadia','seating',4,'times as important'),
('weighting', 'courts','floodlights',5,'times as important');
--==================================================================================================================================================================
-- relative weightings for the different components of the court assessment
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('weighting', 'courts','net_condition',1,''),
('weighting', 'courts','umpire_chair_condition',1,''),
('weighting', 'courts','players_bench_condition',2,''),
('weighting', 'courts','floodlight_condition',4,''),
('weighting', 'courts','hawkeye_technology_condition',3,'');

--==================================================================================================================================================================
-- relative weightings for the different components of the stadium assessment */
insert into ucesoan.parameters
(parameter_type, parameter_name, parameter_subname, parameter_value, parameter_units)
values
('weighting', 'stadia','roof_condition',1,''),
('weighting', 'stadia','seats_condition',1,''),
('weighting', 'stadia','disabled_access_condition',3,''),
('weighting', 'stadia','washroom_condition',1,''),
('weighting', 'stadia','surveillance_condition',3,''),
('weighting', 'stadia','giant_screen_condition',3,'');

--==================================================================================================================================================================
-- Create all the data for the lookup tables as this is also needed when you insert data into the condition tables--
 
-- Create the asset health indicator data 
-- fixed ID values here will override SERIAL 
-- we need them as they are the weightings for each health status
 
insert into ucesoan.asset_health_indicator(asset_health_indicator_id, asset_health_indicator_description)
values
(1, 'As new or in good serviceable condition'),
(2, 'Deteriorating, evidence of high usage, age, additional maintenance costs and inefficiency'),
(3, 'Requires replacement within 5 years'),
(4, 'In poor condition, overdue for replacement'),
(5, 'Unable to determine condition (e.g. as item is hidden)'),
(6, 'Item does not exist');

--=====================================================================================================================================================================
-- Create the criticality data 
-- fixed ID values here will override SERIAL 
-- we need them fixed as they are the weightings for criticality status

insert into ucesoan.criticality (criticality_id, criticality)
values
(1, 'Insignificant consequences if it fails'),
(2, 'Minor consequences (e.g. to a few people or a small part of the business) if it fails'),
(3, 'Serious consequences if it fails – i.e. to a large number of people or a key component of the business'),
(4, 'Critical – the organisation cannot operate if this fails');

--======================================================================================================================================================================
--Create all the data for the users
-- create all the data for the users
--  in reality we would have name, surname, date of birth and so forth for this dataset
--  so the incrementing approach using the generate_series that we show here wouldn't be used 

insert into ucesoan.users (user_name)
values
('user1'),
('user2'),
('user3');

--=====================================================================================================================================================================
-- INSERT DATA INTO THE ASSET TABLES
--  be careful about the order here - start with the top of the chain and follow the foreign keys
--  i.e. the tennis_sports_complex has to exist before we can create the stadia
--  the stadia has to exist before we create the courts etc
--====================================================================================================================================================================

--Insert the tennis_sports_complex data-- 
insert into ucesoan.tennis_sports_complex(tennis_sports_complex_name,year_founded,founders_name, location, criticality)
values 
('Abrabo Tennis Sports Complex','1826','Alberta Anim-Ayeko', st_geomfromtext('POLYGON ((547730 180842 ,547730 181000 , 547950 181000 , 547950 180842 , 547730 180842))',27700),(select criticality_id from ucesoan.criticality where criticality like  '%Critical%'));

--============================================================================================================================================================================
--Insert the stadium data

--Stadium 1--
insert into ucesoan.stadia
(stadium_name, tennis_sports_complex_id,criticality, location)
values
('Alyeko Stadium',
(select tennis_sports_complex_id from ucesoan.tennis_sports_complex b where st_intersects(b.location, 
st_geomfromtext('POLYGON((547807 180851 0, 547807 180917 0, 547871 180917 0, 547871 180851 0, 547807 180851 0))',27700))),(select criticality_id from ucesoan.criticality where criticality like  '%Serious%'),
st_extrude(st_geomfromtext('POLYGON((547807 180851 0, 547807 180917 0, 547871 180917 0, 547871 180851 0, 547807 180851 0))',27700),0,0,600));

--Stadium 2--
insert into ucesoan.stadia
(stadium_name, tennis_sports_complex_id,criticality, location)
values
('Ralfni Stadium',
(select tennis_sports_complex_id from ucesoan.tennis_sports_complex b where st_intersects(b.location, 
st_geomfromtext('POLYGON((547738 180931 0, 547738 180982 0, 547790 180982 0, 547790 180931 0, 547738 180931 0))',27700))),(select criticality_id from ucesoan.criticality where criticality like  '%Serious%'),
st_extrude(st_geomfromtext('POLYGON((547738 180931 0, 547738 180982 0, 547790 180982 0, 547790 180931 0, 547738 180931 0))',27700),0,0,600));

--Stadium 3--
insert into ucesoan.stadia
(stadium_name, tennis_sports_complex_id,criticality, location)
values
('Crossledge Stadium',
(select tennis_sports_complex_id from ucesoan.tennis_sports_complex b where st_intersects(b.location, 
st_geomfromtext('POLYGON((547888 180931 0, 547888 180984 0, 547940 180984 0, 547940 180931 0, 547888 180931 0))',27700))),(select criticality_id from ucesoan.criticality where criticality like  '%Serious%'),
st_extrude(st_geomfromtext('POLYGON((547888 180931 0, 547888 180984 0, 547940 180984 0, 547940 180931 0, 547888 180931 0))',27700),0,0,600));

--=============================================================================================================================================================================================================
-- Insert the courts data--
-- hard court failure is serious as there are two hard court grand slams in a year
-- clay and grass courts failure is minor as there are one of each grand slams in a year

--=============================================================================================================================================================================================================

-- Courts for Alyeko Stadium
insert into ucesoan.courts(court_type, court_installation_date, location, stadium_id, criticality)
values

('hard',
'01-December-2022',
st_geomfromtext('POLYGON((547827 180871, 547827 180879, 547851 180879, 547851 180871, 547827 180871))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547827 180871, 547827 180879, 547851 180879, 547851 180871, 547827 180871))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Serious%')),

('hard',
'01-December-2022',
st_geomfromtext('POLYGON((547827 180879.5, 547827 180887.5, 547851 180887.5, 547851 180879.5, 547827 180879.5))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547827 180879.5, 547827 180887.5, 547851 180887.5, 547851 180879.5, 547827 180879.5))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Serious%')),

('hard',
'01-December-2022',
st_geomfromtext('POLYGON((547827 180888, 547827 180896, 547851 180896, 547851 180888, 547827 180888))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547827 180888, 547827 180896, 547851 180896, 547851 180888, 547827 180888))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Serious%'));


-- Courts for Ralfni Stadium
insert into ucesoan.courts(court_type, court_installation_date, location, stadium_id, criticality)
values 
('clay',
'03-December-2021',
st_geomfromtext('POLYGON((547751 180941, 547751 180949, 547775 180949, 547775 180941, 547751 180941))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547751 180941, 547751 180949, 547775 180949, 547775 180941, 547751 180941))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')), 

('clay',
'03-December-2021',
st_geomfromtext('POLYGON((547751 180949.5, 547751 180957.5, 547775 180957.5, 547775 180949.5, 547751 180949.5))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547751 180949.5, 547751 180957.5, 547775 180957.5, 547775 180949.5, 547751 180949.5))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('clay',
'03-December-2021',
st_geomfromtext('POLYGON((547751 180958, 547751 180966, 547775 180966, 547775 180958, 547751 180958))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547751 180958, 547751 180966, 547775 180966, 547775 180958, 547751 180958))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%'));

-- Courts for Crossledge Stadium
insert into ucesoan.courts(court_type, court_installation_date, location, stadium_id, criticality)
values 
('grass',
'05-December-2014',
st_geomfromtext('POLYGON((547901 180941, 547901 180949, 547925 180949, 547925 180941, 547901 180941))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547901 180941, 547901 180949, 547925 180949, 547925 180941, 547901 180941))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('grass',
'05-December-2014',
st_geomfromtext('POLYGON((547901 180949.5, 547901 180957.5, 547925 180957.5, 547925 180949.5, 547901 180949.5))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547901 180949.5, 547901 180957.5, 547925 180957.5, 547925 180949.5, 547901 180949.5))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('grass',
'05-December-2014',
st_geomfromtext('POLYGON((547901 180958, 547901 180966, 547925 180966, 547925 180958, 547901 180958))',27700),
(select a.stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON((547901 180958, 547901 180966, 547925 180966, 547925 180958, 547901 180958))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%'));



--===============================================================================================================================================================================
-- Insert the floodlights data--
-- floodlights failure is minor as games played in the day time dont require them 

-- Note that floodlights has a foreign key
-- referencing the STADIA table
-- so stadia data needs to be populated
-- we will populate the stadium_id later 
--===============================================================================================================================================================================

-- Floodlights for Alyeko Stadium
insert into ucesoan.floodlights(light_brand, light_name, light_installation_date, location, criticality)
values 
('Ikea','Floodlight 1', '30-December-2021',st_geomfromtext('POINT(547827 180870.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 2', '30-December-2021',st_geomfromtext('POINT(547827 180897.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 3', '30-December-2021',st_geomfromtext('POINT(547851 180897.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 4', '30-December-2021',st_geomfromtext('POINT(547851 180870.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%'));

-- Floodlights for Ralfni Stadium
insert into ucesoan.floodlights(light_brand, light_name, light_installation_date, location, criticality)
values 
('Ikea','Floodlight 5', '02-November-2019',st_geomfromtext('POINT(547751 180939.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 6', '02-November-2019',st_geomfromtext('POINT(547751 180967.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 7', '02-November-2019',st_geomfromtext('POINT(547775 180967.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 8', '02-November-2019',st_geomfromtext('POINT(547775 180939.5 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%'));

-- Floodlights for Crossledge Stadium
insert into ucesoan.floodlights(light_brand, light_name, light_installation_date, location, criticality)
values 
('Ikea','Floodlight 9', '03-November-2017',st_geomfromtext('POINT(547901 180940 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 10', '03-November-2017',st_geomfromtext('POINT(547901 180968 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 11', '03-November-2017',st_geomfromtext('POINT(547925 180968 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%')),
('Ikea','Floodlight 12', '03-November-2017',st_geomfromtext('POINT(547925 180940 250)',27700), (select criticality_id from ucesoan.criticality where criticality like '%Minor%'));

--#remember you have to populate stadium ids for floodlight table and stadium_id for courts table...

--=================================================================================================================================================================================
-- Insert the seating data--
-- seating failure was serious pre-covid as fans alwasy watched games live , 
-- but is minor now in a covid-19 world.  

-- Note that seating has a foreign key
-- referencing the STADIA table
-- so stadia data needs to be populated
-- we will populate the stadium_id later 
--=================================================================================================================================================================================
--Seating for Alyeko Stadium
insert into ucesoan.seating(seating_name, location, stadium_id, criticality)
values 
('Alyeko West', 
st_geomfromtext('POLYGON ((547810 180854 ,547810 180913 , 547823 180896 , 547823 180870 , 547810 180854))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547810 180854 ,547810 180913 , 547823 180896 , 547823 180870 , 547810 180854))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Alyeko North', 
st_geomfromtext('POLYGON ((547816 180913 ,547860 180913 , 547852 180900 , 547827 180900 , 547816 180913))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547816 180913 ,547860 180913 , 547852 180900 , 547827 180900 , 547816 180913))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Alyeko East', 
st_geomfromtext('POLYGON ((547868 180913 ,547868 180854 , 547855 180870 , 547855 180896, 547868 180913))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547868 180913 ,547868 180854 , 547855 180870 , 547855 180896, 547868 180913))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Alyeko South', 
st_geomfromtext('POLYGON ((547861 180854 ,547815 180854 , 547827 180868 , 547850 180868, 547861 180854))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547861 180854 ,547815 180854 , 547827 180868 , 547850 180868, 547861 180854))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%'));

--Seating for Ralfni Stadium
insert into ucesoan.seating(seating_name, location, stadium_id, criticality)
values 
('Ralfni West', 
st_geomfromtext('POLYGON ((547740 180933, 547740 180977 , 547749 180966 , 547749 180940, 547740 180933))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547740 180933, 547740 180977 , 547749 180966 , 547749 180940, 547740 180933))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Ralfni North', 
st_geomfromtext('POLYGON ((547751 180969, 547740 180980 , 547783 180980, 547775 180969, 547751 180969))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547751 180969, 547740 180980 , 547783 180980, 547775 180969, 547751 180969))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Ralfni East', 
st_geomfromtext('POLYGON ((547788 180978 , 547788 180933 , 547777 180941, 547777 180966, 547788 180978))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547788 180978 , 547788 180933 , 547777 180941, 547777 180966, 547788 180978))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Ralfni South', 
st_geomfromtext('POLYGON ((547786 180933 ,547744 180933, 547751 180938, 547775 180938, 547786 180933))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547786 180933 ,547744 180933, 547751 180938, 547775 180938, 547786 180933))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

--Seating for Crossledge Stadium
('Crossledge West', 
st_geomfromtext('POLYGON ((547890 180933 ,547890 180981 , 547898 180966, 547898 180941, 547890 180933))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547890 180933 ,547890 180981 , 547898 180966, 547898 180941, 547890 180933))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Crossledge North', 
st_geomfromtext('POLYGON ((547895 180981 ,547932 180981, 547925 180970, 547901 180970, 547895 180981))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547895 180981 ,547932 180981, 547925 180970, 547901 180970, 547895 180981))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Crossledge East', 
st_geomfromtext('POLYGON ((547938 180981, 547938 180933 , 547927 180941, 547927 180966, 547938 180981))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547938 180981, 547938 180933 , 547927 180941, 547927 180966, 547938 180981))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%')),

('Crossledge South', 
st_geomfromtext('POLYGON ((547932 180933 ,547895 180933, 547901 180939, 547925 180939, 547932 180933))',27700),
(select stadium_id from ucesoan.stadia a where st_3dintersects(a.location, st_geomfromtext('POLYGON ((547932 180933 ,547895 180933, 547901 180939, 547925 180939, 547932 180933))',27700))),
(select criticality_id from ucesoan.criticality where criticality like '%Minor%'));

--=====================================================================================================================================================================================
-- update the tables which require the stadium_id
--======================================================================================================================================================================================
-- update the floodlights to include the stadium_id
update ucesoan.floodlights b
set stadium_id = 
(select stadium_id from ucesoan.stadia a 
where st_3dintersects(a.location, b.location));  

--====================================================================================================================================================================================
--insert the floodlight values table
--====================================================================================================================================================================================
--floodlight values in Alyeko Stadium
insert into ucesoan.floodlight_values(floodlight_id, reading_timestamp, value_lumens)
values
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 1'),'2022-01-01 10:00:00', 50000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 2'),'2022-01-01 10:05:00', 55000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 3'),'2022-01-01 10:10:00', 60000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 4'),'2022-01-01 10:15:00', 55000),

--floodlight values in Ralfni Stadium
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 5'),'2022-01-01 10:20:00', 30000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 6'),'2022-01-01 10:25:00', 30000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 7'),'2022-01-01 10:30:00', 20000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 8'),'2022-01-01 10:05:00', 20000),

--floodlight values in Crossledge Stadium
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 9'),'2022-01-01 10:05:00', 3000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 10'),'2022-01-01 10:05:00', 4000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 11'),'2022-01-01 10:05:00', 2000),
((select light_id from ucesoan.floodlights where light_name= 'Floodlight 12'),'2022-01-01 10:05:00', 5250);

--====================================================================================================================================================================================
-- FINALLY INSERT THE CONDITION INFORMATION
-- 
-- this can be quite complex as for each column with condition information we need to check that we have valid values
-- and we also need to make sure that we are referencing the correct stadia
--=======================================================================================================================================================================================
-- stadium condition
-- for the stadium condition we don't need to use the location of the building to link the condition information
-- as the buildings all have a name that is human-friendly

-- Stadium 1 - Alyeko Stadium
insert into ucesoan.stadium_condition
(stadium_id, roof_condition, seating_condition, disabled_access_condition, washroom_condition, surveillance_condition, floodlight_condition, giant_screen_condition, user_id)
values
((select stadium_id from ucesoan.stadia where stadium_name like '%Alyeko Stadium'), --stadium_name
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'),  -- roof
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- seating
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- disabled_access
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- washroom
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- surveillance
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- floodlight
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- giant_screen
(select user_id from ucesoan.users where user_name = 'user1')); --user


-- Stadium 2 - Ralfni Stadium
insert into ucesoan.stadium_condition
(stadium_id, roof_condition, seating_condition, disabled_access_condition, washroom_condition, surveillance_condition, floodlight_condition, giant_screen_condition, user_id)
values
((select stadium_id from ucesoan.stadia where stadium_name like '%Ralfni Stadium'), --stadium_name
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'),  -- roof
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- seating
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- disabled_access
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- washroom
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- surveillance
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- floodlight
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- giant_screen
(select user_id from ucesoan.users where user_name = 'user2')); --user

-- Stadium 3 - Crossledge Stadium
insert into ucesoan.stadium_condition
(stadium_id, roof_condition, seating_condition, disabled_access_condition, washroom_condition, surveillance_condition, floodlight_condition, giant_screen_condition, user_id)
values
((select stadium_id from ucesoan.stadia where stadium_name like '%Crossledge Stadium'), --stadium_name
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'),  -- roof
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- seating
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- disabled_access
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- washroom
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- surveillance
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- floodlight
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- giant_screen
(select user_id from ucesoan.users where user_name = 'user3')); --user

--==================================================================================================================================================================================
-- court_condition
-- court 1 in Alyeko Stadium
insert into ucesoan.court_condition(court_id, net_condition, umpire_chair_condition, players_bench_condition, hawkeye_technology_condition, user_id)
values 
((select b.court_id from ucesoan.courts b where b.location =st_geomfromtext('POLYGON((547827 180871, 547827 180879, 547851 180879, 547851 180871, 547827 180871))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user1')), --user


-- court 2 in Alyeko Stadium				   
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547827 180879.5, 547827 180887.5, 547851 180887.5, 547851 180879.5, 547827 180879.5))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- court 3 in Alyeko Stadium
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547827 180888, 547827 180896, 547851 180896, 547851 180888, 547827 180888))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- court 4 in Ralfni Stadium
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547751 180941, 547751 180949, 547775 180949, 547775 180941, 547751 180941))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- court 5 in Ralfni Stadium
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547751 180949.5, 547751 180957.5, 547775 180957.5, 547775 180949.5, 547751 180949.5))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- court 6 in Ralfni Stadium
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547751 180958, 547751 180966, 547775 180966, 547775 180958, 547751 180958))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%evidence of%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- court 7 in Crossledge Stadium
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547901 180941, 547901 180949, 547925 180949, 547925 180941, 547901 180941))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

-- court 8 in Crossledge Stadium
--((select court_id from ucesoan.courts where court_type like '%grass'), --court_id

((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547901 180949.5, 547901 180957.5, 547925 180957.5, 547925 180949.5, 547901 180949.5))',27700)),
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

-- court 9 in Crossledge Stadium
((select b.court_id from ucesoan.courts b where b.location = st_geomfromtext('POLYGON((547901 180958, 547901 180966, 547925 180966, 547925 180958, 547901 180958))',27700)), --court_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'),  -- net_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- umpire_chair_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- players_bench_condition
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%does not%'), -- hawkeye_technology_condition
(select user_id from ucesoan.users where user_name = 'user3')); --user

--=====================================================================================================================================================================

--floodlight_condition
-- Floodlight 1, 2, 3, and 4 in Alyeko Stadium
insert into ucesoan.floodlight_condition(light_id, condition, user_id)
values
((select light_id from ucesoan.floodlights where light_name like '%Floodlight 1'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 2'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 3'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 4'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- Floodlight 5, 6, 7, and 8 in Ralfni Stadium

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 5'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 6'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 7'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 8'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user
  
-- Floodlight 9, 10, 11, 12 in Crossledge Stadium
((select light_id from ucesoan.floodlights where light_name like '%Floodlight 9'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 10'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 11'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

((select light_id from ucesoan.floodlights where light_name like '%Floodlight 12'), --light_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')); --user
--===========================================================================================================================================
--seating_condition
insert into ucesoan.seating_condition(seating_id, condition, user_id)
values
-- Alyeko West
((select seating_id from ucesoan.seating where seating_name like '%Alyeko West'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- Alyeko North
((select seating_id from ucesoan.seating where seating_name like '%Alyeko North'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- Alyeko East 
((select seating_id from ucesoan.seating where seating_name like '%Alyeko East'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- Alyeko South
((select seating_id from ucesoan.seating where seating_name like '%Alyeko South'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user1')), --user

-- Ralfni West
((select seating_id from ucesoan.seating where seating_name like '%Ralfni West'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%new%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- Ralfni North
((select seating_id from ucesoan.seating where seating_name like '%Ralfni North'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- Ralfni East 
((select seating_id from ucesoan.seating where seating_name like '%Ralfni East'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- Ralfni South
((select seating_id from ucesoan.seating where seating_name like '%Ralfni South'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%replacement within%'), -- condition
(select user_id from ucesoan.users where user_name = 'user2')), --user

-- Crossledge West
((select seating_id from ucesoan.seating where seating_name like '%Crossledge West'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

-- Crossledge North
((select seating_id from ucesoan.seating where seating_name like '%Crossledge North'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

-- Crossledge East 
((select seating_id from ucesoan.seating where seating_name like '%Crossledge East'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')), --user

-- Crossledge South
((select seating_id from ucesoan.seating where seating_name like '%Crossledge South'), --seating_id
(select asset_health_indicator_id from ucesoan.asset_health_indicator where asset_health_indicator_description like '%overdue for%'), -- condition
(select user_id from ucesoan.users where user_name = 'user3')); --user