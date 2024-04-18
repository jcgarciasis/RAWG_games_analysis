if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

import pandas as pd
from pandas import json_normalize
import json
import os
from pprint import pprint
import csv
import ast


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    ## Create a function to extract ratings from the RAWG dataset

    def extract_counts(ratings_str):
        ratings_list = ast.literal_eval(ratings_str)
        counts_dict = {}
        for rating in ratings_list:
            title = rating['title']
            count = rating['count']
            counts_dict[title] = count
        return counts_dict
   
   ## applying to the function to the ratings column and create a new dataframe with all the ratings with the data unnested

    counts_df = data['ratings'].apply(extract_counts).apply(pd.Series, dtype=int)

    ## Creating a function to extract platform names from the RAWG dataset
    def extract_platform_names(platform_str):
        platforms_list = ast.literal_eval(platform_str)
        platform_names = [platform['platform']['name'] for platform in platforms_list]
        return ' | '.join(platform_names)
    
    ## applying to the function to the parent_platforms colum and create a new data friend with the platform name withe the data unnested
    data['platform_names'] = data['parent_platforms'].apply(extract_platform_names)
    
    ## Merging both dataframe in one including the whole data including ratings and plaforms
    
    final_ratings_data = pd.concat([data, counts_df], axis=1)

    ## including added_by_status count and esrb_rating columns in the final dataframe

    cols = ['added_by_status','esrb_rating']
    for col in cols:
        final_ratings_data[col] = final_ratings_data[col].fillna('').apply(lambda x: x.replace("'", '"'))
        final_ratings_data[col] = final_ratings_data[col].apply(lambda x: json.loads(x) if x else {})
        added = pd.json_normalize(final_ratings_data[[col]].to_dict(orient='records'))
        final_ratings_data = final_ratings_data.join(added, lsuffix='_test', rsuffix='_json')
    
    ## cleaning the final dataframe including just the columns that we are insterested
    column_names = ['id', 'name', 'released', 'tba', 'rating', 'rating_top', 'exceptional', 'recommended', 'meh', 'skip','metacritic','playtime','updated','reviews_count','esrb_rating.name','added_by_status.yet','added_by_status.owned','added_by_status.toplay','added_by_status.dropped','added_by_status.playing','platform_names']
    final_data_cleaned= final_ratings_data[column_names].copy()
    
    return final_data_cleaned


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
