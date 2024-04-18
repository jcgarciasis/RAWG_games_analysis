{{
    config(
        materialized='table'
    )
}}

select
        id_game,
        name,
	    platform_names
from dbt_jcgarcia.stg_staging_rawg_games
