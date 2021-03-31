CREATE TRIGGER replication_monitor_updated_at_modtime BEFORE UPDATE ON replication_monitor FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();
