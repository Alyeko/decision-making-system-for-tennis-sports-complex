--=============================================================================================================================================================================================================================================
--Views--
--=============================================================================================================================================================================================================================================
--=============================================================================================================================================================================================================================================
--view 1 for  --latest_parameters
--=============================================================================================================================================================================================================================================

drop view if exists ucesoan.latest_parameters cascade;
create view ucesoan.latest_parameters as

with 
latest_parameters as
(select parameter_type, parameter_name, parameter_subname, max(date_created) as date_created
from ucesoan.parameters
group by parameter_type, parameter_name, parameter_subname)

select a.parameter_id, a.parameter_value, b.* from ucesoan.parameters a inner join 
latest_parameters b
on a.parameter_type = b.parameter_type
and a.parameter_name = b.parameter_name
and a.parameter_subname = b.parameter_subname 
and a.date_created = b.date_created;

--=============================================================================================================================================================================================================================================
--view 2 for lower level(courts) --court_technology_condition_criticality_cost
--=============================================================================================================================================================================================================================================
drop view if exists ucesoan.court_technology_condition_criticality_cost cascade;
create or replace view ucesoan.court_technology_condition_criticality_cost as 

--first get the latest tech condition reports
with latest_tech_report as 
(select distinct on (court_id) court_id, user_id, report_date, hawkeye_technology_condition
from ucesoan.court_condition
order by court_id, report_date desc),

--now join the condition status
tech_report_condition as
(select a.*, b.asset_health_indicator_description 
from latest_tech_report a inner join ucesoan.asset_health_indicator b
on a.hawkeye_technology_condition = b.asset_health_indicator_id),

--now get the user information
report_user as 
(select h.*, j.user_name
from tech_report_condition h inner join ucesoan.users j
on h.user_id = j.user_id),

--now join this to the court_information
--use a full outer join here
court_condition as 
(select d.court_id, d.location, d.stadium_id, d.court_type, d.court_installation_date, d.criticality as criticality_id, f.report_date, f.hawkeye_technology_condition, f.asset_health_indicator_description, f.user_name
from ucesoan.courts d full outer join report_user f
on d.court_id = f.court_id),

--now include the criticality information
--use an outer join 
court_criticality as 
(select a.criticality as criticality_of_court, b.*
from court_condition b full outer join ucesoan.criticality a 
on a.criticality_id = b.criticality_id),

--include cost information
court_hawkeye_installation_cost as 
(select a.court_type, a.court_id, b.parameter_value as cost_of_installing_hawkeye, st_area(a.location)
from ucesoan.courts a inner join ucesoan.latest_parameters b
on a.court_type = b.parameter_subname
and b.parameter_name = 'court'
and parameter_type = 'technology-hawkeye installation cost'),


court_hawkeye_replacement_cost as 
(select a.court_type, a.court_id, b.parameter_value as cost_of_replacing_hawkeye
from ucesoan.courts a inner join ucesoan.latest_parameters b
on a.court_type = b.parameter_subname
and b.parameter_name = 'court'
and parameter_type = 'technology-hawkeye replacement cost')

-- finally join it all together 
select a.*, b.cost_of_installing_hawkeye, c.cost_of_replacing_hawkeye
from court_criticality a inner join court_hawkeye_installation_cost b on a.court_id = b.court_id inner join court_hawkeye_replacement_cost c on b.court_id = c.court_id;


--=================================================================================================================================================================================================================================
--view 3 for middle level(stadia) --stadium_technology_condition_criticality_cost
--=================================================================================================================================================================================================================================
drop view if exists ucesoan.stadium_technology_condition_criticality_cost cascade;
create or replace view ucesoan.stadium_technology_condition_criticality_cost as 

with stadia_tech_condition as 
(select a.*, b.surveillance_condition, b.giant_screen_condition from ucesoan.court_technology_condition_criticality_cost a inner join ucesoan.stadium_condition b
on a.stadium_id = b.stadium_id),

stadia_tech_condition_stadium_name as 
(select a.*, b.stadium_name, b.tennis_sports_complex_id from stadia_tech_condition a inner join ucesoan.stadia b on a.stadium_id = b.stadium_id),

cost_of_surveillance_installation as
(select a.*, b.parameter_value as surveillance_installation_cost
from stadia_tech_condition_stadium_name a inner join ucesoan.latest_parameters b --or full outer join?? --maybe for the upper level view you can find the overall cost of how much to spend??
on a.stadium_name = b.parameter_subname
and b.parameter_name = 'stadium'
and b.parameter_type = 'technology-surveillance installation cost'),

cost_of_surveillance_replacement as 
(select a.stadium_name, b.parameter_value as surveillance_replacement_cost
from ucesoan.stadia a full join ucesoan.latest_parameters b
on a.stadium_name = b.parameter_subname
and b.parameter_name = 'stadium'
and b.parameter_type = 'technology-surveillance replacement cost'),

cost_of_giant_screen_installation as 
(select a.stadium_name, b.parameter_value as giant_screen_installation_cost
from ucesoan.stadia a full join ucesoan.latest_parameters b
on a.stadium_name = b.parameter_subname
and b.parameter_name = 'stadium'
and b.parameter_type = 'technology-giant screen installation cost'),

cost_of_giant_screen_replacement as 
(select a.stadium_name, b.parameter_value as giant_screen_replacement_cost
from ucesoan.stadia a full join ucesoan.latest_parameters b
on a.stadium_name = b.parameter_subname
and b.parameter_name = 'stadium'
and b.parameter_type = 'technology-giant screen replacement cost')

--joining all the tables
select a.*, b.surveillance_replacement_cost, c.giant_screen_installation_cost, d.giant_screen_replacement_cost
from cost_of_surveillance_installation a inner join cost_of_surveillance_replacement b on a.stadium_name = b.stadium_name inner join cost_of_giant_screen_installation c on b.stadium_name = c.stadium_name join cost_of_giant_screen_replacement d on c.stadium_name = d.stadium_name;






--==================================================================================================================================================================================================================================
--view 4 for upper level(tennis_sports_complex)-- tennis_complex_technology_condition_cost 
--==================================================================================================================================================================================================================================
drop view if exists ucesoan.tennis_complex_technology_condition_cost cascade;
create or replace view ucesoan.tennis_complex_technology_condition_cost as 


with tennis_complex_stadia_tech_condition_costs as 
(select c.tennis_sports_complex_name, a.stadium_name, b.asset_health_indicator_description as surveillance_condition_text, 
a.surveillance_installation_cost, a.surveillance_replacement_cost, b.asset_health_indicator_description as giant_screen_condition_text,
a.giant_screen_installation_cost, a.giant_screen_replacement_cost, a.court_type, b.asset_health_indicator_description as hawkeye_condition_text,
a.cost_of_installing_hawkeye, a.cost_of_replacing_hawkeye
from ucesoan.stadium_technology_condition_criticality_cost a inner join ucesoan.asset_health_indicator b
on a.surveillance_condition = b.asset_health_indicator_id inner join ucesoan.tennis_sports_complex c
on a.tennis_sports_complex_id = c.tennis_sports_complex_id) 

select * from tennis_complex_stadia_tech_condition_costs; 
--====================================================================================================================================================================================================================================
