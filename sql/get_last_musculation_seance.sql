SELECT 
    date_seance,
    musclearea,
    exercice,
    poid,
    nombre_repetition,
    comments
FROM musculation_rows
WHERE date_seance = (
    SELECT MAX(date_seance) FROM musculation_rows
);
