-- V1__core_tables.sql
-- Core schema for University Student Records & Academic Management System

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE academic_terms (
    term_id SERIAL PRIMARY KEY,
    semester VARCHAR(30) NOT NULL,
    academic_year INT NOT NULL,
    start_date DATE,
    end_date DATE,

    CONSTRAINT uq_academic_term
        UNIQUE (semester, academic_year),

    CONSTRAINT chk_term_dates
        CHECK (
            end_date IS NULL
            OR start_date IS NULL
            OR end_date >= start_date
        )
);

CREATE TABLE programs (
    program_id SERIAL PRIMARY KEY,
    department_id INT NOT NULL,
    program_name VARCHAR(150) NOT NULL,
    degree_level VARCHAR(50) NOT NULL,

    CONSTRAINT fk_program_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    program_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    date_of_birth DATE,
    phone VARCHAR(30),
    enrollment_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_student_program
        FOREIGN KEY (program_id)
        REFERENCES programs(program_id)
);

CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    department_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,

    CONSTRAINT fk_instructor_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    department_id INT NOT NULL,
    course_code VARCHAR(30) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    credit_hours INT NOT NULL,

    CONSTRAINT fk_course_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    CONSTRAINT chk_credit_hours
        CHECK (credit_hours > 0)
);

CREATE TABLE course_prerequisites (
    course_id INT NOT NULL,
    prerequisite_course_id INT NOT NULL,

    PRIMARY KEY (course_id, prerequisite_course_id),

    CONSTRAINT fk_prerequisite_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id),

    CONSTRAINT fk_required_course
        FOREIGN KEY (prerequisite_course_id)
        REFERENCES courses(course_id),

    CONSTRAINT chk_no_self_prerequisite
        CHECK (course_id <> prerequisite_course_id)
);

CREATE TABLE course_offerings (
    offering_id SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    instructor_id INT NOT NULL,
    term_id INT NOT NULL,

    CONSTRAINT fk_offering_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id),

    CONSTRAINT fk_offering_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES instructors(instructor_id),

    CONSTRAINT fk_offering_term
        FOREIGN KEY (term_id)
        REFERENCES academic_terms(term_id),

    CONSTRAINT uq_course_offering
        UNIQUE (course_id, instructor_id, term_id)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    offering_id INT NOT NULL,
    enrolled_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    enrollment_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    CONSTRAINT fk_enrollment_offering
        FOREIGN KEY (offering_id)
        REFERENCES course_offerings(offering_id),

    CONSTRAINT uq_student_offering
        UNIQUE (student_id, offering_id)
);

CREATE TABLE grades (
    grade_id SERIAL PRIMARY KEY,
    enrollment_id INT NOT NULL UNIQUE,
    letter_grade VARCHAR(5),
    grade_points DECIMAL(4,2),
    graded_at TIMESTAMP,

    CONSTRAINT fk_grade_enrollment
        FOREIGN KEY (enrollment_id)
        REFERENCES enrollments(enrollment_id),

    CONSTRAINT chk_grade_points
    CHECK (
        grade_points IS NULL
        OR (grade_points >= 0 AND grade_points <= 4.00)
    ),

CONSTRAINT chk_letter_grade
    CHECK (
        letter_grade IS NULL
        OR letter_grade IN ('A', 'B+', 'B', 'C+', 'C', 'D', 'F')
    )
);
