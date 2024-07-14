from st_pages import show_pages, hide_pages, Page, add_page_title
import streamlit as st


def show_page():
    add_page_title()
    all_pages = [
        Page("main.py", "Accueil", "🏠"),
        Page("pages/2_Visualisation.py", "Vos métriques"),
        Page("pages/3_Créer_nouveau_sport.py", "Ajouter un sport"),
        Page("pages/4_connexion.py", "Connexion"),
    ]

    show_pages(
        [
            Page("main.py", "Accueil", "🏠"),
            Page("pages/2_Visualisation.py", "Vos métriques"),
            Page("pages/3_Créer_nouveau_sport.py", "Ajouter un sport"),
            Page("pages/4_connexion.py", "Connexion"),
        ]
    )
