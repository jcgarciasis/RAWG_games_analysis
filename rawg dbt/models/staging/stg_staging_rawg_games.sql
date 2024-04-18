{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging_rawg', 'games') }}

),

renamed as (

    select
        id as id_game,
        name,
        tba,
        released,
        rating,
	    rating_top,
        exceptional,
	    recommended,
	    meh,
	    skip,
	    playtime,
	    metacritic,
	    reviews_count,
	    esrb_rating_name,
	    added_by_status_yet,
	    added_by_status_owned,
	    added_by_status_toplay,
	    added_by_status_dropped,
	    added_by_status_playing,
        platform_names

    from source
)

select * from renamed