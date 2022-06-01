--The next Tennis Grand Slam Competition is in late Januray, 2022 at Abrabo Tennis Sports Complex.
--The following seven decisions will help the management make preparations for the event.

--The first three decisions are based on the views created which are based on the TECHNOLOGY theme. 
--=====================================================================================================================================================================
-- 1. Hawkeye technology helps supports umpires in their decision making on court. At times, when umpires are not sure whether balls
-- played are just in or out, they call on haweye which is a real-time technology which has video data on ball movements on court. 
-- It would be benefical to find courts which have hawkeye technology and their condition or courts without hawkeye. 
-- It would be also beneficial to determine the installation and replacement costs of hawkeye technology on court to help 
-- management know how much money to spend on it. 
-- [T5 in the pyramid]

select court_id, court_type, criticality_of_court, asset_health_indicator_description as hawkeye_technology_condition, 
cost_of_installing_hawkeye, cost_of_replacing_hawkeye from ucesoan.court_technology_condition_criticality_cost;


--=====================================================================================================================================================================
-- 2.
-- Still on the technology theme, surveillance and giant screens are going to be looked at here. Becuase of their roles at stadia 
-- and the ability of these technology to improve the quality of competions and for good decison making. Surveillance can help to
-- detect unfortunate incidences that may have occurred in the stadia and to identify perpertrators that may have been involved in the acts.  
-- Giant screens help spectators re-live certain good moments during the game such as a great point won by the players. We want to find 
-- any giant_screens or surveillance equipment absent or present in the stadia and their conditions so as to know their states and whether they
-- need installation or replacement and how much it will cost to do so.
-- [T3 in the pyramid]

select a.stadium_name, b.asset_health_indicator_description as surveillance_condition_text, 
a.surveillance_installation_cost, a.surveillance_replacement_cost, b.asset_health_indicator_description as giant_screen_condition_text,
a.giant_screen_installation_cost, a.giant_screen_replacement_cost, a.court_type, b.asset_health_indicator_description as hawkeye_condition_text,
a.cost_of_installing_hawkeye, a.cost_of_replacing_hawkeye
from ucesoan.stadium_technology_condition_criticality_cost a inner join ucesoan.asset_health_indicator b
on a.surveillance_condition = b.asset_health_indicator_id;


--====================================================================================================================================================================== 
-- 3.  A decision has to be made about much to spend out of the budget to install or replace all technolgy devices in the entire 
-- complex(in the courts and stadia). As well as how much to spend to install surveillance at the four corners of the complex for human safefty.
-- [T2 in the pyramid]

with complex_tech_cost_and_installing_surveillance_complex_cost as 
(select a.*, b.parameter_value as cost_of_installing_surveillance_at_complex from ucesoan.tennis_complex_technology_condition_cost a 
inner join ucesoan.latest_parameters b
on a.tennis_sports_complex_name = b.parameter_subname
and parameter_type = 'technology-surveillance installation cost' 
and parameter_name = 'tennis sports complex')

select * from complex_tech_cost_and_installing_surveillance_complex_cost;
 



--=====================================================================================================================================================================
-- 4. -- floodlights
-- For games played in the evening or late afternoon, lighting is key. This is also related to the theme human comfort and safety.
-- From the latest_parameters view, the min floodlight value for comfort is 30000 lumens, while the max light value for comfort is 60000 lumens.
-- We want to find the stadia which has floodlights -- values of 30000 lumens or grater, so that more games can be scheduled to be played
-- there. The followings sql query helps to answer the question: 'Which stadia has the best lighting for comfort during tennis competitons?'
-- [Associated with H5 in the pyramid]


with floodlight_timestamp_value_lumens as 
(select distinct(floodlight_id), reading_timestamp, value_lumens from ucesoan.floodlight_values where value_lumens >= 
(select parameter_value from ucesoan.latest_parameters 
where parameter_type = 'comfort' and
parameter_subname = 'min lumens value')
order by reading_timestamp),

court_brightness as 
(select b.light_id, b.stadium_id, b.light_name, b.light_brand, a.value_lumens
from floodlight_timestamp_value_lumens a
left join ucesoan.floodlights b
on a.floodlight_id= b.light_id)

select a.stadium_name, b.light_name, b.light_brand, b.value_lumens
from ucesoan.stadia a inner join court_brightness b
on a.stadium_id= b.stadium_id;


--=====================================================================================================================================================================
-- 5. By running this query, we want to make a decision based on whether ticket prices should go up or remain the same. 
-- Assuming the budget for maintenance costs and fixing assets in the complex is 30,000 pounds, if for the three day event, all three stadia are filled to capcity, 
-- how much will be obtained at the end of the tournament? Having spent 30,000 pounds on maintenance in preparation for the event, will the complex run at a loss or 
-- make profit? After running the query if a loss is estimated, the ticket prices should be increased. If a profit is made, ticket prices should remain the same. 
-- [B8 in the pyramid]

with stadium_seating_area as 
(select a.stadium_name, b.seating_name, b.stadium_id, st_area(b.location) from 
ucesoan.stadia a inner join ucesoan.seating b on a.stadium_id = b.stadium_id),

