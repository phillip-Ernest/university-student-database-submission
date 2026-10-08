# University Student Database ER Diagram

This diagram represents the relational structure of the University Student Records & Academic Management System.

```mermaid
erDiagram
    DEPARTMENTS ||--o{ PROGRAMS : contains
    DEPARTMENTS ||--o{ INSTRUCTORS : employs
    DEPARTMENTS ||--o{ COURSES : owns

    PROGRAMS ||--o{ STUDENTS : has

    ACADEMIC_TERMS ||--o{ COURSE_OFFERINGS : schedules
    INSTRUCTORS ||--o{ COURSE_OFFERINGS : teaches
    COURSES ||--o{ COURSE_OFFERINGS : offered_as

    STUDENTS ||--o{ ENROLLMENTS : makes
    COURSE_OFFERINGS ||--o{ ENROLLMENTS : receives

    ENROLLMENTS ||--o| GRADES : receives

    COURSES ||--o{ COURSE_PREREQUISITES : requires
    COURSES ||--o{ COURSE_PREREQUISITES : prerequisite_for

    DEPARTMENTS {
        int department_id PK
        varchar department_name
    }

    PROGRAMS {
        int program_id PK
        int department_id FK
        varchar program_name
        varchar degree_level
    }

    STUDENTS {
        int student_id PK
        int program_id FK
        varchar first_name
        varchar last_name
        varchar email
        date date_of_birth
        varchar phone
        varchar enrollment_status
    }

    INSTRUCTORS {
        int instructor_id PK
        int department_id FK
        varchar first_name
        varchar last_name
        varchar email
    }

    COURSES {
        int course_id PK
        int department_id FK
        varchar course_code
        varchar course_name
        int credit_hours
    }

    COURSE_PREREQUISITES {
        int course_id FK
        int prerequisite_course_id FK
    }

    ACADEMIC_TERMS {
        int term_id PK
        varchar semester
        int academic_year
        date start_date
        date end_date
    }

    COURSE_OFFERINGS {
        int offering_id PK
        int course_id FK
        int instructor_id FK
        int term_id FK
    }

    ENROLLMENTS {
        int enrollment_id PK
        int student_id FK
        int offering_id FK
        timestamp enrolled_at
        varchar enrollment_status
    }

    GRADES {
        int grade_id PK
        int enrollment_id FK
        varchar letter_grade
        decimal grade_points
        timestamp graded_at
    }