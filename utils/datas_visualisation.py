import pandas as pd
import psycopg2
import numpy as np
import matplotlib.pyplot
import os

from utils.data_extraction import create_connection


def import_all_data(user):
    try:
        connection = create_connection()
        cursor = connection.cursor()
        with open("./sql/import_all_datas_for_user.sql") as f:
            cursor.execute(f.read, (user,))
            data = cursor.fetchall()
        df_sport = pd.DataFrame(data)  # penser à definir les colonnes
        return df_sport

    except (Exception, psycopg2.Error) as error:
        print(f"Error while fetching data: {error}")
        return None, None

    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
