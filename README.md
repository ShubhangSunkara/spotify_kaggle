# Project: Spotify Data Analysis using SQL

This project demonstrates my **SQL skills** through the analysis of a music dataset sourced from **Kaggle**. The dataset contains detailed information about various tracks, including their streams, views, likes, energy, danceability, and other audio features.

---

## Objective

The aim of this project is to showcase **proficiency in writing SQL queries** that answer a wide range of business and analytical questions. These include:

- Data aggregation  
- Filtering and sorting  
- Window functions  
- Use of Common Table Expressions (CTEs)  

All queries are built to solve **real-world music industry problems**.

---

##  Dataset

- **Source**: Kaggle  
- **Tool**: PostgreSQL (via pgAdmin 4)  
- **Table name**: `spotify`  

###  Key attributes in the dataset:
- `track`, `artist`, `album`, `album_type`  
- `streams`, `likes`, `views`  
- `energy`, `danceability`, `official_video`, `energy_liveness`  
- And more...

---
---

### Query Optimization

To improve performance, I analyzed a query that filtered tracks based on the `artist` column using the `EXPLAIN` function.

This helped assess how PostgreSQL planned and executed the query.

#### Index Creation on the `artist` Column

To enhance speed when filtering by artist, I created an index on the `artist` column for faster data retrieval
![query optimisation](https://github.com/user-attachments/assets/73b2b36b-391d-4437-a457-f85eef0b7142)


**SQL Command:**

```sql
CREATE INDEX idx_artist ON spotify(artist);

```

## Technology Stack

- **Database**: PostgreSQL  
- **SQL Concepts**: DDL, DML, Aggregations, Joins, Subqueries, Window Functions  
- **Tools**:  
  - pgAdmin 4
  - PostgreSQL

---

##  How to Run the Project

1. Install PostgreSQL and pgAdmin
2. Set up the database schema and tables 
3. Insert the sample data into the respective tables.  
4. Execute the SQL queries to solve the listed problems.  
5. Explore query optimization techniques for large datasets.

---

## Next Steps

- **Visualize the Data**: Use a data visualization tool like **Tableau** or **Power BI** to create interactive dashboards based on the query results.  
- **Expand Dataset**: Add more rows to the dataset for broader analysis and scalability testing.  
- **Advanced Querying**: Dive deeper into query optimization and explore performance tuning on larger datasets.

---

## Summary of Analysis

A total of **10 carefully designed SQL queries** were written to cover key areas for data analysis

### 
