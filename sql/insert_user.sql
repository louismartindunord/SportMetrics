-- Permet d'ajouter un nouveau utilisateur utilisé par utils/user_authentification.insert_user
INSERT INTO users (
    username,
    name,
    password
    )
VALUES (%s, %s, %s);
