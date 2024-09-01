import streamlit as st
from utils.cookie_connection import sessions_state
from streamlit_option_menu import option_menu
import datetime

from utils.pages import show_page
import matplotlib.pyplot as plt
from utils.data_visualisation import import_all_data, filter_by_time_period
st.set_page_config(
    page_title="Votre Dashboard",
    layout="wide",
    )
show_page()

    
def main():
<<<<<<< HEAD
    st.title("Votre Dashboard")
    st.session_state = sessions_state()
    print(st.session_state["user_id"])
    if  st.session_state["user_id"] == None :
        st.write("Vous devez être connecté pour afficher vos données")
        
    else:
        all_datas = import_all_data(st.session_state["user_id"])
        #Filtrage des données en fonction de la période
        date_options = option_menu(
            menu_title="quelle période",
            options=["Semaine", "Mois", "Année"],
            default_index=0,
            orientation="horizontal",
        ) 
        df = filter_by_time_period(all_datas,date_options)
    

=======

    
    st.title("Votre Dashboard")
    st.session_state = sessions_state()
    print(st.session_state["user_id"])
    if  st.session_state["user_id"] == None :
        st.write("Vous devez être connecté pour afficher vos données")
        
    else:
        all_datas = import_all_data(st.session_state["user_id"])
        #Filtrage des données en fonction de la période
        date_options = option_menu(
            menu_title="quelle période",
            options=["Semaine", "Mois", "Année"],
            default_index=0,
            orientation="horizontal",
        ) 
        df = filter_by_time_period(all_datas,date_options)
    

>>>>>>> origin/main
  
            
if __name__ =="__main__":
    main()
