import streamlit as st
import streamlit_authenticator as stauth
from utils.users_authentification import connexion_form, register_user, get_user_id
from utils.session_state import session_state_initialisation

st.set_page_config(page_title="Login", page_icon="📝")

username, user_id = session_state_initialisation()

authentication_status, username = connexion_form()
if authentication_status:
    st.success(f"Vous êtes connecté en tant que {username}")
    st.session_state["username"] = username
    st.session_state["user_id"] = get_user_id(username)
    st.session_state["authenticated"] = True
    print(f"User {username} logged in with ID {st.session_state['user_id']}")
elif authentication_status is False:
    st.error("Le mot de passe ou le pseudo n'est pas reconnu")
elif authentication_status is None:
    st.warning("Veuillez entrer vos identifiants")
st.header("Inscription")
name = st.text_input("Prénom")
username = st.text_input("Pseudo")
password = st.text_input("Mot de passe", type="password")
if st.button("Valider"):
    if name and username and password:
        result = register_user(name, username, password)
        if result:
            st.success("L'utilisateur a bien été créé")
            st.session_state["username"] = username
            st.session_state["authenticated"] = True
        elif result == "integrity_error":
            st.error("Le pseudo est déjà utilisé")
        else:
            st.error("Il y a eu une erreur lors de la création du compte")
    else:
        st.warning("Veuillez remplir tous les champs")
