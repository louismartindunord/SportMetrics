import streamlit as st
from utils.session_state import session_state_initialisation


st.set_page_config(page_title="Visualisation", page_icon="📝")

username, user_id = session_state_initialisation()
