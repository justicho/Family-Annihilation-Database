# Family-Annihilation-Database
## Project Overview

This project aims to develop a comprehensive database to analyze family annihilation cases in the United States from 2013 to 2025. Using data sourced from the [Gun Violence Archive](https://www.gunviolencearchive.org/), the primary objective is to address the absence of a centralized resource that provides insights into the characteristics and prevalence of this specific crime. The project utilizes MySQL and MySQL Workbench for data management and analysis.

## Background

Family annihilation, or familicide, is a type of murder or murder-suicide in which an individual or group of individuals kill multiple family members in succession, often including children, spouses, siblings, or parents. In most of these cases, the killer(s) ultimately commits suicide. This database seeks to categorize such incidents to provide deeper insights into these tragic events.

## Technologies Used

MySQL: For database creation, storage, and query execution.

MySQL Workbench: As the graphical interface for database management and development.

## Setup Instructions

1. **Install MySQL Server and MySQL Workbench** if not already installed.
2. **Clone the repository**:
   ```bash
   git clone https://github.com/justicho/Family-Annihilation-Database.git
3. Create Database Schema:
   - Open a new SQL script window in MySQL Workbench and create the "familyannihilationdb" schema.
   - Execute the `familyAnnihilationDB.sql` script to configure the database schema.
   - Use the MySQL Workbench Data Import Wizard to load your CSV files into the corresponding tables (e.g., "malelist," "femalelist"). These files should contain the filtered data from the Gun Violence Archive. Note that besides the "incidents" table, all other filtered lists only need to import the `IncidentID`s.

## Explore and Analyze

With the database set up, you can now execute queries to gain insights from the data, including analysis of attributes like gender, age range, suspect status (such as whether they were killed, arrested, or committed suicide), the number of victims killed, and more.  Utilize the provided SQL script examples as a starting point. 

### Querry Example From SQL Script

- Calculate the distribution of incidents by suspect's gender, status, and age range, showing both counts and percentages within the dataset:
  ```sql
  SELECT 
    suspectGender,
    suspectStatus,
    suspectAgeRange,
    COUNT(*) AS Count,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM incidents) * 100), 2) AS Percentage
  FROM incidents
  GROUP BY suspectGender, suspectStatus, suspectAgeRange;

QUERRY OUTPUT:

![image alt](https://github.com/justicho/Family-Annihilation-Database/blob/a23ce6a6e197b6ea041c7f15336d2f636f56e878/Querry%20Example.png)

## Authors/Contributors

Justin Mingi Choi

## Data Source 

The dataset used in this project is sourced from the [Gun Violence Archive](https://www.gunviolencearchive.org/), a non-profit organization cataloging gun violence incidents across the United States. 


