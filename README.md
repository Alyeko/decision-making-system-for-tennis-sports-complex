# 7-decisions-for-Abrabo-tennis-sports-complex
## Good Intro 
The next Tennis Grand Slam Competition is coming up fast at Abrabo Tennis Sports Complex.

In this repository, there are `7` files for the creation of a spatial database from scratch for the Tennis Sports Complex. The file stypes are sql and png. 
## 1. tables.sql
 - There are 14 tables created, with 5 of them having location components and 9 of them without geospatial components

|Table name                       |Has location component(coordinates)?  |
|---------------------------------|----------------------------------- |
|`tennis_sports_complex`          |Yes                                 |
|`stadia`                         |Yes                                 |
|`courts`                         |Yes                                 |
|`floodlights`                    |Yes                                 |
|`seating`                        |Yes                                 |
|`floodlight_values`              |No                                  |
|`stadium_condition`              |No                                  |
|`court_condition`                |No                                  |
|`floodlight_condition`           |No                                  |
|`seating_condition`              |No                                  |
|`users`                          |No                                  |
|`parameters`                     |No                                  |
|`criticality`                    |No                                  |
|`asset_health_indicator`         |No                                  |

## 2. constraints.sql
- There are 4 constraints here. Which are:
  - Primary keys
    - Primary keys ensure that each row of data has an identifier
    - There are 14 primary constraints
  - Foreign keys
    - Foreign keys join one table to another
    - There are 31 foreign constraints
  - Unique constraints
    - Unique constraints validates entries only if they are unique
    - There are 13 primary constraints
  - Check constraints
    - Check constraints ensure that the user doesn't enter values into the database which are not expected. Eg: Entering abbreviations when the database expects actual words
    - There is 1 check constraints
  
## 3. insertdata.sql
- This holds the commands to inset data into the tables. 
- Data is first inserted into the tables which are not connected to other tables

## 4. views.sql
- Views are temporary sql tables that are created from the result of an sql command.
- The views created make it easier to query data from the database
- There are four views created, namely, 
  - `latest_parameters` 
  - `court_technology_condition_criticality_cost`
  -  `stadium_technology_condition_criticality_cost` 
  -  `tennis_complex_technology_condition_cost`

## 5. decisions description.sql
- 7 descriptions of the seven sql commands explaining them further. 

## 6. decisions7.sql
- This file holds the SEVEN decisions that will help in better decision making for the tennis sports complex. 

## 7. QGIS screenshot showing the 5 layers.png
- A screenshot of the database created in a QGIS window
