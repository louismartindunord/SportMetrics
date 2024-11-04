from curses import keyname
from typing import Any, Hashable
from altair import Key
import streamlit as st
from utils.cookie_connection import sessions_state
from utils.user_informations import (
    get_user_informations,
    separete_dataframe_to_dict,
    switch_to_editable_form,
    keys_initialisation,
    transform_data_to_push_in_db,
    send_to_db,
)


import pandas as pd


def main(session_state):
    if "editable" not in st.session_state:
        st.session_state["editable"] = False

    if sessions_state == "None":
        st.write("Vous devez être connecté pour afficher vos informations")
        st.stop()

    user_infos = get_user_informations(sessions_state["user_id"])
    connexion_infos, person_infos = separete_dataframe_to_dict(user_infos)

    connexion_infos_tab = st.tabs(tabs=["Vos informations de connexion"])

    edit_status_dict = {}

    for key, value in connexion_infos.items():
        keys_initialisation(key)
        col1, col2 = st.columns(2, gap="small")
        if st.session_state[f"edit_status_{key}"] == False:
            with col1:
                st.write(f"{key} : {value.get(0)}")
            with col2:
                st.button(
                    label="Modifier",
                    key=f"edit_{key}",
                    on_click=lambda k=key: switch_to_editable_form(
                        k, edit_status_dict, modifable=True
                    ),
                )
        elif st.session_state[f"edit_status_{key}"] == True:
            with col1:
                connexion_infos[key] = st.text_input(label=f"Modifier {key}")
            with col2:
                st.button(
                    label="Annuler",
                    key=f"edit_{key}",
                    on_click=lambda k=key: switch_to_editable_form(
                        k, edit_status_dict, modifable=False
                    ),
                )
    if True in st.session_state["edit_status_dict"].values():
        if st.button(label="Envoyer"):
            print(f"ancien dict: {connexion_infos}")
            new_info_dict = transform_data_to_push_in_db(
                connexion_infos,
                infos_type="connexion_info",
                user_id=st.session_state["user_id"],
            )

            print(f"nouveau dict : {new_info_dict}")
            send_to_db(new_info_dict, infos_type="connexion_info")

    connexion_infos_tab = st.tabs(tabs=["Vos informations Personnel"])


if __name__ == "__main__":
    sessions_state = sessions_state()
    main(session_state=sessions_state)
