-- Usefull to get all the data for the data visualisation 

SELECT 
    sport_rows.date_seance,
    sport_rows.sport, 
    sport_rows.exercice, 
    sport_rows.duree,
    NULL AS seance, 
    NULL AS poid,
    NULL AS nombre_repetition
FROM 
    sport_rows
WHERE 
    sport_rows.user_id = %s

UNION ALL 

SELECT 
    musculation_rows.date_seance,
    musculation_rows.sport as sport, 
    musculation_rows.exercice, 
    NULL AS duree,
    musculation_rows.seance,
    musculation_rows.poid,
    musculation_rows.nombre_repetition
FROM 
    musculation_rows
WHERE 
    musculation_rows.user_id = %s;