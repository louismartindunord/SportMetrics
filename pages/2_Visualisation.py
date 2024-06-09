import streamlit as st
from utils.session_state import session_state_initialisation
import utils.data_visualisation
from streamlit_option_menu import option_menu
import datetime


st.set_page_config(page_title="Visualisation", page_icon="📝")
import matplotlib.pyplot as plt

username, user_id = session_state_initialisation()

if st.session_state["username"]:
    date_options = option_menu(menu_title="", options=["Semaine", "Mois", "Années"])
