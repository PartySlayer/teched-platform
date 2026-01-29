--
-- "EdTech MVP API"
-- Prepared SQL queries for 'EnrollmentSummary_course' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table 'enrollment_summary_course'
--
SELECT "id", title, description FROM enrollment_summary_course WHERE 1=1;

--
-- INSERT template for table 'enrollment_summary_course'
--
INSERT INTO enrollment_summary_course ("id", title, description) VALUES (?, ?, ?);

--
-- UPDATE template for table 'enrollment_summary_course'
--
UPDATE enrollment_summary_course SET "id" = ?, title = ?, description = ? WHERE 1=2;

--
-- DELETE template for table 'enrollment_summary_course'
--
DELETE FROM enrollment_summary_course WHERE 1=2;

