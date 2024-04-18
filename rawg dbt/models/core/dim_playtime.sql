{{
    config(
        materialized='table'
    )
}}

select
    id_game,
    name,
	playtime
  from dbt_jcgarcia.stg_staging_rawg_games