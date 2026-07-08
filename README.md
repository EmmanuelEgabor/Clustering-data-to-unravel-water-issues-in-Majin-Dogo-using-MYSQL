# Maji Ndogo Water Survey Analysis Using SQL

## Project Overview

The **Maji Ndogo Water Survey Analysis** is a SQL-based data exploration and analysis project that investigates water accessibility, infrastructure, and usage patterns across the Maji Ndogo region. The project was completed using **MySQL**, leveraging data collected from the **Maji Ndogo Water Scheme Survey**.

The primary objective was to identify the water sources citizens rely on, determine the number of people served by each source, evaluate water infrastructure, analyze queue times, and generate actionable insights to support better decision-making and resource allocation.

---

## Objectives

This project aimed to answer several key questions about water accessibility in Maji Ndogo:

* Identify the different types of water sources used by citizens.
* Determine the total and average number of users for each water source.
* Assess the availability and functionality of household water infrastructure.
* Analyze water collection queues by day and time.
* Explore employee and location data.
* Clean and standardize employee information.
* Produce insights to support planning and infrastructure improvements.

---

## Dataset

The project utilized data from the **Maji Ndogo Water Scheme Survey**, consisting of several relational tables, including:

* `employee`
* `location`
* `water_source`
* `visits`

Each table provided valuable information that contributed to understanding the current state of water access throughout Maji Ndogo.

---

## Project Tasks

### 1. Data Cleaning

The first stage involved improving the quality of employee records.

Activities included:

* Reviewing employee records.
* Generating official employee email addresses using the format:

```text
first_name.last_name@ndogowater.gov
```

* Removing unnecessary spaces using SQL string functions such as `TRIM()`.
* Updating records directly within the database.

---

### 2. Honouring the Workers

Employee information was explored to understand the geographical distribution of field workers.

Analysis included:

* Employee locations
* Residential distribution
* Workforce coverage

---

### 3. Analysing Locations

The `location` table was explored to understand where water sources are located throughout Maji Ndogo.

Key fields analyzed:

* Province
* Town
* Location Type (Urban/Rural)

This analysis helped determine the geographical distribution of water infrastructure.

---

### 4. Diving into the Water Sources

The `water_source` table was analyzed to answer several important questions:

* How many people were surveyed?
* How many wells, taps, rivers, and shared taps exist?
* How many people share each water source on average?
* How many people depend on each source type?
* Which water sources serve the largest populations?

SQL aggregation functions such as `COUNT()`, `SUM()`, `AVG()`, `GROUP BY`, and `ORDER BY` were used extensively during this stage.

---

### 5. Analysing Queue Times

The `visits` table recorded every visit made by survey teams to water sources.

Analysis focused on:

* Survey duration
* Average queue time
* Queue times by day of the week
* Queue times by hour of the day
* Peak demand periods
* Identifying the busiest days for water collection

Date and time functions were used to uncover temporal trends in water accessibility.

---

## SQL Skills Demonstrated

Throughout the project, the following SQL concepts were applied:

### Data Exploration

* SELECT
* DISTINCT
* LIMIT

### Data Cleaning

* UPDATE
* CONCAT()
* TRIM()

### Filtering

* WHERE
* AND
* OR
* IN
* LIKE

### Aggregation

* COUNT()
* SUM()
* AVG()
* MIN()
* MAX()

### Grouping & Sorting

* GROUP BY
* ORDER BY
* HAVING

### Date & Time Functions

* DAYNAME()
* HOUR()
* TIME()
* DATE()

---

## Key Insights

The analysis produced several important findings regarding water accessibility in Maji Ndogo.

### Water Source Distribution

* Most water sources are located in **rural communities**.

### Shared Water Access

* **43%** of the population relies on **shared taps**.
* On average, **2,000 people share a single tap**, highlighting significant pressure on existing infrastructure.

### Household Water Infrastructure

* **31%** of the population has access to water infrastructure within their homes.
* However, **45%** of these systems are non-functional due to failures in pipes, pumps, and reservoirs.

### Wells

* **18%** of the population depends on wells.
* Only **28%** of these wells provide clean water.

### Queue Times

Citizens experience long waits when collecting water.

* Average queue time exceeds **120 minutes**.

Queue analysis further revealed:

* **Saturdays** have the longest queues.
* Queue times are highest during the **morning** and **evening**.
* **Wednesdays** and **Sundays** experience the shortest waiting times.

---

## Business Impact

The findings from this project provide valuable evidence for improving water accessibility across Maji Ndogo.

The insights can support:

* Infrastructure investment decisions
* Maintenance prioritization
* Water distribution planning
* Public health interventions
* Resource allocation
* Operational scheduling

---

## Tools Used

* MySQL
* SQL
* MySQL Workbench

---

## Skills Demonstrated

* SQL Querying
* Data Cleaning
* Data Exploration
* Relational Database Analysis
* Aggregation & Reporting
* Data Validation
* Data Quality Assessment
* Date & Time Analysis
* Business Intelligence
* Problem Solving

---

## Conclusion

This project demonstrates how SQL can be used to transform raw survey data into actionable insights. By cleaning, validating, and analyzing data from the Maji Ndogo Water Scheme Survey, meaningful patterns in water accessibility, infrastructure reliability, and citizen experience were uncovered.

The project strengthened practical SQL skills while highlighting the importance of data-driven decision-making in addressing real-world challenges related to water resource management.

---

## Author

**Egabor Emmanuel**

**Data Analyst | SQL | Excel | Power BI | Python**
