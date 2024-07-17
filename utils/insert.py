import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from psycopg2 import sql, errors
import numpy as np

from utils.data_extraction import create_connection

import os

from dotenv import load_dotenv

load_dotenv()

DATABASE = os.getenv("DATABASE")
HOST = os.getenv("HOST")
USER = os.getenv("USER")
PASSWORD = os.getenv("PASSWORD")
PORT = os.getenv("PORT")


def push_musculation_exercice(sport_name: str, muscle_area: str, username: str):
    file = "sql/insert_musculation_exercices.sql"
    connection = psycopg2.connect(
        host=HOST, database=DATABASE, user=USER, password=PASSWORD
    )
    cursor = connection.cursor()
    try:
        with open(file, "r") as f:
            command = f.read()
        cursor.execute(command, (sport_name, muscle_area, username))
        connection.commit()
    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")
    finally:
        cursor.close()
        connection.close()


def push_sport_exercice(sport_name: str):
    file = "sql/insert_sport_exercice.sql"
    connection = psycopg2.connect(
        host=HOST, database=DATABASE, user=USER, password=PASSWORD
    )
    cursor = connection.cursor()
    try:
        with open(file, "r") as f:
            command = f.read()
            cursor.execute(command, (sport_name,))
            connection.commit()
    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")
    finally:
        cursor.close()
        connection.close()


def push_cross_trainning_exercice(cross_trainning_exerice: str, user_id):
    file = "sql/insert_cross_trainning_exercice.sql"
    connection = psycopg2.connect(
        host=HOST, database=DATABASE, user=USER, password=PASSWORD
    )
    cursor = connection.cursor()
    try:
        with open(file, "r") as f:
            command = f.read()
            cursor.execute(command, (cross_trainning_exerice, user_id))
            connection.commit()
    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")
    finally:
        cursor.close()
        connection.close()


def send_serie(
    sport_type,
    selected_date,
    selected_muscle_area,
    selected_exercice,
    poid,
    number_repetition,
    comments,
    user_id,
):
    try:
        if sport_type == "Musculation":
            file = "sql/insert_musculation_row.sql"
            connection = psycopg2.connect(
                host=HOST, database=DATABASE, user=USER, password=PASSWORD
            )
            cursor = connection.cursor()

            with open(file, "r") as f:
                command = f.read()
                cursor.execute(
                    command,
                    (
                        selected_date,
                        selected_muscle_area,
                        selected_exercice,
                        poid,
                        number_repetition,
                        comments,
                        user_id,
                    ),
                )
                connection.commit()

        elif sport_type == "Sport":
            file = "sql/insert_musculation_row.sql"
            connection = psycopg2.connect(
                host=HOST, database=DATABASE, user=USER, password=PASSWORD
            )
            cursor = connection.cursor()

            with open(file, "r") as f:
                command = f.read()
                cursor.execute(
                    command,
                    (
                        selected_date,
                        selected_muscle_area,
                        selected_exercice,
                        poid,
                        number_repetition,
                        comments,
                        user_id,
                    ),
                )
        elif sport_type == "Cross-Trainning":
            pass

    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")
    finally:
        cursor.close()
        connection.close()


def push_cross_trainning_serie(serie_name, edited_cross_serie, user_id):
    try:
        sql = "sql/create_cross_trainning_serie.sql"
        connection = create_connection()
        cursor = connection.cursor()
        cursor.execute(sql, (serie_name, user_id))
        series_id = cursor.fetchone()[0]
        return series_id

    except (Exception, psycopg2.Error) as error:
        print(f"Error while inserting series: {error}")
        return None

    finally:
        if cursor:
            cursor.close()
        if connexion:
            connexion.close()


def push_cross_exercices_to__serie(series_id, exercises_df):
    try:
        connection = create_connexion()
        cursor = connection.cursor()
        with open(insert_exercises_to_cross_serie.sql, "r") as f:
            for index, row in edited_cross_serie.iterrows():
                cursor.execute(f.read(), (series_id, row["Exercice"]))
    except (Exception, psycopg2.Error) as error:
        print("error while inserting the exercice from this serie", error)

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
