--
-- "EdTech MVP API"
-- Prepared SQL queries for '_enrollments_post_request' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table '_enrollments_post_request'
--
SELECT course_id FROM _enrollments_post_request WHERE 1=1;

--
-- INSERT template for table '_enrollments_post_request'
--
INSERT INTO _enrollments_post_request (course_id) VALUES (?);

--
-- UPDATE template for table '_enrollments_post_request'
--
UPDATE _enrollments_post_request SET course_id = ? WHERE 1=2;

--
-- DELETE template for table '_enrollments_post_request'
--
DELETE FROM _enrollments_post_request WHERE 1=2;

