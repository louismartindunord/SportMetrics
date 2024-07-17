import streamlit as st
import pandas as pd
from utils.data_extraction import get_all_sport
from streamlit_card import card
import datetime
from streamlit_option_menu import option_menu
from utils.data_extraction import (
    get_muscle_area,
    get_last_seances,
    get_musculation_exerices_from_muscle_area,
    get_all_sport,
)
from utils.user_authentification import sessions_state
from utils.insert import send_serie

from utils.pages import show_page

show_page()

sessions_state = sessions_state()
user_id = sessions_state["user_id"]
username = sessions_state["username"]

print(user_id)

if username is not None:
    st.sidebar.write("Bonjour ", username)

today = datetime.datetime.today()
horizontal_menu = option_menu(
    "Séléctionner votre entraînement",
    ["Musculation", "Sport", "Cross-Trainning"],
    default_index=0,
    orientation="horizontal",
)

col1, col2 = st.columns(2)

if horizontal_menu == "Musculation":
    with col1:
        is_today = st.selectbox(
            "Faites vous une séance aujourd hui ? ", options=["oui", "non"]
        )
        if is_today == "oui":
            selected_date = today
        elif is_today == "non":
            selected_date = st.date_input("Sélectionner la date", max_value=today)

        all_muscle_areas = get_muscle_area()
        selected_muscle_area = st.selectbox(
            "Quelle zone musculaire ", options=all_muscle_areas
        )
        exercice_for_muscle_area = get_musculation_exerices_from_muscle_area(
            selected_muscle_area
        )
        selected_exercice = st.selectbox(
            "Selectionner l'exercice", options=exercice_for_muscle_area  # type: ignore
        )
        poid = st.number_input("quelle poid (kg)?", min_value=0)
        number_repetition = st.number_input("Combien de réps ?", min_value=0, step=1)
        comments = st.text_area("voulez vous rajouter un commentaire")

        if st.button("envoyer"):
            send_serie(
                sport_type=horizontal_menu,
                selected_date=selected_date,
                selected_muscle_area=selected_muscle_area,
                selected_exercice=selected_exercice,
                poid=poid,
                number_repetition=number_repetition,
                comments=comments,
                user_id=user_id,
            )

elif horizontal_menu == "Sport":
    with col1:
        unique_sports = get_all_sport()
        selected_sport_name = st.selectbox("Sport ?", options=unique_sports)
        durée = st.number_input("Durée?", min_value=0)
elif horizontal_menu == "Cross-Trainning":
    pass
with col2:
    try:
        last_exercice = get_last_seances(horizontal_menu)
        if last_exercice is not None:
            st.write(
                "Votre dernière séance de",
                horizontal_menu,
                last_exercice.head(),  # type: ignore
            )
    except:
        st.write("Vous n'avez de séance de", horizontal_menu, "enrengistrée")
