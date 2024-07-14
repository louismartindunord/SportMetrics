import streamlit as st
import argon2
import psycopg2
import os
from dotenv import load_dotenv
from utils.data_extraction import create_connection


class Authentificator(argon2.PasswordHasher):

    def generate_pwd_hash(self, password):
        return password if password.startswith("$argon2id$") else self.hash(password)

    def verify_password(self, hashed_password, plain_password):
        try:
            if self.verify(hashed_password, plain_password):
                return True
        except argon2.exceptions.VerificationError:
            return False


def login_success(message: str, username: str) -> None:
    st.success(message)
    st.session_state["authenticated"] = True
    st.session_state["username"] = username


def login_form(
    *,
    title: str = "Authentication",
    user_tablename: str = "users",
    username_col: str = "username",
    password_col: str = "password",
    create_title: str = "Création de compte",
    login_title: str = "Connexion",
    allow_guest: bool = True,
    allow_create: bool = True,
    guest_title: str = "Visiteur  ",
    create_username_label: str = "Create a unique username",
    create_username_placeholder: str = None,
    create_username_help: str = None,
    create_password_label: str = "Create a password",
    create_password_placeholder: str = None,
    create_password_help: str = "Password cannot be recovered if lost",
    create_submit_label: str = "Create account",
    create_success_message: str = "Account created and logged-in :tada:",
    login_username_label: str = "Enter your unique username",
    login_username_placeholder: str = None,
    login_username_help: str = None,
    login_password_label: str = "Enter your password",
    login_password_placeholder: str = None,
    login_password_help: str = None,
    login_submit_label: str = "Login",
    login_success_message: str = "Login succeeded :tada:",
    login_error_message: str = "Wrong username/password :x: ",
    guest_submit_label: str = "Guest login",
):
    connexion = create_connection()
    auth = Authentificator()

    if "authenticated" not in st.session_state:
        st.session_state["authenticated"] = False
    if "username" not in st.session_state:
        st.session_state["username"] = None

    with st.expander(title, expanded=not st.session_state["authenticated"]):
        if allow_guest:
            if allow_create:
                create_tab, login_tab, guest_tab = st.tabs(
                    [
                        create_title,
                        login_title,
                        guest_title,
                    ]
                )
            else:
                login_tab, guest_tab = st.tabs([login_title, guest_title])
        elif allow_create:
            create_tab, login_tab = st.tabs(
                [
                    create_title,
                    login_title,
                ]
            )
        else:
            login_tab = st.container()

        if allow_create:
            with create_tab:
                with st.form(key="create"):
                    username = st.text_input(
                        label=create_username_label,
                        placeholder=create_username_placeholder,
                        help=create_username_help,
                        disabled=st.session_state["authenticated"],
                    )

                    password = st.text_input(
                        label=create_password_label,
                        placeholder=create_password_placeholder,
                        help=create_password_help,
                        type="password",
                        disabled=st.session_state["authenticated"],
                    )
                    hashed_password = auth.generate_pwd_hash(password)
                    if st.form_submit_button(
                        label=create_submit_label,
                        type="primary",
                        disabled=st.session_state["authenticated"],
                    ):
                        try:
                            cursor = connexion.cursor()
                            cursor.execute(
                                f"INSERT INTO {user_tablename} ({username_col}, {password_col}) VALUES (%s, %s)",
                                (username, hashed_password),
                            )
                            connexion.commit()
                            cursor.close()
                        except Exception as e:
                            st.error(str(e))
                            st.session_state["authenticated"] = False
                        else:
                            login_success(create_success_message, username)

        # Login to existing account
        with login_tab:
            with st.form(key="login"):
                username = st.text_input(
                    label=login_username_label,
                    placeholder=login_username_placeholder,
                    help=login_username_help,
                    disabled=st.session_state["authenticated"],
                )

                password = st.text_input(
                    label=login_password_label,
                    placeholder=login_password_placeholder,
                    help=login_password_help,
                    type="password",
                    disabled=st.session_state["authenticated"],
                )

                if st.form_submit_button(
                    label=login_submit_label,
                    disabled=st.session_state["authenticated"],
                    type="primary",
                ):
                    cursor = connexion.cursor()
                    cursor.execute(
                        f"SELECT {username_col}, {password_col} FROM {user_tablename} WHERE {username_col} = %s",
                        (username,),
                    )
                    result = cursor.fetchone()
                    cursor.close()

                    if result:
                        db_username, db_password = result

                        if auth.verify_password(db_password, password):
                            login_success(login_success_message, username)
                        else:
                            st.error(login_error_message)
                            st.session_state["authenticated"] = False
                    else:
                        st.error(login_error_message)
                        st.session_state["authenticated"] = False

        if allow_guest:
            with guest_tab:
                if st.button(
                    label=guest_submit_label,
                    type="primary",
                    disabled=st.session_state["authenticated"],
                ):
                    st.session_state["authenticated"] = True


if __name__ == "__main__":
    login_form()
