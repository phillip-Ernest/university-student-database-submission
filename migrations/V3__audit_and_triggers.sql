-- V3__audit_and_triggers.sql
-- Audit logging for important academic record changes

CREATE TABLE IF NOT EXISTS audit_log (
    audit_id BIGSERIAL PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    operation VARCHAR(20) NOT NULL,
    record_id BIGINT,
    old_data JSONB,
    new_data JSONB,
    changed_by VARCHAR(150) NOT NULL DEFAULT CURRENT_USER,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_audit_log_table_record
    ON audit_log(table_name, record_id);

CREATE INDEX IF NOT EXISTS idx_audit_log_changed_at
    ON audit_log(changed_at);


-- Audit function for students
CREATE OR REPLACE FUNCTION audit_students()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            new_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            NEW.student_id,
            to_jsonb(NEW)
        );

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            old_data,
            new_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            OLD.student_id,
            to_jsonb(OLD),
            to_jsonb(NEW)
        );

        RETURN NEW;

    ELSE
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            old_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            OLD.student_id,
            to_jsonb(OLD)
        );

        RETURN OLD;
    END IF;
END;
$$;


-- Audit function for enrollments
CREATE OR REPLACE FUNCTION audit_enrollments()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            new_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            NEW.enrollment_id,
            to_jsonb(NEW)
        );

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            old_data,
            new_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            OLD.enrollment_id,
            to_jsonb(OLD),
            to_jsonb(NEW)
        );

        RETURN NEW;

    ELSE
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            old_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            OLD.enrollment_id,
            to_jsonb(OLD)
        );

        RETURN OLD;
    END IF;
END;
$$;


-- Audit function for grades
CREATE OR REPLACE FUNCTION audit_grades()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            new_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            NEW.grade_id,
            to_jsonb(NEW)
        );

        RETURN NEW;

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            old_data,
            new_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            OLD.grade_id,
            to_jsonb(OLD),
            to_jsonb(NEW)
        );

        RETURN NEW;

    ELSE
        INSERT INTO audit_log (
            table_name,
            operation,
            record_id,
            old_data
        )
        VALUES (
            TG_TABLE_NAME,
            TG_OP,
            OLD.grade_id,
            to_jsonb(OLD)
        );

        RETURN OLD;
    END IF;
END;
$$;


-- Student audit trigger
CREATE TRIGGER trg_students_audit
AFTER INSERT OR UPDATE OR DELETE
ON students
FOR EACH ROW
EXECUTE FUNCTION audit_students();


-- Enrollment audit trigger
CREATE TRIGGER trg_enrollments_audit
AFTER INSERT OR UPDATE OR DELETE
ON enrollments
FOR EACH ROW
EXECUTE FUNCTION audit_enrollments();


-- Grade audit trigger
CREATE TRIGGER trg_grades_audit
AFTER INSERT OR UPDATE OR DELETE
ON grades
FOR EACH ROW
EXECUTE FUNCTION audit_grades();
