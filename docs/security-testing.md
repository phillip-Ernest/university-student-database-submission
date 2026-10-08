# Security Testing Evidence

## 1. Audit Logging Test

The audit trigger was tested by updating Brian Kamau's phone number.

### Test

```sql
UPDATE students
SET phone = '+254711111111'
WHERE email = 'brian.kamau@student.example';
