from utils.cookie_connection import create_connection
import streamlit as st
import datetime
import psycopg2


def get_user_informations(user_id):
    try:
        connexion = create_connection()
        with connexion.cursor() as cursor:
            with open("sql/get_all_users_informations.sql", "r") as f:
                cursor.execute(f.read(), (user_id,))
                data = cursor.fetchone()
            connexion.commit()
            return data

    except (Exception, psycopg2.Error) as error:
        print(f"Error while fetching data: {error}")
        return None, None

    finally:
        if connexion:
            connexion.close()


def user_informations_form(user_informations):
    user_goal = ["Perdre du poid", "Prendre du muscle", "Me maintenir en forme"]
    with st.form(key="user_informations_form"):
        user_height = st.number_input("Quelle est votre taille ?")
        user_weight = st.number_input("Quelle est votre poid?")
        user_goal = st.selectbox("Quel est votre objectif", options=user_goal)
        if st.form_submit_button():
            now = datetime.now()
            post_user_information(user_height, user_weight, user_goal, now)


def post_user_information():
    pass
