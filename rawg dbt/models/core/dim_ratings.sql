{{
    config(
        materialized='table'
    )
}}

select
    id_game,
    name,
	rating,
	rating_top,
	exceptional,
	recommended,
	meh,
	skip
  from dbt_jcgarcia.stg_staging_rawg_games
