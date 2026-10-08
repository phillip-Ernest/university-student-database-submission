-- V2__indexes.sql
-- Performance indexes for University Student Records & Academic Management System

CREATE INDEX idx_programs_department_id
    ON programs(department_id);

CREATE INDEX idx_students_program_id
    ON students(program_id);

CREATE INDEX idx_instructors_department_id
    ON instructors(department_id);

CREATE INDEX idx_courses_department_id
    ON courses(department_id);

CREATE INDEX idx_course_offerings_course_id
    ON course_offerings(course_id);

CREATE INDEX idx_course_offerings_instructor_id
    ON course_offerings(instructor_id);

CREATE INDEX idx_course_offerings_term_id
    ON course_offerings(term_id);

CREATE INDEX idx_enrollments_student_id
    ON enrollments(student_id);

CREATE INDEX idx_enrollments_offering_id
    ON enrollments(offering_id);

CREATE INDEX idx_grades_enrollment_id
    ON grades(enrollment_id);

CREATE INDEX idx_course_prerequisites_prerequisite_course_id
    ON course_prerequisites(prerequisite_course_id);
