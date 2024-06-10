import streamlit as st
from utils.session_state import session_state_initialisation
from streamlit_option_menu import option_menu
import datetime

from utils.pages import show_page


st.set_page_config(page_title="Visualisation", page_icon="📝")
import matplotlib.pyplot as plt

username, user_id = session_state_initialisation()
show_page()

if st.session_state["username"]:
    date_options = option_menu(
        menu_title="",
        options=["Semaine", "Mois", "Années"],
        default_index=0,
        orientation="horizontal",
    )
