import pandas as pd
import psycopg2
import os
from dotenv import load_dotenv


def create_connection():
    load_dotenv()
    DATABASE = os.getenv("DATABASE")
    HOST = os.getenv("HOST")
    USER = os.getenv("USER")
    PASSWORD = os.getenv("PASSWORD")
    PORT = os.getenv("PORT")
    connection = psycopg2.connect(
        host=HOST, database=DATABASE, user=USER, password=PASSWORD
    )
    return connection


def get_all_sport():
    file = "sql/select_sport.sql"
    connection = create_connection()
    with open(file, "r") as f:
        cursor = connection.cursor()
        cursor.execute(f.read())
        data = cursor.fetchall()
        sports = [sport for sublist in data for sport in sublist]
        connection.commit()
        connection.close()
    return sports


def get_muscle_area():
    sql = """
            SELECT DISTINCT(name)
            From muscle_area;
            """
    connection = create_connection()
    cursor = connection.cursor()
    cursor.execute(sql)
    all_muscle_area = cursor.fetchall()
    all_muscle_area = [item for sublist in all_muscle_area for item in sublist]
    connection.commit()
    connection.close()
    return all_muscle_area


def get_last_seances(sport_type):
    connection = create_connection()
    cursor = connection.cursor()
    if sport_type == "Musculation":
        try:
            get_last_musculation_query = "sql/get_last_musculation_seance.sql"
            with open(get_last_musculation_query, "r") as f:
                cursor.execute(f.read())
                last_musculation_seance = cursor.fetchall()
                last_musculation_seance = pd.DataFrame(
                    last_musculation_seance,
                    columns=[
                        "date_seance",
                        "sport",
                        "exercice",
                        "duree",
                        "commentaire",
                    ],
                )
                return last_musculation_seance

        except (Exception, psycopg2.Error) as error:
            print(f"Error while fetching data: {error}")
            return None, None

    elif sport_type == "Sport":
        try:
            get_last_sport_query = "sql/get_last_sport_seance.sql"
            with open(get_last_sport_query, "r") as f:
                cursor.execute(f.read())
                last_sport_seance = cursor.fetchall()
                last_sport_seance = pd.DataFrame(
                    last_sport_seance,
                    columns=["Date", "Sport", "Exercice", "Durée", "Commentaire"],
                )
            return last_sport_seance

        except (Exception, psycopg2.Error) as error:
            print(f"Error while fetching data: {error}")
            return None, None  # Ensure the function always returns a tuple

        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()

            elif sport_type == "Cross-Trainning":
                pass


def get_musculation_exerices_from_muscle_area(muscle_area):
    try:
        connection = create_connection()
        cursor = connection.cursor()
        sql = "sql/get_musculation_exerices_from_muscle_area.sql"
        with open(sql, "r") as f:
            cursor.execute(f.read(), (muscle_area,))
            data = cursor.fetchall()
        muscle_exercice = [item for sublist in data for item in sublist]
        return muscle_exercice

    except (Exception, psycopg2.Error) as error:
        print(f"Error while fetching data: {error}")

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def get_all_cross_trainning_exercice():
    try:
        connection = create_connection()
        cursor = connection.cursor()
        sql = "sql/get_all_cross_trainning_exercice_for_the_user.sql"
        with open(sql, "r") as f:
            cursor.execute(f.read())
            list_cross_trainning_exercices = cursor.fetchall()

            return list_cross_trainning_exercices

    except (Exception, psycopg2.Error) as error:
        print(f"Error while fetching data: {error}")

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
