from st_pages import show_pages, hide_pages, Page, add_page_title
import streamlit as st

from utils.cookie_connection import sessions_state


def show_page():
    session_state = sessions_state()
    add_page_title()

    if session_state["username"] is None:
        show_pages(
            [
                Page("main.py", "Accueil", "🏠"),
                Page("pages/2_Visualisation.py", "Vos métriques", "🏅"),
                Page("pages/3_Creer_nouveau_sport.py", "Ajouter un sport", "➕"),
                Page("pages/4_connexion.py", "Connexion", "🔐"),
            ]
        )
    else:
        show_pages(
            [
                Page("main.py", "Accueil", "🏠"),
                Page("pages/2_Visualisation.py", "Vos métriques", "🏅"),
                Page("pages/3_Creer_nouveau_sport.py", "Ajouter un sport", "➕"),
                Page("pages/6_Users_profile.py", "Votre compte", "👤"),
                Page("pages/5_deconnexion.py", "Déconnexion", "🚪"),
            ]
        )
