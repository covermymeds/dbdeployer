alter table deployment_tracker add column checksum varchar(32);
create index on deployment_tracker (checksum);
