--
-- "EdTech MVP API"
-- Prepared SQL queries for 'ContentUnit' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table 'content_unit'
--
SELECT "id", "type", title, slug, metadata, parent_id, order_index, progress FROM content_unit WHERE 1=1;

--
-- INSERT template for table 'content_unit'
--
INSERT INTO content_unit ("id", "type", title, slug, metadata, parent_id, order_index, progress) VALUES (?, ?, ?, ?, ?, ?, ?, ?);

--
-- UPDATE template for table 'content_unit'
--
UPDATE content_unit SET "id" = ?, "type" = ?, title = ?, slug = ?, metadata = ?, parent_id = ?, order_index = ?, progress = ? WHERE 1=2;

--
-- DELETE template for table 'content_unit'
--
DELETE FROM content_unit WHERE 1=2;

