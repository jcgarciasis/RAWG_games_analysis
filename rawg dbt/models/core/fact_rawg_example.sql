
rawggame_esrb_year_metacritic_80.sql
{{
    config(
        materialized='table'
    )
}}

select
    srg.id_game,
    srg.name,
    srg.released,
    rt.year as year,
    rt.month as month,
	srg.metacritic,
	srg.esrb_rating_name,
  from dbt_jcgarcia.stg_staging_rawg_games as srg
  Left join dbt_jcgarcia.released_time as rt 
  on rt.id_game = srg.id_game and rt.name = srg.name
  Where srg.metacritic >= 80 and rt.year = 2023