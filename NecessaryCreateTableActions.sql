create database Bollywood;
use Bollywood;
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
# import all the tables and then run this

# while importing make sure you import movie file into new table bollywoodmoviedetail
INSERT INTO movie (
    imdbId, title, releaseYear, releaseDate,
    genre, writers, actors, directors,
    sequel, hitFlop,actor_id,director_id
)
SELECT
    imdbId,
    title,
    releaseYear,
	STR_TO_DATE(NULLIF(releaseDate, 'N/A'), '%d-%b-%y'),
    genre,
    writers,
    actors,
    directors,
   sequel,
   hitFlop,actor_id,director_id   
FROM bollywoodmoviedetail;

# now drop bollywoodmoviedetail table

select * from movie;
select * from actor;
select * from director;

DESCRIBE movie;
describe actor;
describe director;
#now do reverse engineering

-- 8. Descriptive Statistics
SELECT COUNT(*) AS total_movies, AVG(releaseYear) AS avg_release_year FROM Movie;
SELECT AVG(movieCount), MIN(movieCount), MAX(movieCount) FROM Actor;
SELECT AVG(ratingSum), MIN(ratingSum), MAX(ratingSum) FROM Director;

-- 9. Data Cleaning

#checking if matching records exist in master table and deleting that data

DELETE FROM DIRECTOR WHERE DIRECTORID IN (select D.DIRECTORID from movie M RIGHT JOIN (SELECT directorName, directorId, row_number() 
over (partition by directorName order by directorId asc) rnk
FROM director) D on m.director_id= D.directorID
where D.rnk>1);

-- 10. Aggregation and Grouping
SELECT genre, COUNT(*) AS movie_count FROM Movie GROUP BY genre;
SELECT actors, directors, HitFlop FROM Movie 
GROUP BY actors, directors, HitFlop;

-- 11. Joins and Relationships
SELECT M.title, A.actorName, D.directorName
FROM Movie M
JOIN Actor A ON M.actor_id = A.actorId
JOIN Director D ON M.director_id = D.directorId
order by directorName;

-- 12. Subquery Example
SELECT title, releaseYear
FROM Movie
WHERE releaseYear = (SELECT MAX(releaseYear) FROM Movie);

-- 13. CTE Example
WITH GenreCount AS (
    SELECT genre, COUNT(*) AS movie_count
    FROM Movie
    GROUP BY genre
)
SELECT * FROM GenreCount ORDER BY movie_count DESC;

-- 14. Window Function Example
SELECT title, releaseYear,
       RANK() OVER (PARTITION BY genre ORDER BY releaseYear DESC) AS genre_rank
FROM Movie;

-- 15. Reverse Engineering (e.g., ERD is assumed part of report)
-- Use workbench or other ERD tools to create ER diagram visually from schema