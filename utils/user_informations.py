from utils.cookie_connection import create_connection
import streamlit as st
import datetime
import psycopg2
import pandas as pd
import numpy as np
import base64
from io import BytesIO
from PIL import Image
import PIL


def get_user_informations(user_id: int) -> pd.DataFrame:
    connexion = None
    cursor = None
    try : 
        connexion = create_connection()
        cursor = connexion.cursor()
    
    except (Exception, psycopg2.Error) as error:
        print('{} - connection will be reset'.format(error))
        if cursor:
            cursor.close()
        if connexion:
            connexion.close()
        connexion = create_connection()
        cursor = connexion.cursor()

    finally:  
        if cursor is not None: 
            with open("sql/get_all_users_informations.sql", "r") as f:
                cursor.execute(f.read(), (user_id,))
                result = cursor.fetchall()
                connexion.commit()
            columns = [
                "id",
                "username",
                "email",
                "poid",
                "taille",
                "objectif",
                "modification_date"      
            ]
            data = pd.DataFrame(result, columns=columns)
            return data
        else : 
            print("Cursor or connection could not be established.")
            return pd.DataFrame()







@st.fragment
def render_user_informations(user_info: pd.DataFrame, editable):

    if st.session_state["user_informations_editable"] == False:
        user_connexion_information_container = st.container(border=True)
        user_connexion_information_container.write(f"Votre identifiant : {user_info["username"][0]}")
        user_connexion_information_container.write(f"Votre email : {user_info["email"][0]}")
        user_connexion_information_container.write(f"Votre poid : {user_info["poid"][0]} kg")
        user_connexion_information_container.write(f"Votre taille : {user_info["taille"][0]} cm")
        user_connexion_information_container.write(f"Votre objectif : {user_info["objectif"][0]}")
        if st.button("modifier"):
            st.session_state["user_informations_editable"] = True   
            st.rerun()

    else:
        user_goal = ["Perdre du poid", "Prendre du muscle", "Me maintenir en forme"]
        with st.form(key="user_informations_form"):
            username = st.text_input("Votre pseudo : ", value=user_info["username"].iloc[0])
            email = st.text_input("Votre email: ", value=user_info["email"].iloc[0])
            user_weight = st.number_input("Quelle est votre poid (kg)?", )
            user_height = st.number_input("Quelle est votre taille (cm)?")
            user_goal = st.selectbox("Quel est votre objectif",options=user_goal)
            submitted_user_informations_button = st.form_submit_button("Envoyer")
            if submitted_user_informations_button:
               post_user_information(username, email, user_weight,user_height, user_goal)
              
def post_user_information(username, email, user_weight, user_height, user_goal):
    user_id = st.session_state["user_id"]
    today = datetime.datetime.today()
    connexion = create_connection()
    cursor = connexion.cursor()

    try:
        # 1. Mettre à jour l'utilisateur dans la table `users`
        update_query = """
        UPDATE users
        SET username = %s, email = %s
        WHERE username = %s;
        """
        cursor.execute(update_query, (username, email, username))

        # 2. Insérer les informations supplémentaires dans la table `users_informations`
        insert_query = """
        INSERT INTO users_informations(user_id, poid, taille, objectif, modification_date)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(insert_query, (user_id, user_weight, user_height, user_goal, today))
        connexion.commit()

    except Exception as e:
        # Gérer les erreurs
        st.error(str(e))
        st.session_state["authenticated"] = False

    finally:
        if cursor:
            cursor.close()
        if connexion:
            connexion.close()
            st.session_state["user_informations_editable"] = False
        
