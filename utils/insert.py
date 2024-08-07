import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from psycopg2 import sql, errors
import numpy as np
import pandas as pd

from utils.cookie_connection import create_connection, create_pandas_connection_engine

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


def push_cross_trainning_exercice(cross_trainning_exerice: str, select_musclearea: str):
    file = "sql/insert_cross_trainning_exercice.sql"
    connection = create_connection()
    cursor = connection.cursor()
    try:
        with open(file, "r") as f:
            command = f.read()
            cursor.execute(command, (cross_trainning_exerice, select_musclearea))
            connection.commit()
    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")
    finally:
        cursor.close()
        connection.close()


def send_musculation_serie(
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


def push_cross_training_serie(serie_name):
    connection = create_connection()
    cursor = connection.cursor()
    try:
        # Lire le contenu du fichier SQL
        with open("sql/create_cross_trainning_serie.sql", "r") as file:
            query = file.read()

        # Exécuter la requête SQL
        cursor.execute(query, (serie_name,))
        connection.commit()

    except (Exception, psycopg2.Error) as error:
        print(f"Error while inserting series: {error}")
        return None

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def get_cross_serie_id(serie_name):
    connection = create_connection()
    cursor = connection.cursor()
    sql = """
            SELECT series_id
            FROM cross_trainning_series            
            WHERE name = (%s) 
            """
    try:
        cursor.execute(sql, (serie_name,))
        serie_id = cursor.fetchone()
        print("cross_training_serie_id : ", serie_id)
        return int(serie_id[0])

    except (Exception, psycopg2.Error) as error:
        print(f"Error while inserting series: {error}")
        return None

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def get_cross_exercice_id(exercice_name):
    connection = create_connection()
    cursor = connection.cursor()
    sql = """
            SELECT exercices_id 
            FROM cross_trainning_exercices 
            WHERE name = (%s) 
            """
    try:
        cursor.execute(sql, (exercice_name,))
        exercice_id = cursor.fetchone()
        return int(exercice_id[0])

    except (Exception, psycopg2.Error) as error:
        print(f"Error while inserting series: {error}")
        return None

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def push_cross_exercises_to_serie(exercises_df, serie_name):
    array_exercice_id = []
    engine = create_pandas_connection_engine()
    conn = engine.connect()

    # Assuming get_cross_serie_id and get_cross_exercice_id are defined elsewhere
    exercises_df["series_id"] = get_cross_serie_id(serie_name)

    for index, row in exercises_df.iterrows():
        exercice_id = get_cross_exercice_id(exercice_name=row["Exercice"])
        array_exercice_id.append(exercice_id)

    exercises_df["exercices_id"] = pd.Series(array_exercice_id)

    df_to_push = exercises_df[
        ["series_id", "exercices_id", "duree", "nombre_repetition"]
    ]
    df_to_push.to_sql(
        name="series_exercices", con=conn, if_exists="append", index=False
    )


def send_cross_serie(
    selected_cross_trainning_serie_id: int,
    number_of_cross_trainning_serie: int,
    user_id: int,
):
    connection = create_connection
    cursor = connection.cursor()
    try:
        with open("insert_cross_trainning_serie_rows", "r") as f:
            connection.execute(
                f,
                (
                    selected_cross_trainning_serie_id,
                    number_of_cross_trainning_serie,
                    user_id,
                ),
            )
            connection.commit()

    except (Exception, psycopg2.Error) as error:
        print(f"Error while inserting series: {error}")
        return None

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
