SELECT * FROM musculation_exercices
 WHERE date = (SELECT MAX(date) 
 FROM musculation_exercices);
