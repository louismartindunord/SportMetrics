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
        with open("./sql/select_all_datas_for_user.sql") as f:
            cursor.execute(f.read(), (user, user))
            data = cursor.fetchall()
        columns = [
            "date",
            "sport",
            "exercice",
            "duree",
            "seance",
            "poid",
            "nombre_repetition",
        ]
        df_sport = pd.DataFrame(data, columns=columns)
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
    elif date_options == "Mois":
        time_delta = today - timedelta(days=30)
    elif date_options == "Année":
        time_delta = today - timedelta(days=365)
    return pd.date_range(start=time_delta, end=today)


@st.cache_data
def transform_date_column(df):
    df = df.dropna(subset=["date"])
    try:
        df["date"] = pd.to_datetime(df["date"])
    except:
        print("donnée date_seance déjà transformée")
    finally:
        return df["date"]


@st.cache_data
def filter_by_time_period(df_all_sport: pd.DataFrame, time_analyse: str):
    date_series = calculate_time_delta(time_analyse)
    df_time_period = df_all_sport[
        (df_all_sport["date"] >= date_series.min())
        & (df_all_sport["date"] <= date_series.max())
    ]

    return df_time_period


def count_number_of_sport_seance_during_period(df: pd.DataFrame, date_options: str):
    time_serie = calculate_time_delta(date_options)

    df_time_period["did_sport_this_day"] = df_time_period["date"].apply(
        lambda x: 1 if x in df_time_period["date"].values else 0
    )


def plot_sport_frequence(df: pd.DataFrame, date_options: str):
    timeseries = calculate_time_delta(date_options=date_options)
    df_timeseries = pd.DataFrame(timeseries, columns=["date"])
    df_timeseries["did_sport_this_day"] = df_timeseries["date"].apply(
        lambda x: 1 if x in df["date"].values else 0
    )
    df_timeseries_true = df_timeseries.loc[df_timeseries["did_sport_this_day"] == 1]
    print(df_timeseries_true.head())
    st.bar_chart(df_timeseries, x="date", y="did_sport_this_day")
