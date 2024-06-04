SELECT 
    date_seance,
    Sport,
    Exercice,
    Durée,
    Commentaire
FROM sport_rows
WHERE date_seance = (
    SELECT MAX(date_seance) FROM sport_rows
);
