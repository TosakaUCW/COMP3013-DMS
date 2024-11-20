ALTER TABLE staff
ADD staff_rating INT
AFTER PASSWORD;

UPDATE staff
SET staff_rating = 10
WHERE staff_id = 1;