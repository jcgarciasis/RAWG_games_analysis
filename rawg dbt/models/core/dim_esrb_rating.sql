{{
    config(
        materialized='table'
    )
}}

select
    id_game,
    name,
	esrb_rating_name
  from dbt_jcgarcia.stg_staging_rawg_games
