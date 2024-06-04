import pandas as pd
from sqlalchemy import create_engine
import psycopg2
import os

from dotenv import load_dotenv
load_dotenv()

DATABASE = os.getenv('DATABASE')
HOST = os.getenv('HOST')
USER = os.getenv('USER')
PASSWORD = os.getenv('PASSWORD')
PORT = os.getenv('PORT')


   

def create_table():
    file = "sql/create_database.sql"
    connection = psycopg2.connect(host=HOST, database=DATABASE, user=USER, password=PASSWORD)
    cursor = connection.cursor()
    try :
        with open(file,'r') as f:
            command = f.read()
            cursor.execute(command)
            connection.commit()
            print("Tables created successfully")
    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")

    finally :
        cursor.close()
        connection.close()



def alter_table():
    file = "sql/alter_table.sql"
    connection = psycopg2.connect(host=HOST, database=DATABASE, user=USER, password=PASSWORD)
    cursor = connection.cursor()
    try :
        with open(file,'r') as f:
            command = f.read()
            cursor.execute(command)
            connection.commit()
            print("Tables created successfully")
    except (Exception, psycopg2.Error) as error:
        print(f"Error while creating tables: {error}")

    finally :
        cursor.close()
        connection.close()

def insert_muscle_area():
    file ="sql/insert_musculation_area.sql"
    muscle_areas = ["Dos","Pectoraux", "Jambes","Épaules","Bras","Dorsaux"]
    connection = psycopg2.connect(host=HOST, database=DATABASE, user=USER, password=PASSWORD)
    cursor = connection.cursor()
    for muscle_area in muscle_areas:
        try:
            with open(file,'r') as f:
                command = f.read()
                cursor.execute(command, (muscle_area,))
                connection.commit()
                print("muscle_area inserted")
        except (Exception, psycopg2.Error) as error:
            print(error)
        
    cursor.close()
    connection.close()



