from dotenv import load_dotenv
from streamlit_cookies_manager import EncryptedCookieManager
import os
import streamlit as st
from sqlalchemy import create_engine
import psycopg2


load_dotenv()


def sessions_state() -> dict:
    session_keys = ["authenticated", "username", "user_id", "user_right", "user_right"]

    for key in session_keys:
        try:
            st.session_state[key]
        except:
            st.session_state[key] = None
        finally:
            if st.session_state["authenticated"] is None:
                st.session_state["authenticated"] = False

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
