import streamlit as st
from utils.form_add_sport import insert_add_sport_form
from utils.pages import show_page
from streamlit_option_menu import option_menu
from utils.cookie_connection import sessions_state


sessions_state = sessions_state()


def main(sessions_state):

    user_id = sessions_state["user_id"]

    st.set_page_config(page_title="3_Créer_nouveau_sport", page_icon="📝")
    show_page()

    sports_selection = option_menu(
        "Quel type d'exercice",
        ["Musculation", "Sport", "Cross-Trainning"],
        default_index=0,
        orientation="horizontal",
    )
    insert_add_sport_form(sports_selection)


if __name__ == "__main__":
    main(sessions_state)
