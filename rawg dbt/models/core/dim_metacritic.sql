{{
    config(
        materialized='table'
    )
}}

select
    id_game,
    name,
	metacritic
from dbt_jcgarcia.stg_staging_rawg_games