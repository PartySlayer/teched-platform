--
-- "EdTech MVP API"
-- Prepared SQL queries for 'EnrollmentSummary' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table 'enrollment_summary'
--
SELECT "id", course, enrolled_at, overall_progress FROM enrollment_summary WHERE 1=1;

--
-- INSERT template for table 'enrollment_summary'
--
INSERT INTO enrollment_summary ("id", course, enrolled_at, overall_progress) VALUES (?, ?, ?, ?);

--
-- UPDATE template for table 'enrollment_summary'
--
UPDATE enrollment_summary SET "id" = ?, course = ?, enrolled_at = ?, overall_progress = ? WHERE 1=2;

--
-- DELETE template for table 'enrollment_summary'
--
DELETE FROM enrollment_summary WHERE 1=2;

