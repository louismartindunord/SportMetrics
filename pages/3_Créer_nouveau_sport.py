import streamlit as st
from utils.form_add_sport import insert_add_sport_form
from utils.pages import show_page
from streamlit_option_menu import option_menu
from utils.cookie_management import sessions_state


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
    if sessions_state["user_right"] == "admin" and sports_selection == "Musculation":
        insert_add_sport_form(sports_selection)

    elif (
        (sports_selection == "Sport" and sessions_state["user_id"] != None)
        or sports_selection == "Cross-Trainning"
        and sessions_state["user_id"] != None
    ):
        insert_add_sport_form(sports_selection)
    elif sports_selection == "Musculation" and sessions_state["user_right"] != "admin":
        st.error(
            "Seul les utilisateurs administrateurs peuvent ajouter un exercice de musculation"
        )
    else:
        st.error("Vous devez être connecté pour ajouter une sport.")


if __name__ == "__main__":
    main(sessions_state)
