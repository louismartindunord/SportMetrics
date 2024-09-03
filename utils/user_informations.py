from utils.cookie_connection import create_connection
import streamlit as st
import datetime
import psycopg2

def get_user_informations(user_id):
    try:
        connexion = create_connection()
        cursor = connexion.cursor()
        with open("sql/get_all_users_informations.sql","r") as f:
            cursor.execute(f.read(),(user_id,))
            data = cursor.fetchone()
        return data
    
    except (Exception, psycopg2.Error) as error:
        print(f"Error while fetching data: {error}")
        return None, None

    finally:
        if cursor:
            cursor.close()
        if connexion:
            connexion.close()
   

def user_informations_form(user_informations):
    user_goal = ["Perdre du poid", "Prendre du muscle", "Me maintenir en forme"]
    with st.form(key=user_informations_form):
        user_height = st.number_input("Quelle est votre taille ?")
        user_weight = st.number_input("Quelle est votre poid?")
        user_goal = st.select_box("Quel est votre objectif", options=user_goal)
        if st.form_submit_button():
            now = datetime.now()
            send_user_informations(user_height,user_weight,user_goal,now)


def post_user_information():
    pass

    


    