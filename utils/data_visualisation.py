import pandas as pd
import psycopg2
import numpy as np
import matplotlib.pyplot
import os

from utils.data_extraction import create_connection
from datetime import datetime, timedelta
import streamlit as st

@st.cache_data
def import_all_data(user):
    try:
        connection = create_connection()
        cursor = connection.cursor()
        with open("./sql/import_all_datas_for_user.sql") as f:
            cursor.execute(f.read(), (user,))
            data = cursor.fetchall()
        columns = ["date", ]
        df_sport = pd.DataFrame(data)  
        return df_sport

    except (Exception, psycopg2.Error) as error:
        print(f"Error while fetching data: {error}")
        return None, None

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()

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
    try: 
        df_all_sport["date_seance"] = pd.to_datetime(df_all_sport["date_seance"])
    except: 
        print("donnée date_seance déjà transformée")
#
    date_series = calculate_time_delta(time_analyse)
    df_time_period = df_all_sport[
        (df_all_sport["date_seance"] >= date_series.min()) & 
        (df_all_sport["date_seance"] <= date_series.max())
    ]
    return df_time_period
