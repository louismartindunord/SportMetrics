import streamlit as st
import pandas as pd
from utils.data_extraction import get_all_sport
from streamlit_card import card
from utils.data_extraction import (
    get_muscle_area,
    get_last_seances,
    get_musculation_exerices_from_muscle_area,
    get_all_sport,
)
from utils.session_state import session_state_initialisation
from utils.insert import send_serie
import datetime
from streamlit_option_menu import option_menu
import streamlit_authenticator as stauth


from utils.pages import show_page


def main():
    show_page()

    username, user_id = session_state_initialisation()

    if st.session_state["username"]:
        st.write(f"Bienvenue {st.session_state['username']} !")

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
                    selected_date = st.date_input(
                        "Sélectionner la date", max_value=today
                    )

                all_muscle_areas = get_muscle_area()
                selected_muscle_area = st.selectbox(
                    "Quelle zone musculaire ", options=all_muscle_areas
                )
                exercice_for_muscle_area = get_musculation_exerices_from_muscle_area(
                    selected_muscle_area
                )
                selected_exercice = st.selectbox(
                    "Selectionner l'exercice", options=exercice_for_muscle_area
                )
                poid = st.number_input("quelle poid (kg)?", min_value=0)
                number_repetition = st.number_input(
                    "Combien de réps ?", min_value=0, step=1
                )
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
                st.write(
                    "Votre dernière séance de", horizontal_menu, last_exercice.head()
                )
            except:
                st.write("Vous n'avez de séance de", horizontal_menu, "enrengistrée")

    else:
        st.warning("Veuillez vous connecter pour acceder à votre session.")


if __name__ == "__main__":
    main()
