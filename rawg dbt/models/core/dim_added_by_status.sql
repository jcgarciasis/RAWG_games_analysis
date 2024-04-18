{{
    config(
        materialized='table'
    )
}}

select
    id_game,
    name,
    added_by_status_yet,
	added_by_status_owned,
	added_by_status_toplay,
	added_by_status_dropped,
	added_by_status_playing
	
  from dbt_jcgarcia.stg_staging_rawg_games
