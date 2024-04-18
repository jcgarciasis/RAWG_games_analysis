{{
    config(
        materialized='table'
    )
}}

select
      	srg.id_game,
        srg.name,
    	srg.tba,
    	srg.released,
    	rt.year as year,
    	rt.month as month,
    	srg.rating,
	srg.rating_top,
	srg.exceptional,
	srg.recommended,
	srg.meh,
	srg.skip,
	srg.playtime,
	srg.metacritic,
	srg.reviews_count,
	srg.esrb_rating_name,
	srg.added_by_status_yet,
	srg.added_by_status_owned,
	srg.added_by_status_toplay,
	srg.added_by_status_dropped,
	srg.added_by_status_playing,
	srg.platform_names
  from dbt_jcgarcia.stg_staging_rawg_games as srg
  Left join dbt_jcgarcia.dim_released_time as rt 
  on rt.id_game = srg.id_game and rt.name = srg.name

