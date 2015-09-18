CREATE TABLE deployment_tracker (
    id integer IDENTITY,
    dbname varchar(128),
    deployment_type varchar(128) NOT NULL,
    deployment_name varchar(1024),
    deployment_outcome varchar(32),
    created_at DATETIME DEFAULT (getdate()),
    updated_at DATETIME DEFAULT (getdate()),
    is_active bit DEFAULT 1,
    deployed_by character varying(32),
    deployed_as character varying(32),
    reference_url text
);

go 
create trigger update_updated_at_column on dbo.deployment_tracker
AFTER update
as
begin
  update 
  deployment_tracker set updated_at = getdate() from inserted i where i.id=deployment_tracker.id
end

CREATE INDEX index_deployment_on_deployment_name ON deployment_tracker (deployment_name);

