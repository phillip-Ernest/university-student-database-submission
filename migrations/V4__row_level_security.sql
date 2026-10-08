-- V4__row_level_security.sql
-- Row-Level Security for protecting student academic records

-- Helper function to identify the current student
CREATE OR REPLACE FUNCTION current_student_id()
RETURNS INT
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
    SELECT student_id
    FROM public.students
    WHERE email = current_setting('app.user_email', true)
    LIMIT 1;
$$;
   

-- Enable Row-Level Security
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrollments ENABLE ROW LEVEL SECURITY;
ALTER TABLE grades ENABLE ROW LEVEL SECURITY;


-- Students can view only their own student record
CREATE POLICY students_select_own
ON students
FOR SELECT
USING (
    student_id = current_student_id()
);


-- Students can view only their own enrollments
CREATE POLICY enrollments_select_own
ON enrollments
FOR SELECT
USING (
    student_id = current_student_id()
);


-- Students can view only their own grades
CREATE POLICY grades_select_own
ON grades
FOR SELECT
USING (
    enrollment_id IN (
        SELECT enrollment_id
        FROM enrollments
        WHERE student_id = current_student_id()
    )
);
