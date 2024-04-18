{{
    config(
        materialized='table'
    )
}}

select
    id_game,
    name,
	released,
	extract(month from released) as month,
    extract(year from released) as year

  from dbt_jcgarcia.stg_staging_rawg_games
