--
-- "EdTech MVP API"
-- Prepared SQL queries for 'UserProgress' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table 'user_progress'
--
SELECT status, last_position, updated_at FROM user_progress WHERE 1=1;

--
-- INSERT template for table 'user_progress'
--
INSERT INTO user_progress (status, last_position, updated_at) VALUES (?, ?, ?);

--
-- UPDATE template for table 'user_progress'
--
UPDATE user_progress SET status = ?, last_position = ?, updated_at = ? WHERE 1=2;

--
-- DELETE template for table 'user_progress'
--
DELETE FROM user_progress WHERE 1=2;

