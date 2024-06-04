
ALTER TABLE musculation_rows 
ADD COLUMN user_id INT 
REFERENCES users(id);


UPDATE musculation_rows
SET user_id = 1;