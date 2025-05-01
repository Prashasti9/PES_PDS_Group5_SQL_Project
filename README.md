# PES_PDS_Group5_SQL_Project
________________________________________
🎬 SQL + Tableau Analysis Project – Bollywood Movie Dataset
________________________________________
🔍 Overview

This project is focused on examining the Bollywood film industry from multiple perspectives—movies, directors, and actors—to gain a comprehensive understanding of:

•	📈 What makes a movie a hit or a flop

•	🧑‍🎤 How an actor’s career and popularity affect performance

•	🎬 How a director's influence contributes to a film’s success

•	⏳ Trends in Bollywood cinema over time

•	🎭 Genre popularity and distribution

•	🔗 Correlations between popularity (e.g. Google hits) and movie performance

________________________________________

📈 Tableau Dashboard
We’ve also included a Tableau Public dashboard for interactive visualization:

🔗 Bollywood_Movie_Analysis_Dashboard_Link
________________________________________

📌 Project Objective
To perform SQL-based data analysis on a curated Bollywood movie dataset and enhance findings through visual storytelling in Tableau.
________________________________________

📂 Dataset Description

🎬 Director Table
Column Name	Description
directorId	Unique ID for each director
directorName	Name of the director
movieCount	Number of movies directed
ratingSum	Sum of ratings for all directed movies
normalizedMovieRank	Normalized score based on movie count
googleHits	Google search result count
normalizedGoogleRank	Normalized popularity from Google hits
normalizedRating	Combined normalized rating score
________________________________________

🎭 Actor Table

Column Name	Description
actorId	Unique ID for each actor
actorName	Name of the actor
movieCount	Number of movies acted in
ratingSum	Total rating of all movies acted in
normalizedMovieRank	Normalized score based on movie count
googleHits	Google search result count
normalizedGoogleRank	Normalized popularity from Google hits
normalizedRating	Combined normalized rating score
________________________________________

🎥 Movie Table

Column Name	Description
imdbId	Unique IMDB movie ID
title	Title of the movie
releaseYear	Year of release
releaseDate	Exact release date
genre	Genre(s) of the movie
writers	Writers of the movie
actor_id	Foreign key referencing actor table
director_id	Foreign key referencing director table
sequel	Indicates if the movie is a sequel (0 or 1)
hitFlop	Subjective score indicating performance
________________________________________

🧠 Analysis Focus Areas

•	🎞️ Movie Performance: Using hitFlop, we determine which movies were hits or flops by year, genre, actor, and director.

•	🧑‍🎤 Actor Performance: Assessed through movieCount, ratingSum, normalizedRating, and googleHits.

•	🎬 Director Performance: Similar metrics applied to gauge director influence and consistency.

•	📆 Trends Over Time: By releaseYear to identify shifts in genre and success patterns.

•	📚 Genre Analysis: Popularity of genres, broken down by year, actor, and director.

•	📊 Correlation Analysis: e.g., relation between normalizedRating and hitFlop, or googleHits vs normalizedMovieRank.
________________________________________

🛠️ Steps Taken
1.	Environment Setup
o	Used MySQL Workbench for querying and schema handling.

2.	Schema Creation
o	Created three normalized tables based on provided schema.

3.	Data Insertion
o	Populated sample data across all tables.

4.	SQL Analysis
o	Performed:

	Descriptive statistics

	Cleaning (N/A handling)

	Aggregations

	Joins and Subqueries

	CTEs and window functions


5.	📊 Tableau Insights


o	Visualized major trends, actor/director scores, and genre distribution.


o	Combined SQL findings with dynamic charts for easier storytelling.
________________________________________

📁 Project Structure
project-folder/
├── schema.sql         # Database schema and sample inserts

├── queries.sql        # SQL logic and analytical queries

├── README.md          # Documentation (this file)

└── presentation.pptx  # Optional summary slides
________________________________________

💡 Key Findings

•	🌟 Aamir Khan has the highest normalized actor rating (10.0).

•	🎥 Rajkumar Hirani stands out as the highest-rated director.

•	🏆 Lagaan (directed by Farah Khan) scored among the top in hitFlop.

•	⚠️ Data cleaning revealed missing writer entries in some records.
________________________________________

✅ Conclusion

This project demonstrated how structured SQL queries and interactive visual dashboards can yield powerful insights from raw data.
The combination of SQL for deep analysis and Tableau for storytelling makes this a valuable template for movie analytics or entertainment data analysis in general.
________________________________________
