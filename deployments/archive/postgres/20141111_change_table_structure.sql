ALTER TABLE deployment_tracker DROP CONSTRAINT IF EXISTS deployment_tracker_deployment_type_id_fkey;
ALTER TABLE deployment_tracker ALTER COLUMN deployment_type_id SET DATA TYPE text;
ALTER TABLE deployment_tracker RENAME COLUMN deployment_type_id TO deployment_type;
ALTER TABLE deployment_tracker DROP CONSTRAINT IF EXISTS deployment_tracker_deployment_outcome_id_fkey;
ALTER TABLE deployment_tracker ALTER COLUMN deployment_outcome_id SET DATA TYPE text;
ALTER TABLE deployment_tracker RENAME COLUMN deployment_outcome_id TO deployment_outcome;
DROP TABLE deployment_type;
DROP TABLE deployment_outcome;
UPDATE deployment_tracker SET deployment_type = 'changes' WHERE deployment_type = '3';
UPDATE deployment_tracker SET deployment_type = 'seed' WHERE deployment_type = '2';
UPDATE deployment_tracker SET deployment_type = 'schema' WHERE deployment_type = '1';
-- next record catches known null value.  There is likely only 1 null from the initial insert of schema on deployments
UPDATE deployment_tracker SET deployment_type = 'schema' WHERE deployment_type IS NULL AND dbname = 'deployments';
-- set not null to prevent problem in future
ALTER TABLE deployment_tracker ALTER COLUMN deployment_type SET NOT NULL;
UPDATE deployment_tracker set deployment_outcome = 'OK' WHERE deployment_outcome = '1';
UPDATE deployment_tracker set deployment_outcome = 'FAIL' WHERE deployment_outcome = '2';
UPDATE deployment_tracker set deployment_outcome = 'SKIP' WHERE deployment_outcome = '3';
UPDATE deployment_tracker set deployment_outcome = 'OK' WHERE deployment_outcome IS NULL AND dbname = 'deployments';
