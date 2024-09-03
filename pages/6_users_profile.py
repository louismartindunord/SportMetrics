import streamlit as st
from utils.cookie_connection import sessions_state
from utils.user_informations import get_user_informations, user_informations_form


def main(session_state):
    if sessions_state =="None":
        st.write("Vous devez être connecté pour afficher vos informations")
        st.stop()
    user_informations = get_user_informations(sessions_state["user_id"])
    print(user_informations)
    #user_informations_form(user_informations)
    

if __name__ == "__main__":
    sessions_state  = sessions_state()
    main(session_state=sessions_state)