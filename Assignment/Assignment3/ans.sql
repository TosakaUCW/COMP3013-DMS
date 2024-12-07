-- a) Find the ID of routes which are not served by any vehicle. You must use subqueries.
SELECT rID
FROM route
WHERE rID NOT IN (
        SELECT rID
        FROM serve
    );

-- b) Find the name of drivers who have served the route 69 (rID). You must use subqueries.
SELECT name
FROM driver
WHERE dID IN (
        SELECT dID
        FROM driver
        WHERE plateNum IN (
                SELECT plateNum
                FROM serve
                WHERE rID = 69
            )
    );

-- c) Find the name of drivers who have driven all vehicles.
SELECT name
FROM driver
WHERE dID IN (
        SELECT dID
        FROM drive
        GROUP BY dID
        HAVING COUNT(DISTINCT plateNum) = (
                SELECT COUNT(*)
                FROM vehicle
            )
    );

-- d) Find the plate number of vehicles which have served all route operated by “Xinhe” (company name).
SELECT plateNum
FROM vehicle
WHERE plateNum IN (
        SELECT plateNum
        FROM route
        WHERE rID IN (
                SELECT rID
                FROM route
                WHERE cID = (
                        SELECT cID
                        FROM company
                        WHERE cname = "Xinhe"
                    )
            )
        GROUP BY plateNum
        HAVING COUNT(DISTINCT rID) = (
                SELECT COUNT(*)
                FROM route
                WHERE cID = (
                        SELECT cID
                        FROM company
                        WHERE cname = 'Xinhe'
                    )
            )
    );

-- e) Implement constraints to guarantee the gender of a driver is either “Male” or “Female” and the age is from 20 to 60.
ALTER TABLE driver
ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female')),
    ADD CONSTRAINT chk_age CHECK (
        age BETWEEN 20 AND 60
    );