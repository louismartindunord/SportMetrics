from dotenv import load_dotenv
from streamlit_cookies_manager import EncryptedCookieManager
import os
import streamlit as st
from sqlalchemy import create_engine
import psycopg2


load_dotenv()


@st.cache_resource
def sessions_state() -> dict:
    session_keys = [
        "authenticated",
        "username",
        "user_id",
        "user_right",
        "user_right",
        "user_informations_editable",
        "image_change",
    ]
    for key in session_keys:
        if key not in st.session_state:
            st.session_state[key] = None

    if st.session_state["authenticated"] is None:
        st.session_state["authenticated"] = False
    if st.session_state["user_informations_editable"] is None:
        st.session_state["user_informations_editable"] = False

    return {key: st.session_state[key] for key in session_keys}


def create_connection():
    load_dotenv()
    DATABASE = os.getenv("DATABASE")
    HOST = os.getenv("HOST")
    USER = os.getenv("USER")
    PASSWORD = os.getenv("PASSWORD")
    PORT = os.getenv("PORT")
    connection = psycopg2.connect(
        host=HOST, database=DATABASE, user=USER, password=PASSWORD
    )
    return connection


@st.cache_resource
def create_pandas_connection_engine():
    load_dotenv()
    DATABASE = os.getenv("DATABASE")
    HOST = os.getenv("HOST")
    USER = os.getenv("USER")
    PASSWORD = os.getenv("PASSWORD")
    PORT = os.getenv("PORT")

    connection_string = f"postgresql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}"
    engine = create_engine(connection_string)

    return engine
