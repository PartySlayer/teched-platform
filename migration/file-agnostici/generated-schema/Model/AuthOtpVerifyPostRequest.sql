--
-- "EdTech MVP API"
-- Prepared SQL queries for '_auth_otp_verify_post_request' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table '_auth_otp_verify_post_request'
--
SELECT email, code FROM _auth_otp_verify_post_request WHERE 1=1;

--
-- INSERT template for table '_auth_otp_verify_post_request'
--
INSERT INTO _auth_otp_verify_post_request (email, code) VALUES (?, ?);

--
-- UPDATE template for table '_auth_otp_verify_post_request'
--
UPDATE _auth_otp_verify_post_request SET email = ?, code = ? WHERE 1=2;

--
-- DELETE template for table '_auth_otp_verify_post_request'
--
DELETE FROM _auth_otp_verify_post_request WHERE 1=2;

