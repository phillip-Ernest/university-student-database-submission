-- V5__seed_demo_data.sql
-- Seed demo data for University Student Records & Academic Management System

-- Departments
INSERT INTO departments (department_name)
VALUES
    ('Computer Science'),
    ('Business Administration'),
    ('Information Technology');


-- Academic terms
INSERT INTO academic_terms (
    semester,
    academic_year,
    start_date,
    end_date
)
VALUES
    ('First Semester', 2026, '2026-01-12', '2026-04-30'),
    ('Second Semester', 2026, '2026-05-11', '2026-08-31');


-- Programs
INSERT INTO programs (
    department_id,
    program_name,
    degree_level
)
VALUES
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Computer Science'),
        'Bachelor of Computer Science',
        'Bachelor'
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Business Administration'),
        'Bachelor of Business Administration',
        'Bachelor'
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Information Technology'),
        'Bachelor of Information Technology',
        'Bachelor'
    );


-- Instructors
INSERT INTO instructors (
    department_id,
    first_name,
    last_name,
    email
)
VALUES
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Computer Science'),
        'Grace',
        'Wanjiku',
        'grace.wanjiku@university.example'
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Business Administration'),
        'Daniel',
        'Otieno',
        'daniel.otieno@university.example'
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Information Technology'),
        'Mary',
        'Achieng',
        'mary.achieng@university.example'
    );


-- Courses
INSERT INTO courses (
    department_id,
    course_code,
    course_name,
    credit_hours
)
VALUES
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Computer Science'),
        'CS101',
        'Introduction to Programming',
        3
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Computer Science'),
        'CS201',
        'Database Systems',
        3
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Business Administration'),
        'BA101',
        'Principles of Management',
        3
    ),
    (
        (SELECT department_id FROM departments
         WHERE department_name = 'Information Technology'),
        'IT201',
        'Information Systems',
        3
    );


-- Course prerequisite
INSERT INTO course_prerequisites (
    course_id,
    prerequisite_course_id
)
VALUES
    (
        (SELECT course_id FROM courses WHERE course_code = 'CS201'),
        (SELECT course_id FROM courses WHERE course_code = 'CS101')
    );


-- Course offerings
INSERT INTO course_offerings (
    course_id,
    instructor_id,
    term_id
)
VALUES
    (
        (SELECT course_id FROM courses WHERE course_code = 'CS101'),
        (SELECT instructor_id FROM instructors
         WHERE email = 'grace.wanjiku@university.example'),
        (SELECT term_id FROM academic_terms
         WHERE semester = 'First Semester' AND academic_year = 2026)
    ),
    (
        (SELECT course_id FROM courses WHERE course_code = 'CS201'),
        (SELECT instructor_id FROM instructors
         WHERE email = 'grace.wanjiku@university.example'),
        (SELECT term_id FROM academic_terms
         WHERE semester = 'Second Semester' AND academic_year = 2026)
    ),
    (
        (SELECT course_id FROM courses WHERE course_code = 'BA101'),
        (SELECT instructor_id FROM instructors
         WHERE email = 'daniel.otieno@university.example'),
        (SELECT term_id FROM academic_terms
         WHERE semester = 'First Semester' AND academic_year = 2026)
    ),
    (
        (SELECT course_id FROM courses WHERE course_code = 'IT201'),
        (SELECT instructor_id FROM instructors
         WHERE email = 'mary.achieng@university.example'),
        (SELECT term_id FROM academic_terms
         WHERE semester = 'Second Semester' AND academic_year = 2026)
    );


-- Students
INSERT INTO students (
    program_id,
    first_name,
    last_name,
    email,
    date_of_birth,
    phone,
    enrollment_status
)
VALUES
    (
        (SELECT program_id FROM programs
         WHERE program_name = 'Bachelor of Computer Science'),
        'Brian',
        'Kamau',
        'brian.kamau@student.example',
        '2002-03-15',
        '+254700000001',
        'active'
    ),
    (
        (SELECT program_id FROM programs
         WHERE program_name = 'Bachelor of Computer Science'),
        'Aisha',
        'Mohamed',
        'aisha.mohamed@student.example',
        '2001-07-22',
        '+254700000002',
        'active'
    ),
    (
        (SELECT program_id FROM programs
         WHERE program_name = 'Bachelor of Business Administration'),
        'Kevin',
        'Otieno',
        'kevin.otieno@student.example',
        '2003-01-10',
        '+254700000003',
        'active'
    ),
    (
        (SELECT program_id FROM programs
         WHERE program_name = 'Bachelor of Information Technology'),
        'Faith',
        'Njeri',
        'faith.njeri@student.example',
        '2002-11-05',
        '+254700000004',
        'active'
    );


-- Enrollments
INSERT INTO enrollments (
    student_id,
    offering_id,
    enrollment_status
)
VALUES
    (
        (SELECT student_id FROM students
         WHERE email = 'brian.kamau@student.example'),
        (SELECT offering_id FROM course_offerings
         WHERE course_id = (
             SELECT course_id FROM courses WHERE course_code = 'CS101'
         )),
        'completed'
    ),
    (
        (SELECT student_id FROM students
         WHERE email = 'aisha.mohamed@student.example'),
        (SELECT offering_id FROM course_offerings
         WHERE course_id = (
             SELECT course_id FROM courses WHERE course_code = 'CS101'
         )),
        'completed'
    ),
    (
        (SELECT student_id FROM students
         WHERE email = 'kevin.otieno@student.example'),
        (SELECT offering_id FROM course_offerings
         WHERE course_id = (
             SELECT course_id FROM courses WHERE course_code = 'BA101'
         )),
        'completed'
    ),
    (
        (SELECT student_id FROM students
         WHERE email = 'faith.njeri@student.example'),
        (SELECT offering_id FROM course_offerings
         WHERE course_id = (
             SELECT course_id FROM courses WHERE course_code = 'IT201'
         )),
        'active'
    );


-- Grades
INSERT INTO grades (
    enrollment_id,
    letter_grade,
    grade_points,
    graded_at
)
VALUES
    (
        (
            SELECT e.enrollment_id
            FROM enrollments e
            JOIN students s
                ON s.student_id = e.student_id
            WHERE s.email = 'brian.kamau@student.example'
        ),
        'A',
        4.00,
        '2026-05-05 10:00:00'
    ),
    (
        (
            SELECT e.enrollment_id
            FROM enrollments e
            JOIN students s
                ON s.student_id = e.student_id
            WHERE s.email = 'aisha.mohamed@student.example'
        ),
        'B+',
        3.50,
        '2026-05-05 10:05:00'
    ),
    (
        (
            SELECT e.enrollment_id
            FROM enrollments e
            JOIN students s
                ON s.student_id = e.student_id
            WHERE s.email = 'kevin.otieno@student.example'
        ),
        'B',
        3.00,
        '2026-05-05 10:10:00'
    );