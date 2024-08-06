import streamlit as st
import pandas as pd
from psycopg2 import sql, errors

from .insert import (
    push_sport_exercice,
    push_musculation_exercice,
    push_cross_trainning_exercice,
    push_cross_training_serie,
    push_cross_exercises_to_serie,
)
from .data_extraction import get_muscle_area, get_all_cross_trainning_exercice


def insert_add_sport_form(
    sports_selection: str,
):

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
            muscleareas = get_muscle_area()
            select_musclearea = st.selectbox(
                "Quelle est la zone musuculaire ?", options=muscleareas
            )

            if st.button(label="Envoyer"):
                cross_trainning_exerice = cross_trainning_exerice.title()
                try:
                    push_cross_trainning_exercice(
                        cross_trainning_exerice, select_musclearea
                    )
                    st.success("Sport enregistré")

                except errors.UniqueViolation as e:
                    st.error("Cette exercice existe déjà")

        elif serie_or_exercice == "Serie":
            cross_trainning_exerices = get_all_cross_trainning_exercice()
            serie_name = st.text_input("Donner un nom à cette serie")

            created_cross_serie = pd.DataFrame(
                data=None, columns=["Exercice", "nombre_repetition", "duree"]
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
            )  # type: ignore

            if st.button("Créer serie") and not edited_cross_serie.empty:
                print("le dataframe :", edited_cross_serie.head())
                if serie_name:
                    push_cross_training_serie(serie_name)
                    push_cross_exercises_to_serie(
                        exercises_df=edited_cross_serie, serie_name=serie_name
                    )
                    st.success(
                        "Nouvelle serie d'exerice de cross-trainning enrengistrée"
                    )
                else:
                    st.error("Veuillez indiquer un nom pour cette serie d'exercice")
