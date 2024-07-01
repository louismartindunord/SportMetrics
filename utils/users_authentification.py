from pathlib import Path
import pickle
import streamlit_authenticator as stauth
import os
import psycopg2
import bcrypt
from dotenv import load_dotenv
import streamlit as st
from sqlalchemy.exc import IntegrityError
from utils.data_extraction import create_connection

from utils.session_state import session_state_initialisation


def is_connected():
    try:
        username = st.session_state["username"]
        return username
    except KeyError:
        return False


def hash_password(password):
    return bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")


def register_user(name, username, password):
    connection = create_connection()
    try:
        cursor = connection.cursor()
        file = "sql/insert_user.sql"
        with open(file, "r") as f:
            hashed_password = hash_password(password)
            cursor.execute(f.read(), (username, name, hashed_password))
            connection.commit()
            return True
    except IntegrityError as e:
        return False
    except Exception as e:
        print(f"Error: {e}")
        return False
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


def get_users():
    try:
        file = "sql/get_all_user.sql"
        with open(file, "r") as f:
            connection = create_connection()
            cursor = connection.cursor()
            cursor.execute(f.read())
            users = cursor.fetchall()
            return users
    except Exception as e:
        print(f"Error: {e}")
        return []
    finally:
        if connection:
            connection.close()


def update_user(username, column, updates):
    try:
        file = "sql/update_user.sql"
        with open(file, "r") as f:
            connection = create_connection()
            cursor = connection.cursor()
            query = f.read().replace("%s", column + " = %s WHERE username = %s")
            cursor.execute(query, (updates, username))
            connection.commit()
            return True
    except Exception as e:
        print(f"Error: {e}")
        return False
    finally:
        if connection:
            connection.close()


def delete_user(username):
    try:
        connection = create_connection()
        file = "sql/delete_user.sql"
        with open(file, "r") as f:

            cursor = connection.cursor()
            cursor.execute(f.read(), (username,))
            connection.commit()
            return True
    except Exception as e:
        print(f"Error: {e}")
        return False
    finally:
        if connection:
            connection.close()


def load_credentials():
    users = get_users()
    credentials = {"usernames": {}}

    for user in users:
        username = str(user[1])
        password = str(user[2])
        credentials["usernames"][username] = {"name": username, "password": password}

    return credentials


def create_authenticator():
    credentials = load_credentials()
    authenticator = stauth.Authenticate(
        credentials=credentials,
        cookie_name="user_cookie",
        cookie_key="abcdef",
        cookie_expiry_days=30,
    )
    return authenticator


def connexion_form():
    authenticator = create_authenticator()
    name, authentication_status, username = authenticator.login(
        "main", "Login", fields={"username": "Username", "password": "Password"}
    )
    if authentication_status:
        st.session_state["username"] = username
        authenticator.logout("Logout", "main")
        st.session_state["authenticated"] = True
    elif authentication_status is False:
        st.session_state["username"] = None
        st.session_state["authenticated"] = False

    return authentication_status, name


def get_user_id(user_name):
    if user_name is not None:
        try:
            connexion = create_connection()
            cursor = connexion.cursor()
            with open("sql/get_user_id_from_username.sql", "r") as f:
                cursor.execute(f.read(), (user_name,))
                user_id_array = cursor.fetchone()
                if user_id_array:
                    user_id = user_id_array[0]
                    return user_id
                else:
                    print("No user_id found for the given username")
                    return None

        except (Exception, psycopg2.Error) as error:
            print(f"Error while fetching data: {error}")
            return None

        finally:
            if cursor:
                cursor.close()
            if connexion:
                connexion.close()
