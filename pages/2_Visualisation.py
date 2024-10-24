import streamlit as st
from utils.cookie_connection import sessions_state
from streamlit_option_menu import option_menu
import datetime

from utils.pages import show_page
import matplotlib.pyplot as plt

from utils.data_visualisation import (
    import_all_data,
    filter_by_time_period,
    plot_sport_frequence,
    transform_date_column,
)

st.set_page_config(
    page_title="Votre Dashboard",
    layout="wide",
)
show_page()


def main():
    st.session_state = sessions_state()
    if st.session_state["user_id"] == None:
        st.write("Vous devez être connecté pour afficher vos données")
        st.stop()

    all_datas = import_all_data(st.session_state["user_id"])
    if all_datas is None:
        st.write("Vous n'avez pour le moment pas de données")

    else:
        date_options = option_menu(
            menu_title="quelle période",
            options=["Semaine", "Mois", "Année"],
            default_index=0,
            orientation="horizontal",
        )

        all_datas["date"] = transform_date_column(all_datas)
        all_datas = filter_by_time_period(all_datas, date_options)
        st.dataframe(all_datas)

        col1, col2, col3 = st.columns(3)
        with col1:
            plot_sport_frequence(all_datas, date_options)


if __name__ == "__main__":
    main()
