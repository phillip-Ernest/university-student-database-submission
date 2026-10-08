# MongoDB NoSQL Layer

## Purpose

MongoDB is included as a complementary NoSQL component for flexible student profile information.

PostgreSQL remains the primary relational database for structured academic records such as students, programs, courses, enrollments, grades, departments, and course offerings.

## Why MongoDB

MongoDB stores BSON documents and is suitable for semi-structured information whose attributes may vary between students.

Examples include:

- skills
- interests
- certifications
- emergency contacts
- portfolio links
- previous education

These attributes can change without requiring changes to the PostgreSQL table structure.

## Collection

The MongoDB collection is:

student_profiles

Example document:

{
  "student_id": 1,
  "profile_type": "student_profile",
  "skills": [
    "Python",
    "PostgreSQL",
    "Git"
  ],
  "interests": [
    "Data Engineering",
    "Web Development"
  ],
  "certifications": [
    {
      "name": "Database Fundamentals",
      "issuer": "University Training Program",
      "year": 2026
    }
  ],
  "emergency_contact": {
    "name": "Example Contact",
    "relationship": "Parent",
    "phone": "+254700000000"
  }
}

## Relationship to PostgreSQL

The student_id field provides the logical link between MongoDB student profiles and the PostgreSQL students table.

PostgreSQL remains the source of truth for:

- student identity
- programs
- courses
- course offerings
- enrollments
- grades
- academic terms

MongoDB complements PostgreSQL by storing flexible profile information.

## Indexing

Create a unique index on student_id:

db.student_profiles.createIndex({ student_id: 1 }, { unique: true })

This supports efficient lookup of a student's profile.

## Example Query

db.student_profiles.findOne({ student_id: 1 })

This retrieves the flexible profile associated with student 1.

## Design Decision

MongoDB was selected as a complementary NoSQL datastore rather than replacing PostgreSQL.

This hybrid approach keeps transactional academic data strongly structured in PostgreSQL while allowing flexible student profile attributes to evolve independently in MongoDB.