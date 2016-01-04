alter table deployment_tracker add checksum varchar(32);
create index deployment_tracker_checksum_idx on deployment_tracker(checksum);
