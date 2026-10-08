# Performance Optimization Evidence

## Query Tested

The following query retrieves students belonging to a specific academic program:

```sql
SELECT
    student_id,
    first_name,
    last_name,
    email
FROM students
WHERE program_id = 1;