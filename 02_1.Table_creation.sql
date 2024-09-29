DROP TABLE IF EXISTS bootcamps CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;
DROP TABLE IF EXISTS teachers CASCADE;
DROP TABLE IF EXISTS teacher_subject CASCADE;
DROP TABLE IF EXISTS students CASCADE;

CREATE TABLE bootcamps (
    id_bootcamp SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE subjects (
    id_subject SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    id_bootcamp INTEGER NOT NULL,
    FOREIGN KEY (id_bootcamp) REFERENCES bootcamps(id_bootcamp)
);

CREATE TABLE teachers (
    id_teacher SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    mail VARCHAR(50) NOT NULL,
    phone VARCHAR(10)
);

CREATE TABLE teacher_subject (
    id_subject INTEGER NOT NULL,
    id_teacher INTEGER NOT NULL,
    FOREIGN KEY (id_teacher) REFERENCES teachers(id_teacher),
    FOREIGN KEY (id_subject) REFERENCES subjects(id_subject),
    UNIQUE (id_subject, id_teacher)
);

CREATE TABLE students (
    id_student SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    mail VARCHAR(50) NOT NULL,
    phone VARCHAR(10),
    id_bootcamp INTEGER NOT NULL,
    FOREIGN KEY (id_bootcamp) REFERENCES bootcamps(id_bootcamp)
);	