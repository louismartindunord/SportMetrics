import pandas as pd
import psycopg2
import numpy as np
import matplotlib.pyplot
import os
import streamlit as st
from utils.data_extraction import create_connection
from datetime import datetime, timedelta
import streamlit as st

@st.cache_data
<<<<<<< HEAD
def import_all_data(user):
    try:
        connection = create_connection()
        cursor = connection.cursor()
        with open("./sql/import_all_datas_for_user.sql") as f:
            cursor.execute(f.read(), (user,))
            data = cursor.fetchall()
        df_sport = pd.DataFrame(data)  # penser à definir les colonnes
        return df_sport
=======
def import_all_data(user:int)-> pd.DataFrame:
    #try:
    print(f'user_id {user}')
    print(type(user))
    connection = create_connection()
    cursor = connection.cursor()
    with open("./sql/select_all_datas_for_user.sql","r") as f:
        cursor.execute(f.read(), (user,user))
        data = cursor.fetchall()
    columns = ["date","sport","exercice","duree","seance","poid","nbr_repetitions"] 
    df_sport = pd.DataFrame(data,columns=columns)  
    return df_sport

    #except (Exception, psycopg2.Error) as error:
    #    print(f"Error while fetching data: {error}")
    #    return None, None
##
    #finally:
    #    if cursor:
    #        cursor.close()
    #    if connection:
    #        connection.close()
>>>>>>> origin/main

def create_empty_timeserie(time_analyse:str)->pd.Series:
    today_date = datetime.today().date()
    if time_analyse == "Semaine":
        end_date = today_date - timedelta(weeks=1)
    elif time_analyse == "Mois":
        end_date = today_date - timedelta(days=30)
    elif time_analyse == "Année":
        end_date = today_date - timedelta(days=365)
    else:
        raise ValueError("time_analyse must be 'week', 'month', or 'year'")
    
    return pd.date_range(start=end_date, end=today_date)

<<<<<<< HEAD
@st.cache_data
def calculate_time_delta(date_options: str):
    today = datetime.today()  # type: ignore
    if date_options == "Semaine":
        time_delta = today - timedelta(days=7)
    elif date_options == "mois":
        time_delta = today - timedelta(days=30)
    elif date_options == "Années":
        time_delta = today - timedelta(days=365)
    return time_delta

@st.cache_data
def filter_by_time_period(df_all_sport: pd.DataFrame, time_analyse: str):
    print(df_all_sport)
    return 'lals'
    #try: 
    #    df_all_sport["date_seance"] = pd.to_datetime(df_all_sport["date_seance"])
    #except: 
    #    print("donnée date_seance déjà transformée")
#
    #date_series = calculate_time_delta(time_analyse)
    #df_time_period = df_all_sport[
    #    (df_all_sport["date_seance"] >= date_series.min()) & 
    #    (df_all_sport["date_seance"] <= date_series.max())
    #]
    #return df_time_period
=======

def filter_by_time_period(df_all_sport: pd.DataFrame, time_analyse: str):
    try: 
        df_all_sport["date"] = pd.to_datetime(df_all_sport["date"])
    except: 
        print("donnée date_seance déjà transformée")
    
    date_series = create_empty_timeserie(time_analyse)
    df_time_period = df_all_sport[
        (df_all_sport["date"] >= date_series.min()) & 
        (df_all_sport["date"] <= date_series.max())
    ]
    df_time_period['did_sport_this_day'] = df_time_period['date'].apply(lambda x: 1 if x in df_time_period['date'].values else 0)

    return df_time_period
>>>>>>> origin/main
