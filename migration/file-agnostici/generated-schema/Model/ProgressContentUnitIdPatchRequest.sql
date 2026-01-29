--
-- "EdTech MVP API"
-- Prepared SQL queries for '_progress__contentUnitId__patch_request' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table '_progress__content_unit_id__patch_request'
--
SELECT status, last_position FROM _progress__content_unit_id__patch_request WHERE 1=1;

--
-- INSERT template for table '_progress__content_unit_id__patch_request'
--
INSERT INTO _progress__content_unit_id__patch_request (status, last_position) VALUES (?, ?);

--
-- UPDATE template for table '_progress__content_unit_id__patch_request'
--
UPDATE _progress__content_unit_id__patch_request SET status = ?, last_position = ? WHERE 1=2;

--
-- DELETE template for table '_progress__content_unit_id__patch_request'
--
DELETE FROM _progress__content_unit_id__patch_request WHERE 1=2;

