import streamlit as st


from utils.user_authentification import user_deconnexion
from utils.pages import show_page

user_deconnexion()
show_page()
st.write("Vous êtes déconnecté.")
st.page_link("main.py", label="Revir à l'accueil")
