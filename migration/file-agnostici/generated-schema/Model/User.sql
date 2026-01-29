--
-- "EdTech MVP API"
-- Prepared SQL queries for 'User' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table 'user'
--
SELECT "id", email, full_name, "role" FROM "user" WHERE 1=1;

--
-- INSERT template for table 'user'
--
INSERT INTO "user" ("id", email, full_name, "role") VALUES (?, ?, ?, ?);

--
-- UPDATE template for table 'user'
--
UPDATE "user" SET "id" = ?, email = ?, full_name = ?, "role" = ? WHERE 1=2;

--
-- DELETE template for table 'user'
--
DELETE FROM "user" WHERE 1=2;

