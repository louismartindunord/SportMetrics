SELECT 
    date_seance,
    exercice,
    poid,
    nombre_repetition,
    commentaires
FROM musculation_rows
WHERE date_seance = (
    SELECT MAX(date_seance) FROM musculation_rows
);
