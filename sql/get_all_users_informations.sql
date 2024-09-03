SELECT
    user_id
    user_image,
    poid, 
    taille, 
    objectif,
    modification_date
FROM users_informations 
WHERE user_id = %s
ORDER BY modification_date DESC NULLS LAST;