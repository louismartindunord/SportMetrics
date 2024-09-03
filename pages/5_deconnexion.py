import streamlit as st

from utils.user_authentification import user_deconnexion
from utils.pages import show_page

user_deconnexion()
show_page()
st.write("Vous avez été déconnecté avec succès. À très bientôt !")
st.page_link("main.py", label="Retourner à l'accueil", icon="🏠")