INSERT INTO muscle_area (name)
VALUES (%s)
ON CONFLICT (name) DO NOTHING; 