import spotipy
from spotipy.oauth2 import SpotifyOAuth
from spotipy.oauth2 import SpotifyClientCredentials
from spotipy import Spotify
import pandas as pd
import psycopg2
import psycopg2.extras
import os
import sys

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import config
from config.conf import conf

def create_table(df, table_name, column_list, column_schema_list):
    """
    
    Creating a PostgreSQL table from Pandas DataFrame
    Parameters:
        DF: Pandas DataFrame (clean Dataframe beforehand so the input is the intended dtype)
        Table_name: Name shown in Postgres
        Column_list: List of column names in DataFrame
        Column_schema_list: List of dtypes from DataFrame that must match the order of column_list
        
    """
    
    try:
        # Connect to the database
        conn = psycopg2.connect(
            host = conf['host'], 
            dbname = conf['dbname'], 
            user = conf['user'], 
            password = conf['password'], 
            port = conf['port']
        )
        cur = conn.cursor()

        # Drop table if it exists
        cur.execute(f""" 
                    DROP TABLE IF EXISTS {table_name}
                    """)

        # Construct CREATE TABLE dynamically
        columns_with_types = ', '.join([f'{col} {dtype}' for col, dtype in zip(column_list, column_schema_list)])
        create_table_query = f"""
                    CREATE TABLE IF NOT EXISTS {table_name} ({columns_with_types})
                    """
    

        # Execute CREATE TABLE 
        cur.execute(create_table_query)

        # Construct INSERT query dynamically
        placeholders = ", ".join(["%s"] * len(column_list))
        insert_query = f"""
                    INSERT INTO {table_name} ({', '.join(column_list)}) VALUES ({placeholders})
                     """

        # Insert rows from dataframe
        for _, row in df.iterrows():
            cur.execute(insert_query, tuple(row[col] for col in column_list))


        conn.commit()
        cur.close()
        conn.close()
    except Exception as error:
        print(error)