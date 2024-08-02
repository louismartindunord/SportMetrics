from utils.data_extraction import create_connection
import streamlit as st
import argon2


from utils.user_authentification import (
    Authentificator,
    login_success,
    user_creation_form,
    login_form,
    verify_user,
    guest_connexion,
)

from utils.cookie_management import sessions_state

st.session_state = sessions_state()


user_creation, user_login, guest = st.tabs(
    [
        "Créer un compte utilisateur",
        "Se connecter",
        "Se connecter en tant que visiteur",
    ]
)

with user_creation:
    user_creation_form(form_key="user_creation")

with user_login:
    login_form(form_key="login")

with guest:
    guest_connexion()
