--
-- "EdTech MVP API"
-- Prepared SQL queries for '_auth_otp_verify_post_200_response' definition.
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--


--
-- SELECT template for table '_auth_otp_verify_post_200_response'
--
SELECT "token", "user" FROM _auth_otp_verify_post_200_response WHERE 1=1;

--
-- INSERT template for table '_auth_otp_verify_post_200_response'
--
INSERT INTO _auth_otp_verify_post_200_response ("token", "user") VALUES (?, ?);

--
-- UPDATE template for table '_auth_otp_verify_post_200_response'
--
UPDATE _auth_otp_verify_post_200_response SET "token" = ?, "user" = ? WHERE 1=2;

--
-- DELETE template for table '_auth_otp_verify_post_200_response'
--
DELETE FROM _auth_otp_verify_post_200_response WHERE 1=2;

