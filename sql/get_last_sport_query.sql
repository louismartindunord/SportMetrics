SELECT 
    date_seance,
    sport,
    exercice,
    duree,
    commentaire
FROM sport_rows
WHERE date_seance = (
    SELECT MAX(date_seance) FROM sport_rows
);
