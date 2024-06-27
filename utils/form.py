import streamlit as st
import pandas as pd
from psycopg2 import sql, errors

from .insert import (
    push_sport_exercice,
    push_musculation_exercice,
    push_cross_trainning_exercice,
    push_cross_trainning_serie,
)
from .data_extraction import get_muscle_area, get_all_cross_trainning_exercice


def insert_add_sport_form(sports_selection: str, user_id: int):

    if sports_selection == "Musculation":
        muscleareas = get_muscle_area()
        select_musclearea = st.selectbox(
            "Quelle est la zone musuculaire ?", options=muscleareas
        )
        sport_name = st.text_input("Nom de l'exercice")
        sport_name = sport_name.title()
        if st.button(label="envoyer"):
            try:
                push_musculation_exercice(sport_name, select_musclearea)  # type: ignore
                st.success("Exercice enregistré")
            except errors.UniqueViolation as e:
                st.error("Ce sport existe déjà")
            except:
                st.error("Avez vous rentré les informations")

    elif sports_selection == "Sport":
        sport_name = st.text_input("Quelle est le nom du sport ?")
        sport_name = sport_name.title()
        if st.button(label="Envoyer"):
            try:
                push_sport_exercice(sport_name)
                st.success("Sport enregistré")

            except errors.UniqueViolation as e:
                st.error("Cette exercice existe déjà")
            except:
                st.error("erreur")

    elif sports_selection == "Cross-Trainning":
        serie_or_exercice = st.selectbox(
            "Voulez vous ajoutez une serie ou un exercice ?",
            options=["Exercice", "Serie"],
        )
        if serie_or_exercice == "Exercice":
            cross_trainning_exerice = st.text_input("Nom de l'exercice")
            if st.button(label="Envoyer"):
                cross_trainning_exerice = cross_trainning_exerice.title()
                try:
                    push_cross_trainning_exercice(cross_trainning_exerice, user_id)
                    st.success("Sport enregistré")

                except errors.UniqueViolation as e:
                    st.error("Cette exercice existe déjà")
                except:
                    st.error("erreur")

        elif serie_or_exercice == "Serie":
            user_id = st.session_state["user_id"]
            cross_trainning_exerices = get_all_cross_trainning_exercice(user_id)
            serie_name = st.text_input("Donner un nom à cette serie")
            created_cross_serie = pd.DataFrame(
                data=None, columns=["Exercice", "Nbr de répétition", "durée"]
            )
            edited_cross_serie = st.data_editor(
                created_cross_serie,
                num_rows="dynamic",
                use_container_width=True,
                column_config={
                    "Exercice": st.column_config.SelectboxColumn(
                        "Exercice",
                        width="medium",
                        options=cross_trainning_exerices,
                        required=True,
                    )
                },
            )
            if st.button("Créer serie") and edited_cross_serie:
                try:
                    push_cross_trainning_serie(serie_name, edited_cross_serie, user_id)
                    st.success("Sport enregistré")

                except errors.UniqueViolation as e:
                    st.error("Cette exercice existe déjà")
                except:
                    st.error("erreur")
