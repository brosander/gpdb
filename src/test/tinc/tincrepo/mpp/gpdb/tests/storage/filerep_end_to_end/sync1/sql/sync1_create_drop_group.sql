-- start_ignore
SET gp_create_table_random_default_distribution=off;
-- end_ignore
--
-- CREATE GROUP
--
CREATE GROUP sync1_group1 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group2 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group3 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group4 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group5 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group6 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group7 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
CREATE GROUP sync1_group8 WITH SUPERUSER CREATEDB  INHERIT LOGIN CONNECTION LIMIT  1 ENCRYPTED PASSWORD 'passwd';
--
--
--DROP GROUP
--
--
DROP GROUP sync1_group1;
--
