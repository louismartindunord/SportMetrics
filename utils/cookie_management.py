from dotenv import load_dotenv
from streamlit_cookies_manager import EncryptedCookieManager
import os
import streamlit as st

load_dotenv()


def sessions_state() -> dict:
    session_keys = ["authenticated", "username", "user_id", "user_right"]

    for key in session_keys:
        if key not in st.session_state:
            st.session_state[key] = None

    if st.session_state["authenticated"] is None:
        st.session_state["authenticated"] = False

    return {key: st.session_state[key] for key in session_keys}
