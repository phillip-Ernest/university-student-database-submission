# Day 4 — Analytical Queries

## 1. Students and Their Programs

This query lists each student together with their academic program and department.

```sql
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.email,
    p.program_name,
    d.department_name
FROM students s
JOIN programs p
    ON s.program_id = p.program_id
JOIN departments d
    ON p.department_id = d.department_id
ORDER BY s.student_id;
