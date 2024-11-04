--usefull to render user_information on user_inforamion page and data visualisation

SELECT
    u.id,
    u.username,
    u.email,
    ui.poid, 
    ui.taille, 
    ui.objectif,
    ui.modification_date,
    ui.pourcentage_graisse,
    ui.pourcentage_muscle

FROM users u
LEFT JOIN users_informations ui ON u.id = ui.user_id
WHERE u.id = %s
ORDER BY ui.modification_date DESC NULLS LAST;