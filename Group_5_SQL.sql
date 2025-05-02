-- creating database --
create database Bollywood; 
use Bollywood;

-- creating actor table -- 
CREATE TABLE Actor (
    actorId INT PRIMARY KEY,
    actorName VARCHAR(100) NOT NULL,
    movieCount INT,
    ratingSum INT,
    normalizedMovieRank FLOAT,
    googleHits INT,
    normalizedGoogleRank FLOAT,
    normalizedRating FLOAT
);

-- creating Director table-- 
CREATE TABLE Director (
    directorId INT PRIMARY KEY,
    directorName VARCHAR(100) NOT NULL,
    movieCount INT,
    ratingSum INT,
    normalizedMovieRank FLOAT,
    googleHits INT,
    normalizedGoogleRank FLOAT,
    normalizedRating FLOAT
);

-- creating movie table-- 
CREATE TABLE movie (
    imdbId VARCHAR(20) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    releaseYear INT,
    releaseDate DATE,
    genre VARCHAR(100),
    writers TEXT,
    actors TEXT,
    directors TEXT,
    sequel VARCHAR(255),
    hitFlop VARCHAR(50),
    actor_id INT,
    director_id INT,
    FOREIGN KEY (actor_id) REFERENCES actor(actorid),
    FOREIGN KEY (director_id) REFERENCES director(directorid)
);

-- structure of tables created -- 
DESCRIBE movie;
select * from movie;

describe actor;
select * from actor;

describe director;
select * from director;


-- DATA CLEANSING -- 
select count(*),directorName from director group by directorName having count(*)>1; 

-- checking if matching records exist in master table and deleting that data-- 
select * from movie M 
RIGHT JOIN (SELECT directorName, directorId,
row_number() over (partition by directorName order by directorId asc) rnk FROM director) D on m.director_id= D.directorID 
where D.rnk>1;

DELETE FROM DIRECTOR WHERE DIRECTORID IN (select D.DIRECTORID from movie M RIGHT JOIN (SELECT directorName, directorId, row_number() 
over (partition by directorName order by directorId asc) rnk
FROM director) D on m.director_id= D.directorID
where D.rnk>1);

-- Verifying the director Id==119 is no longer available after deltion -- 
select * from director where directorId=119;

-- 	Descriptive Statistics --

-- Generate Descriptive Data of Movie Table: segregating hits and flops,Span of release Years and Average Releases Per Year -- 
SELECT
COUNT(*) AS total_movies,
sum(case when hitFlop >= 5 then 1 else 0 end) as Total_Hit_Movies,
sum(case when hitFlop < 5 then 1 else 0 end) as Total_Flop_Movies,
Round(count(*) / count(distinct releaseyear),0) AS avg_release_year,
MIN(releaseYear) AS earliest_release,
MAX(releaseYear) AS latest_release
FROM Movie;

-- To track the popularity of each genre based on the hit ratio based on Genre’s Popularity and Distribution

SELECT
M.genre,
COUNT(*) AS genre_count,
SUM(CASE WHEN M.hitFlop = 1 THEN 1 ELSE 0 END) AS hit_count
FROM Movie M
JOIN Director D ON M.director_id = D.directorId
GROUP BY M.genre
ORDER BY genre_count DESC limit 10;

-- 15 Topmost Actors with Highest Number Hits -- 
SELECT actors, AVG(hitFlop) AS avg_actor_score,
COUNT(*) AS total_movies
FROM MOVIE
GROUP BY actors
ORDER BY avg_actor_score DESC,
actors asc
limit 15;

-- Aggregation and Grouping -- 
SELECT genre, COUNT(*) AS movie_count FROM Movie GROUP BY genre;
SELECT actors, directors, HitFlop FROM Movie 
GROUP BY actors, directors, HitFlop;

-- Joins and Relationships -- 
SELECT M.title, A.actorName, D.directorName
FROM Movie M
JOIN Actor A ON M.actor_id = A.actorId
JOIN Director D ON M.director_id = D.directorId
order by directorName;

SELECT
m.title,
a.actorName, a.normalizedRating AS actorRating,
d.directorName, d.normalizedRating AS directorRating,
m.hitFlop
FROM movie m
JOIN actor a ON m.actor_id = a.actorId
JOIN director d ON m.director_id = d.directorId;


-- Subquery Example
SELECT title, releaseYear
FROM Movie
WHERE releaseYear = (SELECT MAX(releaseYear) FROM Movie);

-- CTE Example -- 
WITH GenreCount AS (
    SELECT genre, COUNT(*) AS movie_count
    FROM Movie
    GROUP BY genre
)
SELECT * FROM GenreCount ORDER BY movie_count DESC;

WITH DirectorHitRate AS (
    SELECT 
        d.directorid,
        d.directorname AS DirectorName,
        #Round(AVG(m.hitFlop),0) AS Avg_HitRate
        AVG(m.hitFlop) AS Avg_HitRate
    FROM movie m
    JOIN director d ON m.director_id = d.directorid
    GROUP BY d.directorid, d.directorname
),
MovieWithDeviation AS (
    SELECT 
        m.title as Movie_Title,
        m.releaseYear,
        d.DirectorName,
        m.hitFlop as Movie_Hit_Rank,
        d.Avg_HitRate as Hit_Rate_Director,
        m.hitFlop - d.Avg_HitRate AS HitRate_Deviation
    FROM movie m
    JOIN DirectorHitRate d ON m.director_id = d.directorid
)
SELECT *
FROM MovieWithDeviation
WHERE ABS(HitRate_Deviation) > 0.10 
ORDER BY Movie_Hit_Rank desc,HitRate_Deviation desc,DirectorName, releaseYear;

-- Window Function Example
SELECT title, releaseYear,
       RANK() OVER (PARTITION BY genre ORDER BY releaseYear DESC) AS genre_rank
FROM Movie;

SELECT 
    m.title as Movie_Title,
    m.releaseYear,
    d.directorName,
    a.actorName,
    m.hitFlop,
RANK() OVER (PARTITION BY m.director_id ORDER BY m.hitFlop DESC) AS movie_rank_within_director,
ROW_NUMBER() OVER (PARTITION BY m.actor_id ORDER BY m.releaseYear DESC) AS latest_movie_for_actor,
ROUND(AVG(m.hitFlop) OVER (PARTITION BY m.releaseyear), 2) AS overall_avg_hit_rate
FROM movie m
JOIN director d ON m.director_id = d.directorId
JOIN actor a ON m.actor_id = a.actorId order by releaseyear desc,directorName,actorname desc, hitflop;



