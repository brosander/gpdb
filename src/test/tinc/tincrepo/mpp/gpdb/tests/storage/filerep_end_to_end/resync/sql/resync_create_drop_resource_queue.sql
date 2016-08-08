-- start_ignore
SET gp_create_table_random_default_distribution=off;
-- end_ignore
CREATE RESOURCE QUEUE resync_resque1 ACTIVE THRESHOLD 2 COST THRESHOLD 2000.00;
CREATE RESOURCE QUEUE resync_resque2 ACTIVE THRESHOLD 2 COST THRESHOLD 2000.00;
CREATE RESOURCE QUEUE resync_resque3 ACTIVE THRESHOLD 2 COST THRESHOLD 2000.00;

DROP RESOURCE QUEUE sync1_resque6;
DROP RESOURCE QUEUE ck_sync1_resque5;
DROP RESOURCE QUEUE ct_resque3;
DROP RESOURCE QUEUE resync_resque1;
