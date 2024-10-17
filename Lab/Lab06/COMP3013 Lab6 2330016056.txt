CREATE DATABASE uic_example;

USE uic_example;

-- Define the table for “borrow”.
CREATE TABLE borrow (
    id INT NOT NULL,
    ISBN INT NOT NULL,
    return_date DATE,
    borrow_date DATE NOT NULL,
    PRIMARY KEY (id, ISBN)
);

CREATE TABLE books (
    ISBN INT NOT NULL,
    b_title VARCHAR(40),
    author VARCHAR(20),
    PRIMARY KEY (ISBN)
);

ALTER TABLE borrow
ADD FOREIGN KEY (ISBN) REFERENCES books (ISBN);

CREATE TABLE programs (
    p_code INT NOT NULL,
    p_name VARCHAR(40) NOT NULL,
    division varchar(40) NOT NULL,
    director varchar(40) NOT NULL,
    PRIMARY KEY (p_code)
);

CREATE TABLE course (
    c_name VARCHAR(40) NOT NULL,
    credits int NOT NULL,
    domain VARCHAR(40) NOT NULL,
    c_number int NOT NULL,
    PRIMARY KEY (c_name)
);

CREATE TABLE offer (
    p_code INT NOT NULL,
    c_name VARCHAR(40) NOT NULL,
    PRIMARY KEY (p_code, c_name),
    FOREIGN KEY (p_code) REFERENCES programs (p_code),
    FOREIGN KEY (c_name) REFERENCES course (c_name)
);

CREATE TABLE section (
    c_name VARCHAR(40) NOT NULL,
    s_number INT NOT NULL,
    sem INT NOT NULL,
    venue VARCHAR(40),
    time TIME,
    instructor_id INT,
    PRIMARY KEY (c_name, s_number, sem),
    FOREIGN KEY (c_name) REFERENCES course (c_name)
);

CREATE TABLE contact (
    id INT NOT NULL,
    phone VARCHAR(40),
    PRIMARY KEY (id, phone)
);

CREATE TABLE enroll (
    id INT NOT NULL,
    c_name VARCHAR(40) NOT NULL,
    s_number INT NOT NULL,
    sem INT NOT NULL,
    grade FLOAT,
    PRIMARY KEY (id, c_name, s_number, sem),
    FOREIGN KEY (id) REFERENCES contact(id),
    FOREIGN KEY (c_name, s_number, sem) REFERENCES section(c_name, s_number, sem)
);

CREATE TABLE students (
    id INT NOT NULL,
    s_name VARCHAR(40) NOT NULL,
    year YEAR,
    gpa FLOAT(2),
    major VARCHAR(50),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES contact(id)
);

CREATE TABLE instructors (
    id INT NOT NULL,
    i_name VARCHAR(40) NOT NULL,
    title VARCHAR(40),
    salary FLOAT,
    program VARCHAR(40),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES contact(id)
);