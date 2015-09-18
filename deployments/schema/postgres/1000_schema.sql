--
-- PostgreSQL database dump
--


CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;



COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';




CREATE FUNCTION update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
  END;
$$;




CREATE TABLE deployment_tracker (
    id integer NOT NULL,
    dbname text,
    deployment_type text NOT NULL,
    deployment_name text,
    deployment_outcome text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    is_active boolean DEFAULT true,
    deployed_by character varying(32),
    deployed_as character varying(32),
    reference_url text
);




CREATE SEQUENCE deployment_tracker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE deployment_tracker_id_seq OWNED BY deployment_tracker.id;

CREATE INDEX index_deployment_on_deployment_name ON deployment_tracker USING btree (deployment_name);

CREATE TRIGGER update_updated_at_modtime BEFORE UPDATE ON deployment_tracker FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

ALTER TABLE ONLY deployment_tracker ALTER COLUMN id SET DEFAULT nextval('deployment_tracker_id_seq'::regclass);
--
-- PostgreSQL database dump complete
--

