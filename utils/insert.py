import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from psycopg2 import sql, errors

import os

from dotenv import load_dotenv

load_dotenv()

DATABASE = os.getenv("DATABASE")
HOST = os.getenv("HOST")
USER = os.getenv("USER")
PASSWORD = os.getenv("PASSWORD")
PORT = os.getenv("PORT")


def push_musculation_exercice(sport_name: str, muscle_area: str):
    file = "sql/insert_musculation_exercices.sql"
    connection = psycopg2.connect(
        host=HOST, database=DATABASE, user=USER, password=PASSWORD
    )
    cursor = connection.cursor()
    try:
        with open(file, "r") as f:
            command = f.read()
        cursor.execute(command, (sport_name, muscle_area))
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


def send_serie(
    sport_type,
    selected_date,
    selected_muscle_area: str,
    selected_exercice: str,
    poid: float,
    number_repetition: int,
    comments: str,
    user_id: int,
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
