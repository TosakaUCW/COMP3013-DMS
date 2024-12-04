USE uic_without_foreign_keys;

DELIMITER |

CREATE TRIGGER ensure_disjoint_roles
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM instructor WHERE instructor.id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'A person cannot be both a student and an instructor.';
    END IF;
END |

CREATE TRIGGER ensure_disjoint_roles_instructor
BEFORE INSERT ON instructor
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM student WHERE student.id = NEW.id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'A person cannot be both a student and an instructor.';
    END IF;
END |

CREATE TRIGGER check_borrow_references
BEFORE INSERT ON borrow
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM student WHERE student.id = NEW.id
    ) AND NOT EXISTS (
        SELECT 1 FROM instructor WHERE instructor.id = NEW.id
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Person in borrow must exist in student or instructor.';
    END IF;
END |

CREATE TRIGGER check_contact_references
BEFORE INSERT ON contact
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM student WHERE student.id = NEW.id
    ) AND NOT EXISTS (
        SELECT 1 FROM instructor WHERE instructor.id = NEW.id
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Person in contact must exist in student or instructor.';
    END IF;
END |

CREATE TRIGGER update_student_credits
AFTER UPDATE ON enroll
FOR EACH ROW
BEGIN
    IF NEW.grade <> 'F' THEN
        UPDATE student
        SET credits = credits + (SELECT course.credits FROM course WHERE course.c_name = NEW.c_name)
        WHERE student.id = NEW.id;
    END IF;
END |

ALTER TABLE student ADD COLUMN credits INT DEFAULT 0|

CREATE TRIGGER handle_graduation
AFTER UPDATE ON student
FOR EACH ROW
BEGIN
    IF NEW.credits >= 130 THEN
        DELETE FROM student WHERE student.id = NEW.id;
        INSERT INTO alumni (id, s_name, graduation_date)
        VALUES (NEW.id, NEW.s_name, NOW());
    END IF;
END |

DELIMITER ;
