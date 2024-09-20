import streamlit as st
from utils.cookie_connection import sessions_state
from utils.user_informations import get_user_informations, render_user_informations
from styles.style import profil_image


def main(session_state):
    st.markdown(profil_image, unsafe_allow_html=True)

    if sessions_state == "None":
        st.write("Vous devez être connecté pour afficher vos informations")
        st.stop()

    user_info = get_user_informations(sessions_state["user_id"])
    render_user_informations(user_info, session_state["user_informations_editable"])


if __name__ == "__main__":
    sessions_state = sessions_state()
    main(session_state=sessions_state)
