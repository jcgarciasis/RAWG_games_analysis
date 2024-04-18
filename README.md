## RAGW Analysis project

In this data engineering project, I have built an end-to-end solution to analyse data from the biggest videogame database RAWG (https://rawg.io), build a ETL pipeline using Mage, modelling the data using dbt cloud before finally visualising the results in a Tableau dashboard published in my personal Tableau Public (https://public.tableau.com/app/profile/juan.garcia6973/viz/RAWGGames_Dasboard/RawgGamesDashboard).
The data is downloaded from Kaggle dataset (https://www.kaggle.com/datasets/pxxthik/rawg-data-delve-rich-tapestry-of-video-games/data?select=games.csv), this dataset is extracted from the RAWG API, I loaded manually the data into my gcs bucket, and then loading it from Google Cloud Storage (Data Lake), doing some transformations, like unnested json columns, cleaning the data and finally extract the data into BigQuery(Data Warehouse). 
After doing the ETL process, I modelled the data to finally push the data into a dashboard.

<img width="1416" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/78dd817c-d271-4951-8ddf-3597f5ace60b">


## Project Objectives

 The aim of this project is to find out some Insights from a dataset with 800K games, 27K creators,70K publishers, metacritic scores, esrb_ratings, release dates, platforms, reviews and habits from RAWG users.
 In order to build this project, I model the data based on star schema technique, building dimension tables from the most important features and finally create a final fact table to help to query the data easily and do further analysis before pointing this table to a tableau dashboard.
 One objective of my project is to find out a comparation between the list of games with the hightest metacritics scores and the longest playtime per year to see if there is a correlation.
 Additionally, I have visualised a trend barchart of how many games has been published over the years from 1975 onwards to see a spike in the videogame industry. This dataset serves as an invaluable resource for researchers, enthusiasts, and industry professionals.

## Data Pipeline Diagram:

![datapipeline_project](https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/4260f341-ac5f-4fea-b185-de06a576079d)

## Reproducibility

Please click[ here](https://github.com/jcgarciasis/RAWG_games_analysis/blob/main/reproducibility.md)

 

 

 

