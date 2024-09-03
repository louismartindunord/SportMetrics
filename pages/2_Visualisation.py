import streamlit as st
from utils.cookie_connection import sessions_state
from streamlit_option_menu import option_menu
import datetime

from utils.pages import show_page
import matplotlib.pyplot as plt
from utils.data_visualisation import import_all_data, filter_by_time_period, plot_sport_frequence
st.set_page_config(
    page_title="Votre Dashboard",
    layout="wide",
    )
show_page()

    
def main():
    st.session_state = sessions_state()
    if  st.session_state["user_id"] == None :
        st.write("Vous devez être connecté pour afficher vos données")
        st.stop()
        
    
    all_datas = import_all_data(st.session_state["user_id"])
    #Filtrage des données en fonction de la période
    date_options = option_menu(
        menu_title="quelle période",
        options=["Semaine", "Mois", "Année"],
        default_index=0,
        orientation="horizontal",
    ) 
    df = filter_by_time_period(all_datas,date_options)
    
    col1,col2,col3 = st.columns(3)
    with col1:
        plot_sport_frequence(df,date_options)
    

  
            
if __name__ =="__main__":
    main()
