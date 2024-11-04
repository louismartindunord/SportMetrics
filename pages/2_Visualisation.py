import streamlit as st
from utils.cookie_connection import sessions_state
from streamlit_option_menu import option_menu
import datetime

from utils.pages import show_page
import matplotlib.pyplot as plt

from utils.data_visualisation import (
    import_sport_info,
    filter_by_time_period,
    plot_sport_frequence,
    transform_date_column,
    get_day_of_the_week,
    import_user_infos,
    get_last_user_info,
    write_metrics,
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

    df_sport = import_sport_info(st.session_state["user_id"])
    df_user_infos = import_user_infos(st.session_state["user_id"])

    if df_sport is None and df_user_infos is None:
        st.write("Vous n'avez pas de données pour le moment")

    else:
        date_options = option_menu(
            menu_title="quelle période",
            options=["Semaine", "Mois", "Année"],
            default_index=0,
            orientation="horizontal",
        )
        df_sport["date"] = transform_date_column(df_sport)
        df_sport = filter_by_time_period(df_sport, date_options)
        if date_options == "Semaine":
            df_sport["weekday"] = get_day_of_the_week(df_sport["date"])

        with st.expander(label="sport data"):
            st.dataframe(df_sport)

        with st.expander(label="user data"):
            st.dataframe(df_user_infos)

        col1, col2, col3 = st.columns(3)
        with col1:
            write_metrics(
                user_infos=df_user_infos,
                metric="poid",
                delta_color="inverse",
                label="Votre poid",
            )


if __name__ == "__main__":
    main()
