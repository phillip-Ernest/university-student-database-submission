# Backup and Restore Procedure

## Backup

A PostgreSQL custom-format backup can be created with:

```bash
pg_dump -Fc -f backups/capstone_$(date +%F).dump capstone
```

The `-Fc` option creates a PostgreSQL custom-format backup.

## Restore

The backup can be restored into a PostgreSQL database using:

```bash
createdb capstone_restore
pg_restore -d capstone_restore backups/capstone_YYYY-MM-DD.dump
```

## Verification

After restoration, verify the restored database with:

```sql
\dt
SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM enrollments;
SELECT COUNT(*) FROM grades;
```

The restored database should contain the expected tables and seed data.

## Backup Strategy

Backups should be created regularly and stored separately from the primary database.

A restore test should also be performed periodically to confirm that backups are usable.
