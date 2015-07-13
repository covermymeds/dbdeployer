--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
  END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: deployment_tracker; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE deployment_tracker (
    id integer NOT NULL,
    dbname text,
    deployment_type text NOT NULL,
    deployment_name text,
    deployment_outcome text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.deployment_tracker OWNER TO postgres;

--
-- Name: deployment_tracker_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE deployment_tracker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deployment_tracker_id_seq OWNER TO postgres;

--
-- Name: deployment_tracker_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE deployment_tracker_id_seq OWNED BY deployment_tracker.id;


--
-- Name: replication_monitor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE replication_monitor (
    id integer NOT NULL,
    value text,
    updated_at timestamp without time zone DEFAULT '2014-11-10 14:03:55.641944'::timestamp without time zone
);


ALTER TABLE public.replication_monitor OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY deployment_tracker ALTER COLUMN id SET DEFAULT nextval('deployment_tracker_id_seq'::regclass);


--
-- Name: deployment_tracker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('deployment_tracker_id_seq', 60, true);


--
-- Data for Name: replication_monitor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY replication_monitor (id, value, updated_at) FROM stdin;
1	foo	2014-11-10 14:03:55.641944
\.


--
-- Name: deployment_tracker_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY deployment_tracker
    ADD CONSTRAINT deployment_tracker_pkey PRIMARY KEY (id);


--
-- Name: replication_monitor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY replication_monitor
    ADD CONSTRAINT replication_monitor_pkey PRIMARY KEY (id);


--
-- Name: replication_monitor_updated_at_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER replication_monitor_updated_at_modtime BEFORE UPDATE ON replication_monitor FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- Name: update_updated_at_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_updated_at_modtime BEFORE UPDATE ON deployment_tracker FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

