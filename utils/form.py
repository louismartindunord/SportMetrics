import streamlit as st
from .insert import push_sport_exercice, push_musculation_exercice
from .data_extraction import get_muscle_area
from psycopg2 import sql, errors


def insert_add_sport_form(default_value="oui"):
    musculation_sport = st.session_state.musculation_sport_selectbox
    if musculation_sport == "oui":
        muscleareas = get_muscle_area()
        select_musclearea = st.selectbox("Quelle est la zone musuculaire ?", options=muscleareas)
        sport_name = st.text_input("Nom de l'exercice")
        sport_name = sport_name.title()
        if st.button(label='envoyer'):
            try:
                push_musculation_exercice(sport_name,select_musclearea)
                st.success("Exercice enregistré")
            except errors.UniqueViolation as e:
                st.error("Ce sport existe déjà")
            except:
                st.error("Avez vous rentré les informations")

    elif musculation_sport == "non":
        sport_name = st.text_input("Quelle est le nom du sport ?")
        sport_name = sport_name.title()
        if st.button(label='Envoyer'):
            try: 
                push_sport_exercice(sport_name)
                st.success("Sport enregistré")

            except errors.UniqueViolation as e:
                st.error("Cette exercice existe déjà")
            except:
                st.error("erreur")
 