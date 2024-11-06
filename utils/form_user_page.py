from typing import Any, Hashable, Sequence
import streamlit as st

from utils.cookie_connection import sessions_state
from utils.user_informations import *


def input_for_objectifs():
    objectifs_values = ["Perdre du poid", "Prendre du muscle", "Rester en forme"]
    objectifs_input = st.selectbox(
        label="Modifier votre objectif", options=objectifs_values, index=None
    )
    return objectifs_input


def create_user_form(info_dict, infos_type: str, tab_string: str):
    tabs: Sequence[DeltaGenerator] = st.tabs(tabs=[tab_string])
    edit_status_dict = {}
    for key, value in info_dict.items():
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
                if key == "Votre objectif":
                    info_dict[key] = input_for_objectifs()
                else:
                    info_dict[key] = st.text_input(label=f"Modifier {key}")
            with col2:
                st.button(
                    label="Annuler",
                    key=f"edit_{key}",
                    on_click=lambda k=key: switch_to_editable_form(
                        k, edit_status_dict, modifable=False
                    ),
                )

    if True in st.session_state["edit_status_dict"].values():
        if st.button(label="Envoyer", key=f"{infos_type}_button"):
            new_info_dict = transform_data_to_push_in_db(
                info_dict,
                infos_type=infos_type,
                user_id=st.session_state["user_id"],
            )
            if infos_type == "person_infos":
                print(f" après passage dans la fonction :{new_info_dict}")

            send_to_db(new_info_dict, infos_type=infos_type)
