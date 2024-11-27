USE uic_without_foreign_keys;

-- The grade of each enrollment is one of A, A-, B+, B, B-, C+, C, C-, D, F.
ALTER TABLE enroll
ADD CONSTRAINT chk_grade CHECK (
        grade IN (
            'A',
            'A-',
            'B+',
            'B',
            'B-',
            'C+',
            'C',
            'C-',
            'D',
            'F'
        )
    );

-- The year of each student is between 1 and 4.
ALTER TABLE student
ADD CONSTRAINT chk_year CHECK (
        yr BETWEEN 1 AND 4
    );

-- Foreign Key between enroll and student
ALTER TABLE enroll
ADD CONSTRAINT fk_enroll_student FOREIGN KEY (id) REFERENCES student(id) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between section and instructor
ALTER TABLE section
ADD CONSTRAINT fk_section_instructor FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between section and course
ALTER TABLE section
ADD CONSTRAINT fk_section_course FOREIGN KEY (c_name) REFERENCES course(c_name) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between offer and program
ALTER TABLE offer
ADD CONSTRAINT fk_offer_program FOREIGN KEY (p_code) REFERENCES program(p_code) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between offer and course
ALTER TABLE offer
ADD CONSTRAINT fk_offer_course FOREIGN KEY (c_name) REFERENCES course(c_name) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between enroll and course
ALTER TABLE enroll
ADD CONSTRAINT fk_enroll_course FOREIGN KEY (c_name) REFERENCES course(c_name) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between student and program
ALTER TABLE student
ADD CONSTRAINT fk_student_program FOREIGN KEY (p_code) REFERENCES program(p_code) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between instructor and program
ALTER TABLE instructor
ADD CONSTRAINT fk_instructor_program FOREIGN KEY (p_code) REFERENCES program(p_code) ON UPDATE CASCADE ON DELETE CASCADE;

-- Foreign Key between borrow and book
ALTER TABLE borrow
ADD CONSTRAINT fk_borrow_book FOREIGN KEY (ISBN) REFERENCES book(ISBN) ON UPDATE CASCADE ON DELETE CASCADE;