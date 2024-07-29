import smtplib, ssl
import streamlit as st
from dotenv import load_dotenv
import os
import argon2

from user_authentification import create_connection
import psycopg2

#
# def get_informations_of_application_mail():
#    load_dotenv()
#    APPLICATION_MAIL = os.getenv("APPLICATION_MAIL")
#    APPLICATION_MAIL_PASSWORD = os.getenv("APPLICATION_MAIL_PASSWORD")
#    return APPLICATION_MAIL, APPLICATION_MAIL_PASSWORD
#
#
# def send_mail_to_change_password(email_receiver: str):
#    APPLICATION_MAIL, APPLICATION_MAIL_PASSWORD = get_informations_of_application_mail()
#    print("mail", APPLICATION_MAIL)
#    print("password", APPLICATION_MAIL_PASSWORD)
#    smtp_address = "smtp.gmail.com"
#    smtp_port = 465
#    context = ssl.create_default_context()
#
#    # URL de votre application Streamlit
#    app_url = "http://localhost:8501"  # Changez cette URL selon vos besoins
#    reset_link = f"{app_url}/?email={email_receiver}"
#
#    email_content = f"""\
# Subject: Réinitialisation de votre mot de passe
#
# Vous avez demandé la modification de votre mot de passe. Cliquez sur le lien pour le modifier:
# {reset_link}
# """
#
#    with smtplib.SMTP_SSL(smtp_address, smtp_port, context=context) as server:
#        server.login(APPLICATION_MAIL, APPLICATION_MAIL_PASSWORD)
#        server.sendmail(APPLICATION_MAIL, email_receiver, email_content)
#
#
## Exemple d'utilisation
# send_mail_to_change_password(email_receiver="utilisateur@example.com")
#
#
# def verify_email(email: str):
#    try:
#        connection = create_connection()
#        cursor = connection.cursor()
#        with open("./sql/verify_user_email.sql", "r") as f:
#            cursor.execute(f, (email,))
#            result = cursor.fetchone()
#            if result:
#                return True
#            else:
#                return False
#    except Exception as e:
#        print(f"erreur lors de la verification du mail : {e}")
#        return None
#    finally:
#        if cursor:
#            cursor.close()
#        if connection:
#            connection.close()
#
#
# def change_password():
#    with st.form("change_password_form"):
#        email = st.text_input("quelle est votre adresse mail ? ")
#        valider = st.form_submit_button("valider")
#        if valider:
#            if verify_email(email) == True:
#                send_mail_to_change_password(email)
#                st.success("Un mail vous a été envoyé")
#            else:
#                st.error("Votre adresse mail n'est pas reconnu")
#
#
# def handle_password_reset():
#    query_params = st.query_params()
#    email = query_params.get("email", [None])[0]
#
#    if email:
#        reset_password(email)
#    else:
#        st.error("Aucune adresse e-mail fournie.")
#
#
# def reset_password(email):
#    st.title("Réinitialisation du mot de passe")
#    new_password = st.text_input("Nouveau mot de passe", type="password")
#    confirm_password = st.text_input("Confirmer le mot de passe", type="password")
#
#    if st.button("Réinitialiser le mot de passe"):
#        if new_password != confirm_password:
#            st.error("Les mots de passe ne correspondent pas.")
#        else:
#            auth = argon2.PasswordHasher()
#            hashed_password = auth.hash(new_password)
#            try:
#                connection = create_connection()
#                cursor = connection.cursor()
#                cursor.execute(
#                    "UPDATE users SET password = %s WHERE email = %s",
#                    (hashed_password, email),
#                )
#                connection.commit()
#                st.success("Votre mot de passe a été réinitialisé avec succès.")
#            except Exception as e:
#                st.error(f"Erreur lors de la réinitialisation du mot de passe : {e}")
#            finally:
#                if cursor:
#                    cursor.close()
#                if connection:
#                    connection.close()
#


def change_password_via_back(email: str, password: str):
    auth = argon2.PasswordHasher()
    hashed_password = auth.hash(password)
    try:
        connection = create_connection()
        cursor = connection.cursor()
        cursor.execute(
            "UPDATE users SET password = %s WHERE email = %s",
            (hashed_password, email),
        )
        connection.commit()
        st.success("Votre mot de passe a été réinitialisé avec succès.")
    except Exception as e:
        st.error(f"Erreur lors de la réinitialisation du mot de passe : {e}")
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()


if __name__ == "__main__":
    change_password_via_back(
        email="l.martindunord@gmail.com", password="bobmarley1234;"
    )
