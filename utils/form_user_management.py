from utils.data_extraction import create_connection
import streamlit as st
import argon2


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


def login_form():
    connexion = create_connection()
    auth = Authentificator()

    if "authenticated" not in st.session_state:
        st.session_state["authenticated"] = False
    if "username" not in st.session_state:
        st.session_state["username"] = None

    user_creation, user_login, guest = st.tabs(
        [
            "Créer un compte utilisateur",
            "Se connecter",
            "Se connecter en tant que visiteur",
        ]
    )

    with user_creation:
        with st.form(key="user_creation"):
            username = st.text_input(
                label="Pseudo", disabled=st.session_state["authenticated"]
            )
            password = st.text_input(
                label="Mot de passe",
                type="password",
                disabled=st.session_state["authenticated"],
            )
            hashed_password = auth.generate_pwd_hash(password)
            if st.form_submit_button(
                label="Créer",
                type="primary",
                disabled=st.session_state["authenticated"],
            ):
                try:
                    with open("create_user.sql", "r") as f:
                        cursor = connexion.cursor()
                        cursor.execute(f.read(), (username, hashed_password))
                        connexion.commit()
                        login_success("Le compte est créer", username)

                except Exception as e:
                    st.error(str(e))
                    st.session_state["authenticated"] = False

        with user_login:
            with st.form(key="login"):
                username = st.text_input(
                    label="Se connecter",
                    disabled=st.session_state["authenticated"],
                )

                password = st.text_input(
                    label="Mot de passe",
                    type="password",
                    disabled=st.session_state["authenticated"],
                )

                if st.form_submit_button(
                    label="Se connecter",
                    disabled=st.session_state["authenticated"],
                    type="primary",
                ):
                    try:
                        cursor = connexion.cursor()
                        sql = "sql/verify_user.sql"
                        with open(sql, "r") as f:
                            cursor.execute(f, (username,))
                            result = cursor.fetchone()
                            cursor.close()

                            if result:
                                db_username, db_password = result
                                if auth.verify_password(db_password, password):
                                    login_success(login_success_message, username)

                    except:
                        st.error(login_error_message)
                        st.session_state["authenticated"] = False

            with guest:
                if st.button(
                    label="Connexion",
                    type="primary",
                    disabled=st.session_state["authenticated"],
                ):
                    st.session_state["authenticated"] = True