total_seating_area_in_stadia as 
(select stadium_name, sum(st_area) as total_seating_area_sq_m from stadium_seating_area
group by stadium_name
order by total_seating_area_sq_m desc),

seating_area_per_person as 
(select parameter_value as size_of_one_seat from ucesoan.latest_parameters --seating area
where parameter_type = 'comfort' and 
parameter_name = 'stadium' and
parameter_subname = 'inside stadium requirements per person'),

ticket_cost_per_person as 
(select parameter_value as one_ticket_costs from ucesoan.latest_parameters --ticket cost per person
where parameter_type = 'income' and 
parameter_name = 'inside stadium' and
parameter_subname = 'ticket cost')

select a.stadium_name, (a.total_seating_area_sq_m/b.size_of_one_seat)::integer as stadium_capacity, c.one_ticket_costs, 
((a.total_seating_area_sq_m/b.size_of_one_seat)::integer*c.one_ticket_costs*3) as tickets_generated_income_at_end_of_3_days
from total_seating_area_in_stadia a, seating_area_per_person b, ticket_cost_per_person c;



--=====================================================================================================================================================================
-- 6. Budget for court condition for umpire and players. cost of replacing benches, nets, [H6 in the pyramid]
                                                                                                                                                                               
--join the condition of courts that will increase the quality of games for players and umpires and join to stadium to get stadium_name
with stadium_id_court_playing_condition as
(select c.stadium_id, c.court_type, b.asset_health_indicator_description as net_condition, b.asset_health_indicator_description as umpire_chair_condition,
b.asset_health_indicator_description as players_bench_condition, a.report_date
from ucesoan.court_condition a inner join ucesoan.asset_health_indicator b
on a.net_condition = b.asset_health_indicator_id inner join ucesoan.courts c on a.court_id = c.court_id),

stadium_court_playing_condition_criticality as 
(select b.stadium_name, c.criticality as stadium_criticality, a.* from stadium_id_court_playing_condition a inner join ucesoan.stadia b
on a.stadium_id = b.stadium_id inner join ucesoan.criticality c
on b.criticality = c.criticality_id),

get_net_replacement_cost as 
(select a.*, b.parameter_value as cost_of_replacing_net 
from stadium_court_playing_condition_criticality a inner join ucesoan.latest_parameters b 
on a.court_type = b.parameter_subname
and b.parameter_type = 'net replacement cost' and b.parameter_name = 'court'),

get_umpire_chair_replacement_cost as
(select c.parameter_subname, c.parameter_value as cost_of_replacing_umpire_chair from ucesoan.latest_parameters c 
where c.parameter_type = 'umpire chair replacement cost' and c.parameter_name = 'court'),

get_players_bench_replacement_cost as 
(select d.parameter_subname, d.parameter_value as cost_of_replacing_players_bench from ucesoan.latest_parameters d
where d.parameter_type = 'players bench replacement cost' and d.parameter_name = 'court')

select a.stadium_name, a.stadium_criticality, a.stadium_id, a.court_type, a.net_condition, a.cost_of_replacing_net, 
a.umpire_chair_condition, b.cost_of_replacing_umpire_chair, a.players_bench_condition, c.cost_of_replacing_players_bench 
from get_net_replacement_cost a inner join get_umpire_chair_replacement_cost b
on a.court_type = b.parameter_subname inner join get_players_bench_replacement_cost c
on a.court_type = c.parameter_subname;


--=====================================================================================================================================================================
-- 7. We want to find the total cost to replace floodlights in bad condition which will be 
-- used to decide what percentage of the total budget to be spent for floodlights. [B3 in the pyramid]

--do we need to install or replace any floodlights before the next grand slam tourney?
with floodlight_condition_description as 
(select a.light_id, b.asset_health_indicator_description as floodlight_condition_text
from ucesoan.floodlight_condition a inner join ucesoan.asset_health_indicator b 
on a.condition = b.asset_health_indicator_id),

light_name_corresponding_stadium as
(select a.light_id, a.light_name, a.light_brand, a.stadium_id
from ucesoan.floodlights a inner join ucesoan.floodlight_condition b
on a.light_id = b.light_id),

stadia_with_lights_overdue_for_replacement as 
(select b.light_name, b.light_brand, a.floodlight_condition_text, c.stadium_name from floodlight_condition_description a 
inner join light_name_corresponding_stadium b on a.light_id= b.light_id inner join ucesoan.stadia c on b.stadium_id = c.stadium_id
where floodlight_condition_text like '%overdue for%'),

stadium_flood_light_replacement_cost as 
(select a.*, b.parameter_value as replacement_cost from stadia_with_lights_overdue_for_replacement a inner join ucesoan.latest_parameters b
on a.light_brand = b.parameter_subname
and b.parameter_type = 'replacement cost' and b.parameter_name = 'floodlight')

select sum(replacement_cost) as total_replacement_cost_of_floodlights from stadium_flood_light_replacement_cost;
--=====================================================================================================================================================================
