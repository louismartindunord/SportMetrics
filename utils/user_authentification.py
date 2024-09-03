from utils.data_extraction import create_connection
import streamlit as st
import argon2

from utils.cookie_connection import sessions_state


class Authentificator(argon2.PasswordHasher):
    def generate_pwd_hash(self, password):
        return password if password.startswith("$argon2id$") else self.hash(password)

    def verify_password(self, hashed_password, plain_password):
        try:
            return self.verify(hashed_password, plain_password)
        except argon2.exceptions.VerificationError:
            return False


def hash_password(password):
    auth = Authentificator()
    return auth.generate_pwd_hash(password)


def user_deconnexion():
    session_keys = ["authenticated", "username", "user_id", "user_right"]
    for key in session_keys:
        st.session_state[key] = None

@st.cache_data
def get_user_id(username):
    session_data = sessions_state()
    if st.session_state["user_id"] == None:
        try:
            connection = create_connection()
            cursor = connection.cursor()
            sql = "SELECT id FROM users WHERE username = %s"
            cursor.execute(sql, (username,))
            user_id = cursor.fetchone()
            user_id = user_id[0]  # type: ignore
            st.session_state["user_id"] = user_id
            return user_id
        except Exception as e:
            print(f"Erreur lors de la récupération de l'ID utilisateur : {e}")
            return None
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()

@st.cache_data
def get_user_right(username):
    session_data = sessions_state()
    if st.session_state["user_right"] == None:
        try:
            connection = create_connection()
            cursor = connection.cursor()
            sql = "SELECT user_right FROM users WHERE username = %s"
            cursor.execute(sql, (username,))
            user_right = cursor.fetchone()
            user_right = user_right[0]  # type: ignore
            st.session_state["user_right"] = user_right
            return user_right
        except Exception as e:
            print(f"Erreur lors de la récupération de l'ID utilisateur : {e}")
            return None
        finally:
            if cursor:
                cursor.close()
            if connection:
                connection.close()


def login_success(message: str, username: str) -> None:
    st.session_state["user_right"] = get_user_right(username)
    st.session_state["authenticated"] = True
    st.session_state["username"] = username
    st.session_state["user_id"] = get_user_id(username)
    st.success(message)
    


def user_creation_form(form_key):
    auth = Authentificator()
    with st.form(key=form_key):
        username = st.text_input(
            label="Pseudo", disabled=st.session_state["authenticated"]
        )
        password = st.text_input(
            label="Mot de passe",
            type="password",
            disabled=st.session_state["authenticated"],
        )
        email = st.text_input(label="Email")
        if st.form_submit_button(
            label="Créer", type="primary", disabled=st.session_state["authenticated"]
        ):
            hashed_password = auth.generate_pwd_hash(password)
            created_user = create_user_in_postgres_db(username, hashed_password, email)
            #if created_user:
                #redirect_user_to_user_informations_page()

def create_user_in_postgres_db(username: str, hashed_password: str, email: str):
    try:
        connexion = create_connection()
        cursor = connexion.cursor()
        with open("sql/create_user.sql", "r") as f:
            cursor.execute(f.read(), (username, hashed_password, email))
            connexion.commit()
            login_success("Le compte a bien été créer", username)
            return True

    except Exception as e:
        st.error(str(e))
        st.session_state["authenticated"] = False
    finally:
        if cursor:
            cursor.close()
        if connexion:
            connexion.close()


def login_form(form_key: str):
    with st.form(key=form_key):
        username = st.text_input(
            label="Se connecter", disabled=st.session_state["authenticated"]
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
            verify_user(username, password)
    st.write()


def verify_user(username: str, password: str):
    try:
        auth = Authentificator()
        connexion = create_connection()
        cursor = connexion.cursor()
        with open("sql/verify_user.sql", "r") as f:
            query = f.read()
            cursor.execute(query, (username,))
            result = cursor.fetchone()

        if result:
            db_username, db_password = result
            if auth.verify_password(db_password, password):
                login_success("Connexion réussie", username)
            else:
                st.error("Username ou mot de passe non reconnus")
                st.session_state["authenticated"] = False
        else:
            st.error("Username ou mot de passe non reconnus")
            st.session_state["authenticated"] = False
    except Exception as e:
        st.error("Erreur lors de la vérification de l'utilisateur : " + str(e))
        st.session_state["authenticated"] = False
    finally:
        if cursor:
            cursor.close()
        if connexion:
            connexion.close()


def guest_connexion():
    if st.button(
        label="Connexion", type="primary", disabled=st.session_state["authenticated"]
    ):
        st.session_state["authenticated"] = True
