from st_pages import show_pages, hide_pages, Page, add_page_title
from utils.users_authentification import is_connected


def show_page():
    add_page_title()
    all_pages = [
        Page("ajout_exercices.py", "Accueil", "🏠"),
        Page("pages/2_Visualisation.py", "Vos métriques"),
        Page("pages/3_Créer_nouveau_sport.py", "Ajouter un sport"),
        Page("pages/4_deconnexion.py", "Déconnexion"),
        Page("pages/3_login.py", "Connexion"),
    ]

    if is_connected():
        show_pages(
            [
                Page("ajout_exercices.py", "Accueil", "🏠"),
                Page("pages/2_Visualisation.py", "Vos métriques"),
                Page("pages/3_Créer_nouveau_sport.py", "Ajouter un sport"),
                Page("pages/4_deconnexion.py", "Déconnexion"),
            ]
        )
        hide_pages(["pages/3_login.py"])
    else:
        show_pages(
            [
                Page("ajout_exercices.py", "Accueil", "🏠"),
                Page("pages/3_login.py", "Connexion"),
            ]
        )
        hide_pages(
            [
                "pages/2_Visualisation.py",
                "pages/3_Créer_nouveau_sport.py",
                "pages/4_deconnexion.py",
            ]
        )
