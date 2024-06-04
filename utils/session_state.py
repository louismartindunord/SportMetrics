import streamlit as st


def session_state_initialisation():
    if "username" not in st.session_state:
        st.session_state["username"] = None
    if "user_id" not in st.session_state:
        st.session_state["user_id"] = None
    if "authenticated" not in st.session_state:
        st.session_state["authenticated"] = False
    return st.session_state["username"], st.session_state["user_id"]
