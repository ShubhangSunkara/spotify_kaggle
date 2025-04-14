--Business Queries--

--1. Retrieve the names of all tracks that have more than 1 billion streams
select * from spotify
where stream > 1000000000

--2.Find the top 10 tracks with high energy (>0.8) and danceability (>0.7) but with fewer than 100,000 views
select track, album from spotify
where energy >0.8 and danceability > 0.7 and views < 100000
ORDER BY energy DESC, danceability DESC
limit 10

--3.Count the total number of tracks by each artist
select artist, count(track) as track_count from spotify 
group by artist
order by artist

--4.Calculate the average danceability of tracks in each album
select album, avg(danceability) as avg_danceability from spotify
group by album

--5.Find the top 3 most liked tracks per album where views > 1 million and danceability > 0.6
with cte as (
select track,album,likes,views,danceability,
rank() over(partition by album order by likes desc) rnk 
from spotify 
where views >1000000 and danceability > 0.6)

select track,album,likes,views,danceability
from cte 
where rnk <=3

--6.For each album, calculate the total views of all associated tracks
select album, sum(views) as total_views from spotify 
group by album
order by sum(views) desc

--7.Calculate the average number of likes for tracks with an official video vs. those without
with official_video as ( select avg(views) as official_avg from spotify where official_video='true'),
no_official_video as ( select avg(views)as no_official_avg from spotify where official_video='false')
select official_avg, no_official_avg, (official_avg-no_official_avg) as views_difference
from official_video,no_official_video
order by views_difference desc

--8.Find the top 3 most-viewed tracks for each artist
with ranked_tracks as 

(select artist, track,
rank() over(partition by artist order by views desc) as rnk 
from spotify)

select artist, track 
from ranked_tracks
where rnk <=3

--9.Write a query to find tracks where the liveness score is above the average
SELECT track, energy_liveness
FROM spotify
WHERE energy_liveness > (SELECT AVG(energy_liveness) FROM spotify)
ORDER BY energy_liveness DESC

--10.Calculate the difference between the highest and lowest energy values for tracks in each album
with cte as(
select album, max(energy_liveness) as highest_energy, min(energy_liveness) as lowest_energy from spotify
group by album)

select album, (highest_energy-lowest_energy)as energy_difference 
from cte
order by 2 desc

--Query Optimisation

EXPLAIN ANALYZE
select artist, track, views from spotify
where artist='Gorillaz'
and most_played_on='Youtube'
order by stream desc

CREATE INDEX artist_index on spotify (artist);