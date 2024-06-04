SELECT 
    DISTINCT(musculation_exercice_name)
FROM musculation_exercices
WHERE muscle_area = %s;
