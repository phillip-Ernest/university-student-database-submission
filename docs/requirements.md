# University Student Records & Academic Management System

## 1. Project Overview

The University Student Records & Academic Management System is designed to manage student information, academic programs, departments, courses, instructors, course registrations, and student grades. The system will provide a secure and reliable way for authorized university users to manage academic records.

## 2. Main Objectives

The system will:

- Store and manage student information.
- Manage university departments and academic programs.
- Store course information.
- Manage instructors and course offerings.
- Record student course enrollments.
- Store student grades and academic results.
- Support academic reports and analysis.
- Maintain an audit trail for important changes.
- Protect sensitive student information.

## 3. Main Users

The system will support:

- Administrators
- Instructors
- Academic staff
- Students

Administrators will manage system information and users. Instructors will manage courses and student grades. Academic staff will manage registrations and academic records. Students will view their own academic information and results.

## 4. Main Data Requirements

The system will store information about students, departments, programs, instructors, courses, course offerings, enrollments, and grades.

Each student belongs to one academic program. Each program belongs to one department. Departments can offer multiple programs and courses.

Courses can be offered during different semesters. Instructors can teach multiple course offerings. Students can enroll in multiple course offerings.

## 5. Business Rules

1. Each student has a unique student ID.
2. Each student has a unique email address.
3. Each student belongs to one academic program.
4. Each program belongs to one department.
5. A department can have many programs.
6. A department can offer many courses.
7. An instructor belongs to one department.
8. An instructor can teach multiple course offerings.
9. A student can enroll in many course offerings.
10. A course offering can have many students.
11. A student cannot enroll in the same course offering more than once.
12. Each enrollment can have one grade.
13. Important academic changes must be recorded in an audit log.
14. Users should only access information permitted by their role.

## 6. Reporting Requirements

The system should support reports such as:

- Students in a particular program.
- Students enrolled in a particular course.
- Courses taught by an instructor.
- A student's academic results.
- Student GPA.
- Course enrollment statistics.
- Department enrollment statistics.

## 7. Non-Functional Requirements

The system should provide data integrity, security, good performance, backup and recovery, auditability, and scalability. Database changes will be managed using version-controlled Flyway migrations.
