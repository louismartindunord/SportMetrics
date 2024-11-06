from sqlalchemy import column
from utils.cookie_connection import create_connection
import streamlit as st
import datetime
import psycopg2
import pandas as pd
import numpy as np


@st.cache_data
def get_user_informations(user_id: int) -> pd.DataFrame:
    try:
        with create_connection() as connexion:
            with connexion.cursor() as cursor:
                with open("sql/get_all_users_informations.sql", "r") as f:
                    cursor.execute(f.read(), (user_id,))
                    result = cursor.fetchall()
                    connexion.commit()

                column = [
                    "id",
                    "username",
                    "email",
                    "poid",
                    "taille",
                    "objectif",
                    "modification_date",
                    "pourcentage_graisse",
                    "pourcentage_muscle",
                ]
                data = pd.DataFrame(result, columns=column)
                data = data.sort_values(by="modification_date", ascending=False)
                data = data.drop_duplicates(subset="id", keep="first")
                return data
    except (Exception, psycopg2.Error) as error:
        st.error(f"Erreur lors de la récupération des informations : {error}")
        return pd.DataFrame()


def separete_dataframe_to_dict(df_user_info: pd.DataFrame):
    df_connexio_info = df_user_info[["email", "username"]]
    df_connexio_info.columns = ["Votre mail", "Votre pseudo"]
    df_person_infos = df_user_info[
        ["poid", "objectif", "pourcentage_graisse", "pourcentage_muscle"]
    ]
    df_person_infos.columns = [
        "Votre poid",
        "Votre objectif",
        "Votre taux de masse grasse",
        "Votre taux de masse musculaire",
    ]
    user_id = df_user_info
    return df_connexio_info.to_dict(), df_person_infos.to_dict()


def keys_initialisation(key):
    if f"edit_status_{key}" not in st.session_state:
        st.session_state[f"edit_status_{key}"] = False

    if "edit_status_dict" not in st.session_state:
        st.session_state["edit_status_dict"] = {f"edit_status_{key}": False}


def switch_to_editable_form(key, edit_status_dict, modifable=True):
    if modifable == True:
        st.session_state[f"edit_status_{key}"] = True
        st.session_state["edit_status_dict"][f"edit_status_{key}"] = True

    elif modifable == False:
        st.session_state[f"edit_status_{key}"] = False
        st.session_state["edit_status_dict"][f"edit_status_{key}"] = False


def transform_data_to_push_in_db(infos_dict, infos_type, user_id):
    if infos_type == "connexion_info":
        new_columns = ["email", "username"]

    elif infos_type == "person_infos":
        new_columns = [
            "poid",
            "objectif",
            "pourcentage_graisse",
            "pourcentage_muscle",
        ]
    new_info_dict = {
        new_key: infos_dict[old_key]
        for new_key, old_key in zip(new_columns, infos_dict.keys())
    }
    new_info_dict["user_id"] = user_id

    print(f" après trznsformation des colonnes :{new_info_dict}")

    if infos_type == "person_infos":
        new_info_dict.update(
            {"user_id": user_id, "modification_date": datetime.datetime.today()}
        )
        print(f" après ajout de colonnes :{new_info_dict}")

    return new_info_dict


def send_to_db(connexion_infos, infos_type):
    if infos_type == "connexion_info":
        file = "sql/update_user_informations.sql"
    elif infos_type == "person_infos":
        file = "sql/create_new_row_in_users_informations.sql"

    with create_connection() as connexion:
        with connexion.cursor() as cursor:
            with open(file, "r") as f:
                query = f.read()
                cursor.execute(query, connexion_infos)
                connexion.commit()
