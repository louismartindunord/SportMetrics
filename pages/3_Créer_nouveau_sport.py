import streamlit as st
from utils.form import insert_add_sport_form


st.set_page_config(page_title="3_Créer_nouveau_sport", page_icon="📝")

if "username" not in st.session_state:
    st.session_state["username"] = None


def handle_select_change():
    selected_value = st.session_state.musculation_sport_selectbox
    return selected_value


musculation_sport = st.selectbox(
    "Est ce un exercice de musculation ?",
    options=["oui", "non"],
    key="musculation_sport_selectbox",
    on_change=handle_select_change,
)
default_value = handle_select_change()
insert_add_sport_form(default_value)
