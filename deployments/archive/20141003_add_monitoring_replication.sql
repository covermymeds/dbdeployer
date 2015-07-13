create table replication_monitor
( 
  id int,
  value text,
  updated_at timestamp default 'now'::timestamp
);

ALTER TABLE replication_monitor OWNER TO postgres;

ALTER TABLE ONLY replication_monitor
    ADD CONSTRAINT replication_monitor_pkey PRIMARY KEY (id);
