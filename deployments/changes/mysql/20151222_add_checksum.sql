alter table deployment_tracker add column checksum varchar(32),
ADD INDEX index_deployment_on_deployment_checksum(checksum);
