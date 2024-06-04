import streamlit as st
from utils.session_state import session_state_initialisation
from utils.users_authentification import create_authenticator


username, user_id = session_state_initialisation()
if username or user_id:
    authenticator = create_authenticator()
    authenticator.logout()

    for key in list(st.session_state.keys()):
        del st.session_state[key]
    st.set_query_params()
    st.rerun()
else:
    st.success("Vous êtes déconnecté.")