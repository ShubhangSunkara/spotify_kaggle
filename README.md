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

##  Business Queries

1. Retrieve the names of all tracks that have more than 1 billion streams
```sql
SELECT * FROM spotify
WHERE stream > 1000000000;
```

2. Find the top 10 tracks with high energy (>0.8) and danceability (>0.7) but with fewer than 100,000 views
```sql
SELECT track, album FROM spotify
WHERE energy > 0.8 AND danceability > 0.7 AND views < 100000
ORDER BY energy DESC, danceability DESC
LIMIT 10;
```

3. Count the total number of tracks by each artist
```sql
SELECT artist, COUNT(track) AS track_count 
FROM spotify 
GROUP BY artist
ORDER BY artist;
```

4. Calculate the average danceability of tracks in each album
```sql
SELECT album, AVG(danceability) AS avg_danceability 
FROM spotify
GROUP BY album;
```

5. Find the top 3 most liked tracks per album where views > 1 million and danceability > 0.6
```sql
WITH cte AS (
  SELECT track, album, likes, views, danceability,
         RANK() OVER(PARTITION BY album ORDER BY likes DESC) AS rnk 
  FROM spotify 
  WHERE views > 1000000 AND danceability > 0.6
)
SELECT track, album, likes, views, danceability
FROM cte 
WHERE rnk <= 3;
```

6. For each album, calculate the total views of all associated tracks
```sql
SELECT album, SUM(views) AS total_views 
FROM spotify 
GROUP BY album
ORDER BY total_views DESC;
```

7. Calculate the average number of views for tracks with an official video vs. those without
```sql
WITH official_video AS (
  SELECT AVG(views) AS official_avg 
  FROM spotify 
  WHERE official_video = 'true'
),
no_official_video AS (
  SELECT AVG(views) AS no_official_avg 
  FROM spotify 
  WHERE official_video = 'false'
)
SELECT official_avg, no_official_avg, 
       (official_avg - no_official_avg) AS views_difference
FROM official_video, no_official_video
ORDER BY views_difference DESC;
```

8. Find the top 3 most-viewed tracks for each artist
```sql
WITH ranked_tracks AS (
  SELECT artist, track,
         RANK() OVER(PARTITION BY artist ORDER BY views DESC) AS rnk 
  FROM spotify
)
SELECT artist, track 
FROM ranked_tracks
WHERE rnk <= 3;
```

9. Write a query to find tracks where the liveness score is above the average
```sql
SELECT track, energy_liveness
FROM spotify
WHERE energy_liveness > (
  SELECT AVG(energy_liveness) FROM spotify
)
ORDER BY energy_liveness DESC;
```

10. Calculate the difference between the highest and lowest energy values for tracks in each album
```sql
WITH cte AS (
  SELECT album, 
         MAX(energy_liveness) AS highest_energy, 
         MIN(energy_liveness) AS lowest_energy 
  FROM spotify
  GROUP BY album
)
SELECT album, 
       (highest_energy - lowest_energy) AS energy_difference 
FROM cte
ORDER BY energy_difference DESC;
```

## Query Optimisation
```sql
Analyze performance of a query using EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT artist, track, views 
FROM spotify
WHERE artist = 'Gorillaz'
  AND most_played_on = 'Youtube'
ORDER BY stream DESC;
```

Create an index on the artist column to improve query performance
```sql
CREATE INDEX artist_index ON spotify (artist);
```

---

## Findings

- Tracks with higher **energy** and **danceability** consistently received more streams and likes, indicating strong listener preference for upbeat music.  
- Presence of an **official video** significantly boosted track views, emphasizing the impact of visual content on audience engagement.  
- A small group of **top artists** accounted for a disproportionately high number of total streams, revealing strong market concentration.  
- **Singles** tended to outperform full albums in terms of streams, suggesting user preference for quick, standalone content.  
- Streaming activity peaked shortly after release dates, highlighting the importance of **early promotional efforts**.


