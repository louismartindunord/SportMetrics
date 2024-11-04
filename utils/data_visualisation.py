from pydoc import text
from turtle import title
import pandas as pd
import psycopg2
import numpy as np
import matplotlib.pyplot
import os
from utils.data_extraction import create_connection
from datetime import datetime, timedelta
import streamlit as st
import plotly.express as px
import plotly.graph_objects as go
import random


### Fonction basé sur l'ensemble des périodes


@st.cache_data
def import_sport_info(user_id) -> pd.DataFrame | tuple[None, None]:
    try:
        connection = create_connection()
        cursor = connection.cursor()
        with open("./sql/select_all_datas_for_user.sql") as f:
            cursor.execute(f.read(), (user_id, user_id))
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
def import_user_infos(user_id: int) -> pd.DataFrame | tuple[None, None]:
    try:
        connection = create_connection()
        cursor = connection.cursor()
        with open("./sql/get_all_users_informations.sql") as f:
            cursor.execute(f.read(), (user_id,))
            result = cursor.fetchall()
        columns = [
            "user_id",
            "username",
            "email",
            "poid",
            "taille",
            "objectif",
            "date",
        ]
        df_user_info = pd.DataFrame(data=result, columns=columns)
        return df_user_info
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


def plot_sport_frequence(df: pd.DataFrame, date_options: str):
    timeseries = calculate_time_delta(date_options=date_options)
    df_timeseries = pd.DataFrame(timeseries, columns=["date"])
    df_timeseries["did_sport_this_day"] = df_timeseries["date"].apply(
        lambda x: 1 if x in df["date"].values else 0
    )
    df_timeseries_true = df_timeseries.loc[df_timeseries["did_sport_this_day"] == 1]
    print(df_timeseries_true.head())
    st.bar_chart(df_timeseries, x="date", y="did_sport_this_day")


def get_last_user_info(df_user_infos: pd.DataFrame):
    return df_user_infos.sort_values("date", ascending=False).iloc[0]


def write_metrics(user_infos: pd.DataFrame, metric, label="", delta_color="normal"):
    user_infos = user_infos.sort_values("date", ascending=False)
    metrics_difference = user_infos[metric].iloc[0] - user_infos[metric].iloc[1]
    print(metrics_difference)
    st.metric(
        label=label,
        value=float(user_infos[metric].iloc[0]),
        delta=float(metrics_difference),
        delta_color=delta_color,
    )


#

#
# def plot_metrics(label, value, prefix="", suffix="",show_graphe=False, color_graph=""):
#    fig = go.Figure()
#    fig.add_trace(
#        go.Indicator(value=value,
#                     gauge={"axis":{visible:False}}),
#                     number={"prefix":prefix,
#                             "suffix":suffix,
#                             "font_size":28,
#                             },
#                    title={"text"=lable,
#                           "font": {"size:24"}}
#                    )
#    if show_graphe:
#        fig.add_trace(go.Scatter(
#            y=randio
#        ))
#

### Fonction basé sur la période semaines


def get_day_of_the_week(days_columns: pd.Series) -> pd.Series:
    week_dict = {
        0: "Lundi",
        1: "Mardi",
        2: "Mercredi",
        3: "Jeudi",
        4: "Vendredi",
        5: "Samedi",
        6: "Dimanche",
    }
    days_of_week = []
    for day in days_columns:
        day_of_week = day.weekday()
        days_of_week.append(day_of_week)
    days_of_week = pd.Series(days_of_week)
    days_of_week = days_of_week.map(week_dict)
    return days_of_week
