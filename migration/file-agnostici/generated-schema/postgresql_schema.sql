--
-- Schema objects for PostgreSQL
-- "EdTech MVP API"
-- Created using 'openapi-generator' ('postgresql-schema' generator)
-- (https://openapi-generator.tech/docs/generators/postgresql-schema)
--

--
-- DROP OBJECTS
-- (remove comment prefix to start using DROP commands)
--
-- TABLES
--
-- DROP TABLE IF EXISTS _auth_otp_request_post_request;
-- DROP TABLE IF EXISTS _auth_otp_verify_post_200_response;
-- DROP TABLE IF EXISTS _auth_otp_verify_post_request;
-- DROP TABLE IF EXISTS content_unit;
-- DROP TABLE IF EXISTS enrollment_summary;
-- DROP TABLE IF EXISTS enrollment_summary_course;
-- DROP TABLE IF EXISTS _enrollments_post_request;
-- DROP TABLE IF EXISTS _progress__content_unit_id__patch_request;
-- DROP TABLE IF EXISTS "user";
-- DROP TABLE IF EXISTS user_progress;

--
-- TYPES
--
-- DROP TYPE IF EXISTS content_unit_type;
-- DROP TYPE IF EXISTS _progress__content_unit_id__patch_request_status;
-- DROP TYPE IF EXISTS user_role;
-- DROP TYPE IF EXISTS user_progress_status;


--
-- CREATE OBJECTS
--
-- TYPES
--
CREATE TYPE content_unit_type AS ENUM('course', 'lesson', 'activity');
CREATE TYPE _progress__content_unit_id__patch_request_status AS ENUM('not_started', 'in_progress', 'completed');
CREATE TYPE user_role AS ENUM('student', 'admin');
CREATE TYPE user_progress_status AS ENUM('not_started', 'in_progress', 'completed');

--
-- TABLES
--
--
-- Table '_auth_otp_request_post_request' generated from model 'UnderscoreauthUnderscoreotpUnderscorerequestUnderscorepostUnderscorerequest'
--
CREATE TABLE IF NOT EXISTS _auth_otp_request_post_request (
    email TEXT DEFAULT NULL
);
;

--
-- Table '_auth_otp_verify_post_200_response' generated from model 'UnderscoreauthUnderscoreotpUnderscoreverifyUnderscorepostUnderscore200Underscoreresponse'
--
CREATE TABLE IF NOT EXISTS _auth_otp_verify_post_200_response (
    "token" TEXT DEFAULT NULL,
    "user" TEXT DEFAULT NULL
);
;
COMMENT ON COLUMN _auth_otp_verify_post_200_response."token" IS 'JWT per autenticazione';

--
-- Table '_auth_otp_verify_post_request' generated from model 'UnderscoreauthUnderscoreotpUnderscoreverifyUnderscorepostUnderscorerequest'
--
CREATE TABLE IF NOT EXISTS _auth_otp_verify_post_request (
    email TEXT DEFAULT NULL,
    code TEXT DEFAULT NULL
);
;

--
-- Table 'content_unit' generated from model 'ContentUnit'
--
CREATE TABLE IF NOT EXISTS content_unit (
    "id" TEXT DEFAULT NULL,
    "type" content_unit_type DEFAULT NULL,
    title TEXT DEFAULT NULL,
    slug TEXT DEFAULT NULL,
    metadata JSON DEFAULT NULL,
    parent_id TEXT DEFAULT NULL,
    order_index INTEGER DEFAULT NULL,
    progress TEXT DEFAULT NULL
);
COMMENT ON TABLE content_unit IS 'Original model name - ContentUnit.';
COMMENT ON COLUMN content_unit.parent_id IS 'Original param name - parentId.';
COMMENT ON COLUMN content_unit.order_index IS 'Original param name - orderIndex.';

--
-- Table 'enrollment_summary' generated from model 'EnrollmentSummary'
--
CREATE TABLE IF NOT EXISTS enrollment_summary (
    "id" TEXT DEFAULT NULL,
    course TEXT DEFAULT NULL,
    enrolled_at TIMESTAMP DEFAULT NULL,
    overall_progress DECIMAL(20, 9) DEFAULT NULL
);
COMMENT ON TABLE enrollment_summary IS 'Original model name - EnrollmentSummary.';
COMMENT ON COLUMN enrollment_summary.enrolled_at IS 'Original param name - enrolledAt.';
COMMENT ON COLUMN enrollment_summary.overall_progress IS 'Original param name - overallProgress.';

--
-- Table 'enrollment_summary_course' generated from model 'EnrollmentSummaryUnderscorecourse'
--
CREATE TABLE IF NOT EXISTS enrollment_summary_course (
    "id" TEXT DEFAULT NULL,
    title TEXT DEFAULT NULL,
    description TEXT DEFAULT NULL
);
COMMENT ON TABLE enrollment_summary_course IS 'Original model name - EnrollmentSummary_course.';

--
-- Table '_enrollments_post_request' generated from model 'UnderscoreenrollmentsUnderscorepostUnderscorerequest'
--
CREATE TABLE IF NOT EXISTS _enrollments_post_request (
    course_id TEXT DEFAULT NULL
);
;
COMMENT ON COLUMN _enrollments_post_request.course_id IS 'Original param name - courseId.';

--
-- Table '_progress__content_unit_id__patch_request' generated from model 'UnderscoreprogressUnderscoreUnderscorecontentUnitIdUnderscoreUnderscorepatchUnderscorerequest'
--
CREATE TABLE IF NOT EXISTS _progress__content_unit_id__patch_request (
    status _progress__content_unit_id__patch_request_status DEFAULT NULL,
    last_position INTEGER DEFAULT NULL
);
COMMENT ON TABLE _progress__content_unit_id__patch_request IS 'Original model name - _progress__contentUnitId__patch_request.';
COMMENT ON COLUMN _progress__content_unit_id__patch_request.last_position IS 'Original param name - lastPosition.';

--
-- Table 'user' generated from model 'User'
--
CREATE TABLE IF NOT EXISTS "user" (
    "id" TEXT DEFAULT NULL,
    email TEXT DEFAULT NULL,
    full_name TEXT DEFAULT NULL,
    "role" user_role DEFAULT NULL
);
COMMENT ON TABLE "user" IS 'Original model name - User.';
COMMENT ON COLUMN "user".full_name IS 'Original param name - fullName.';

--
-- Table 'user_progress' generated from model 'UserProgress'
--
CREATE TABLE IF NOT EXISTS user_progress (
    status user_progress_status DEFAULT NULL,
    last_position INTEGER DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL
);
COMMENT ON TABLE user_progress IS 'Original model name - UserProgress.';
COMMENT ON COLUMN user_progress.last_position IS 'Secondi nel video. Original param name - lastPosition.';
COMMENT ON COLUMN user_progress.updated_at IS 'Original param name - updatedAt.';

