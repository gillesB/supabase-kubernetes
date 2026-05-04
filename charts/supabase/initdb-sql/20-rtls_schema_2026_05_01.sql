--
-- PostgreSQL database dump
--

--\restrict KKXw71o0UCYIDCWOQQnPmZYeCvpWL1TlJ9O3bhtw77bqmy2vgaIkz3K8lPJVbGH

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.9 (Ubuntu 17.9-1.pgdg24.04+1)

-- Started on 2026-05-04 10:53:18 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 13 (class 2615 OID 30362)
-- Name: _analytics; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

--
-- Roles
--

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'anon') THEN
    CREATE ROLE anon;
  END IF;
END $$;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'authenticated') THEN
    CREATE ROLE authenticated;
  END IF;
END $$;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'authenticator') THEN
    CREATE ROLE authenticator PASSWORD 'SCRAM-SHA-256$4096:dCh/+Ia2eI9ApljBmCfoPQ==$/9qJLevVXeJm2732t0oz1XR6o7njMCe3JCV4wjBZ5D8=:sKiSYpyTRl3+fUMnfgbfNV+O7kqXbcUKpVAtSBPGFoA=';
  END IF;
END $$;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:dCh/+Ia2eI9ApljBmCfoPQ==$/9qJLevVXeJm2732t0oz1XR6o7njMCe3JCV4wjBZ5D8=:sKiSYpyTRl3+fUMnfgbfNV+O7kqXbcUKpVAtSBPGFoA=';

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'dashboard_user') THEN
    CREATE ROLE dashboard_user;
  END IF;
END $$;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'pgbouncer') THEN
    CREATE ROLE pgbouncer PASSWORD 'SCRAM-SHA-256$4096:lmw8QUBcFclf4h/vkiVfaQ==$XHftdXp17xslYVT0l/ZtXw0JydQe8ityh8dg76rKaUI=:lDtYOFBSnjDwepp2uFF3lM0ofUhZ6djyESvfHN0f6jo=';
  END IF;
END $$;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:lmw8QUBcFclf4h/vkiVfaQ==$XHftdXp17xslYVT0l/ZtXw0JydQe8ityh8dg76rKaUI=:lDtYOFBSnjDwepp2uFF3lM0ofUhZ6djyESvfHN0f6jo=';

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'postgres') THEN
    CREATE ROLE postgres;
  END IF;
END $$;


DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'service_role') THEN
    CREATE ROLE service_role;
  END IF;
END $$;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_admin') THEN
    CREATE ROLE supabase_admin;
  END IF;
END $$;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Pe+D05oFTncqyasTxd2sLA==$ofwHRPthS2eeZXHWN8JtE0ge6AYgxxg5TG1StTXfeSs=:OIQrrVo/twXuI03SkCh9vjeLEVPUULAkI8gFlyYKiEM=';


DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_auth_admin') THEN
    CREATE ROLE supabase_auth_admin PASSWORD 'SCRAM-SHA-256$4096:8wjwi9sI7admXoCpqeU9fQ==$l6+PONc9K8kT20mdqNrXo4x2rfbPwEizdSY4ccavmjo=:7vIoitKpTkel82KEmYZ5H6fjY3q9sFUkAdNkoSczqpw=';
  END IF;
END $$;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:8wjwi9sI7admXoCpqeU9fQ==$l6+PONc9K8kT20mdqNrXo4x2rfbPwEizdSY4ccavmjo=:7vIoitKpTkel82KEmYZ5H6fjY3q9sFUkAdNkoSczqpw=';

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_etl_admin') THEN
    CREATE ROLE supabase_etl_admin;
  END IF;
END $$;
ALTER ROLE supabase_etl_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_functions_admin') THEN
    CREATE ROLE supabase_functions_admin PASSWORD 'SCRAM-SHA-256$4096:+SSiFgQTA/8HVVRuCEAkyg==$ZZAM4v69BlMt3/CySwvTRVv4DqnHeNLEOzlHfIaPbQA=:0/jdb+NHvChVrWIbD3v+Xvtl1RogcxXmGCo7hLe4HcA=';
  END IF;
END $$;
ALTER ROLE supabase_functions_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:+SSiFgQTA/8HVVRuCEAkyg==$ZZAM4v69BlMt3/CySwvTRVv4DqnHeNLEOzlHfIaPbQA=:0/jdb+NHvChVrWIbD3v+Xvtl1RogcxXmGCo7hLe4HcA=';

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_read_only_user') THEN
    CREATE ROLE supabase_read_only_user;
  END IF;
END $$;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_replication_admin') THEN
    CREATE ROLE supabase_replication_admin;
  END IF;
END $$;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS;

DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'supabase_storage_admin') THEN
    CREATE ROLE supabase_storage_admin PASSWORD 'SCRAM-SHA-256$4096:H3T9B4h9FnBaz+ueCCxaJQ==$tfK6yn5aZfMFhExzTjPxw7NNqJI+6QzcttNviBDiINI=:fUL5Ztf7liER8BnevGvWyhAShfSmpA3NRhYX3bKBd6Q=';
  END IF;
END $$;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:H3T9B4h9FnBaz+ueCCxaJQ==$tfK6yn5aZfMFhExzTjPxw7NNqJI+6QzcttNviBDiINI=:fUL5Ztf7liER8BnevGvWyhAShfSmpA3NRhYX3bKBd6Q=';

-- Become supabase_admin
SET ROLE supabase_admin;

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO E'\\$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_functions_admin"
--

ALTER ROLE supabase_functions_admin SET search_path TO 'supabase_functions';

--
-- User Config "supabase_read_only_user"
--

ALTER ROLE supabase_read_only_user SET default_transaction_read_only TO 'on';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

--GRANT anon TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
--GRANT anon TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT authenticated TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
--GRANT authenticated TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT authenticator TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT authenticator TO supabase_storage_admin WITH INHERIT FALSE GRANTED BY supabase_admin;
--GRANT pg_create_subscription TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;
--GRANT pg_monitor TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT pg_read_all_data TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT pg_read_all_data TO supabase_etl_admin WITH INHERIT TRUE GRANTED BY supabase_admin;
--GRANT pg_read_all_data TO supabase_read_only_user WITH INHERIT TRUE GRANTED BY supabase_admin;
--GRANT pg_signal_backend TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT service_role TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
--GRANT service_role TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
--GRANT supabase_functions_admin TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;

CREATE SCHEMA _analytics;


ALTER SCHEMA _analytics OWNER TO supabase_admin;

--
-- TOC entry 14 (class 2615 OID 30363)
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO supabase_admin;

--
-- TOC entry 22 (class 2615 OID 30364)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 23 (class 2615 OID 30365)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 15 (class 2615 OID 30366)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 16 (class 2615 OID 30367)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 8 (class 3079 OID 30368)
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- TOC entry 6946 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- TOC entry 17 (class 2615 OID 30411)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 18 (class 2615 OID 30412)
-- Name: private; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA private;


ALTER SCHEMA private OWNER TO postgres;

--
-- TOC entry 26 (class 2615 OID 30413)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 27 (class 2615 OID 30414)
-- Name: rtls_config; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA rtls_config;


ALTER SCHEMA rtls_config OWNER TO supabase_admin;

--
-- TOC entry 28 (class 2615 OID 30415)
-- Name: rtls_measurement; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA rtls_measurement;


ALTER SCHEMA rtls_measurement OWNER TO supabase_admin;

--
-- TOC entry 37 (class 2615 OID 30416)
-- Name: rtls_measurement_2; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA rtls_measurement_2;


ALTER SCHEMA rtls_measurement_2 OWNER TO supabase_admin;

--
-- TOC entry 19 (class 2615 OID 30417)
-- Name: rtls_measurement_etl; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA rtls_measurement_etl;


ALTER SCHEMA rtls_measurement_etl OWNER TO supabase_admin;

--
-- TOC entry 20 (class 2615 OID 30418)
-- Name: rtls_redis; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA rtls_redis;


ALTER SCHEMA rtls_redis OWNER TO postgres;

--
-- TOC entry 38 (class 2615 OID 30419)
-- Name: rtls_timeseries; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA rtls_timeseries;


ALTER SCHEMA rtls_timeseries OWNER TO supabase_admin;

--
-- TOC entry 29 (class 2615 OID 30420)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 30 (class 2615 OID 30421)
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- TOC entry 21 (class 2615 OID 30422)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- TOC entry 39 (class 2615 OID 30423)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 2 (class 3079 OID 30424)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 6957 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 7 (class 3079 OID 30434)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 6958 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 6 (class 3079 OID 30471)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 6959 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 30508)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA extensions;


--
-- TOC entry 6960 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 9 (class 3079 OID 31552)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 6961 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 4 (class 3079 OID 31575)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 6962 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 3 (class 3079 OID 31586)
-- Name: wrappers; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS wrappers WITH SCHEMA extensions;


--
-- TOC entry 6963 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION wrappers; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION wrappers IS 'Foreign data wrappers developed by Supabase';


--
-- TOC entry 2103 (class 1247 OID 31642)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 2106 (class 1247 OID 31650)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 2109 (class 1247 OID 31656)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 2112 (class 1247 OID 31662)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 2115 (class 1247 OID 31670)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 2118 (class 1247 OID 31684)
-- Name: elanguage; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.elanguage AS ENUM (
    'de',
    'en'
);


ALTER TYPE public.elanguage OWNER TO postgres;

--
-- TOC entry 2121 (class 1247 OID 31690)
-- Name: epermission; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.epermission AS ENUM (
    'profiles.create',
    'profiles.read',
    'profiles.update',
    'profiles.delete',
    'roles.read',
    'roles.create',
    'roles.update',
    'roles.delete',
    'devices.read',
    'devices.write',
    'devices.update',
    'devices.delete',
    'areas.read',
    'areas.update',
    'areas.delete',
    'maps.read',
    'maps.update',
    'maps.delete',
    'ui.page.overview.view',
    'ui.page.tracking.view',
    'ui.page.device_types.view',
    'ui.page.devices.view',
    'ui.page.tags.view',
    'ui.page.anchors.view',
    'ui.page.anchor_detail.view',
    'ui.page.maps.view',
    'ui.page.areas.view',
    'ui.page.roles.view',
    'ui.page.users.view',
    'ui.page.dashboards.view',
    'ui.page.artos.view',
    'reference_points.read'
);


ALTER TYPE public.epermission OWNER TO postgres;

--
-- TOC entry 2124 (class 1247 OID 31756)
-- Name: area_type; Type: TYPE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TYPE rtls_config.area_type AS ENUM (
    'site',
    'compound',
    'hall',
    'raster',
    'alarm',
    'custom'
);


ALTER TYPE rtls_config.area_type OWNER TO supabase_admin;

--
-- TOC entry 2127 (class 1247 OID 31770)
-- Name: permission_type; Type: TYPE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TYPE rtls_config.permission_type AS ENUM (
    'entry_forbidden',
    'exit_forbidden'
);


ALTER TYPE rtls_config.permission_type OWNER TO supabase_admin;

--
-- TOC entry 2130 (class 1247 OID 31776)
-- Name: position_origin; Type: TYPE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TYPE rtls_timeseries.position_origin AS ENUM (
    'ESTIMATED',
    'AUTO',
    'CONFIGURED',
    'GNSS'
);


ALTER TYPE rtls_timeseries.position_origin OWNER TO supabase_admin;

--
-- TOC entry 2133 (class 1247 OID 31786)
-- Name: position_type; Type: TYPE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TYPE rtls_timeseries.position_type AS ENUM (
    'GPS',
    'XYZ'
);


ALTER TYPE rtls_timeseries.position_type OWNER TO supabase_admin;

--
-- TOC entry 2136 (class 1247 OID 31792)
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- TOC entry 5179 (class 2605 OID 31797)
-- Name: CAST (text AS public.elanguage); Type: CAST; Schema: -; Owner: -
--

CREATE CAST (text AS public.elanguage) WITH INOUT AS ASSIGNMENT;


--
-- TOC entry 1390 (class 1255 OID 31798)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 7014 (class 0 OID 0)
-- Dependencies: 1390
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 1228 (class 1255 OID 31799)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 750 (class 1255 OID 31800)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 7017 (class 0 OID 0)
-- Dependencies: 750
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 1073 (class 1255 OID 31801)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 7019 (class 0 OID 0)
-- Dependencies: 1073
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 1345 (class 1255 OID 31802)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 7221 (class 0 OID 0)
-- Dependencies: 1345
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 768 (class 1255 OID 31803)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 7223 (class 0 OID 0)
-- Dependencies: 768
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 609 (class 1255 OID 31804)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 7225 (class 0 OID 0)
-- Dependencies: 609
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 964 (class 1255 OID 31805)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 585 (class 1255 OID 31806)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 587 (class 1255 OID 31807)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 7358 (class 0 OID 0)
-- Dependencies: 587
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 751 (class 1255 OID 31808)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 736 (class 1255 OID 31809)
-- Name: authorize(text); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.authorize(requested_permission text) RETURNS boolean
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO ''
    AS $$
declare
  permission_count int;
  user_role_ids uuid[];
  iterator_role_id uuid;
begin
  -- Fetch user role once and store it to reduce number of calls
  -- select array(select jsonb_array_elements_text(auth.jwt() -> 'user_roles')::uuid) into user_role_ids;
  
  -- Get user roles directly from database instead of JWT
  SELECT ARRAY(
    SELECT role_id
    FROM public.user_roles
    WHERE user_id = auth.uid()
  )::uuid[] INTO user_role_ids;

  -- Return early if no roles found
  IF user_role_ids IS NULL OR array_length(user_role_ids, 1) IS NULL THEN
    RETURN false;
  END IF;

  foreach iterator_role_id in array user_role_ids
  loop
    select count(*)
    into permission_count
    from public.roles
    where (requested_permission::public.epermission = any(roles.permissions) OR roles.superadmin = true)
      and roles.id = iterator_role_id;
    if (permission_count > 0) then
      return (true);
    end if;
  end loop;

  return (false);
end;
$$;


ALTER FUNCTION private.authorize(requested_permission text) OWNER TO postgres;

--
-- TOC entry 989 (class 1255 OID 31810)
-- Name: force_user_defaults(); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.force_user_defaults() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
  if NEW.lastname is null then
  NEW.lastname := '';
  end if;

  if NEW.language is null then
  NEW.language := 'en'::public.elanguage;
  end if;

  return NEW;
end
$$;


ALTER FUNCTION private.force_user_defaults() OWNER TO postgres;

--
-- TOC entry 735 (class 1255 OID 31811)
-- Name: get_user_min_role_ordering(uuid); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.get_user_min_role_ordering(user_uuid uuid) RETURNS integer
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    AS $$
declare
  min_ordering int;
begin
  select min(r.ordering)
  into min_ordering
  from public.user_roles ur
  join public.roles r on ur.role_id = r.id
  where ur.user_id = user_uuid;

  -- If user has no roles, return maximum integer to deny all operations
  return coalesce(min_ordering, 2147483647);
end;
$$;


ALTER FUNCTION private.get_user_min_role_ordering(user_uuid uuid) OWNER TO postgres;

--
-- TOC entry 802 (class 1255 OID 31812)
-- Name: handle_new_user(); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $$
begin
  insert into public.profiles (id, firstname, lastname, email, language)
  values (
  new.id,
  new.raw_user_meta_data ->> 'firstname',
  new.raw_user_meta_data ->> 'lastname',
  new.email,
  new.raw_user_meta_data ->> 'language'
  );
  return new;
end;
$$;


ALTER FUNCTION private.handle_new_user() OWNER TO postgres;

--
-- TOC entry 1095 (class 1255 OID 31813)
-- Name: handle_new_user_roles(); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.handle_new_user_roles() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
  roles uuid[];
  role uuid;
begin
  roles := coalesce((select array_agg(elem)::uuid[] from jsonb_array_elements_text(NEW.raw_user_meta_data->'roles') elem), '{}');
  foreach role in array roles
  loop
    insert into public.user_roles(user_id, role_id)
    values (NEW.id, role);
  end loop;
  return NEW;
end;
$$;


ALTER FUNCTION private.handle_new_user_roles() OWNER TO postgres;

--
-- TOC entry 1356 (class 1255 OID 31814)
-- Name: handle_profile_deletion(); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.handle_profile_deletion() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $$
begin
  delete from auth.users where id = old.id;
  return old;
end;
$$;


ALTER FUNCTION private.handle_profile_deletion() OWNER TO postgres;

--
-- TOC entry 995 (class 1255 OID 31815)
-- Name: set_updated_at(); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


ALTER FUNCTION private.set_updated_at() OWNER TO postgres;

--
-- TOC entry 1093 (class 1255 OID 31816)
-- Name: sync_profile_email(); Type: FUNCTION; Schema: private; Owner: postgres
--

CREATE FUNCTION private.sync_profile_email() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $$
begin
  if new.email is distinct from old.email then
  update auth.users set email = new.email where id = new.id;
  end if;
  return new;
end;
$$;


ALTER FUNCTION private.sync_profile_email() OWNER TO postgres;

--
-- TOC entry 634 (class 1255 OID 31817)
-- Name: custom_access_token_hook(jsonb); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.custom_access_token_hook(event jsonb) RETURNS jsonb
    LANGUAGE plpgsql STABLE
    AS $$
  declare
    claims jsonb;
    user_roles uuid[];
  begin
    -- Fetch the user role in the user_roles table
    select into user_roles ARRAY(select role_id from public.user_roles where user_id = (event->>'user_id')::uuid)::uuid[];

    claims := event->'claims';

    if user_roles is not null then
      -- Set the claim
      claims := jsonb_set(claims, '{user_roles}', to_jsonb(user_roles));
    else
      claims := jsonb_set(claims, '{user_roles}', 'null');
    end if;

    -- Update the 'claims' object in the original event
    event := jsonb_set(event, '{claims}', claims);

    -- Return the modified or original event
    return event;
  end;
$$;


ALTER FUNCTION public.custom_access_token_hook(event jsonb) OWNER TO postgres;

--
-- TOC entry 1264 (class 1255 OID 31818)
-- Name: get_position_dump_for_rp_js(text, bigint, timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone) RETURNS TABLE(id_device bigint, time_stamp timestamp with time zone, geom_geojson text, dumped_db text)
    LANGUAGE sql
    AS $$
    SELECT
        id_device,
        time AS time_stamp,
        point_gps AS geom_geojson,
        dumped_db
    FROM rtls_measurement.position_dump_geojson
    WHERE time BETWEEN p_time_start AND p_time_end
      AND dumped_db = p_dumped_db
      AND id_device = p_id_device
    ORDER BY time;
$$;


ALTER FUNCTION public.get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone) OWNER TO supabase_admin;

--
-- TOC entry 675 (class 1255 OID 31819)
-- Name: get_position_dump_for_rp_v2(integer, integer, timestamp with time zone, timestamp with time zone, bigint); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) RETURNS TABLE(id_device bigint, dumped_db text, time_stamp timestamp with time zone, geom text, id_setup integer, id_reference_point_measurement integer, id_reference_point integer)
    LANGUAGE sql
    AS $$
    SELECT
        pd.id_device,
        pd.dumped_db,
        pd.time AS time_stamp,
        pd.point_gps::TEXT AS geom,  -- geometry als Text
        rpm.id_setup,
        rpm.id_reference_point_measurement,
        rpm.id_reference_point
    FROM public.rtls_measurement_position_dump AS pd  -- View statt Originaltabelle
    INNER JOIN rtls_measurement.reference_point_measurement AS rpm
        ON pd.id_device = (
            SELECT id_uwb_device
            FROM rtls_measurement.device
            WHERE id_device = rpm.id_device
        )
    WHERE rpm.id_setup = p_setup_id
      AND rpm.id_reference_point = p_rp_id
      AND pd.id_device = p_id_device
      AND pd.time BETWEEN p_time_start AND p_time_end
    ORDER BY pd.time;
$$;


ALTER FUNCTION public.get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) OWNER TO supabase_admin;

--
-- TOC entry 1171 (class 1255 OID 31820)
-- Name: get_position_dump_for_rp_v3(integer, integer, timestamp with time zone, timestamp with time zone, bigint); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) RETURNS TABLE(id_device bigint, dumped_db text, time_stamp timestamp with time zone, geom text, id_setup integer)
    LANGUAGE sql
    AS $$
	    SELECT
	    pd.id_device,
	    pd.dumped_db,
	    pd.time AS time_stamp,
	    pd.point_gps::TEXT AS geom,  -- geometry als Text
	    rpm.id_setup
	FROM public.rtls_measurement_position_dump AS pd  -- View statt Originaltabelle
	INNER JOIN rtls_measurement.reference_point_measurement AS rpm
	    ON pd.id_device = (
	        SELECT id_uwb_device
	        FROM rtls_measurement.device
	        WHERE id_device = rpm.id_device
	    )
    WHERE rpm.id_setup = p_setup_id
      AND pd.id_device = p_id_device
      AND pd.time BETWEEN p_time_start AND p_time_end
    ORDER BY pd.time;
$$;


ALTER FUNCTION public.get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) OWNER TO supabase_admin;

--
-- TOC entry 666 (class 1255 OID 31821)
-- Name: get_position_dump_for_rp_v4(integer, integer, timestamp with time zone, timestamp with time zone, bigint); Type: FUNCTION; Schema: public; Owner: supabase_admin
--

CREATE FUNCTION public.get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) RETURNS TABLE(id_device bigint, dumped_db text, time_stamp timestamp with time zone, geom text, latitude double precision, longitude double precision, altitude double precision, id_setup integer)
    LANGUAGE sql STABLE
    AS $$
SELECT
    pd.id_device AS id_device,
    pd.dumped_db AS dumped_db,
    pd.time AS time_stamp,
    pd.point_gps::TEXT AS geom,
    extensions.ST_Y(pd.point_gps) AS latitude,
    extensions.ST_X(pd.point_gps) AS longitude,
    extensions.ST_Z(pd.point_gps) AS altitude,
    rpm.id_setup AS id_setup
FROM public.rtls_measurement_position_dump AS pd
INNER JOIN rtls_measurement.device AS d
    ON d.id_uwb_device = pd.id_device
INNER JOIN rtls_measurement.reference_point_measurement AS rpm
    ON rpm.id_device = d.id_device
   AND rpm.id_setup = p_setup_id
WHERE rpm.id_setup = p_setup_id
  AND pd.id_device = p_id_device
  AND pd.time BETWEEN p_time_start AND p_time_end
ORDER BY pd.time;
$$;


ALTER FUNCTION public.get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) OWNER TO supabase_admin;

--
-- TOC entry 982 (class 1255 OID 31822)
-- Name: get_frontend_last_position_tag(bigint); Type: FUNCTION; Schema: rtls_config; Owner: supabase_admin
--

CREATE FUNCTION rtls_config.get_frontend_last_position_tag(id_param bigint DEFAULT NULL::bigint) RETURNS TABLE(uwb_device_id bigint, pos_type rtls_timeseries.position_type, stationary boolean, longitude double precision, latitude double precision, altitude double precision, last_update text, estimated_location text)
    LANGUAGE plpgsql STABLE
    AS $$
begin
  return query
  select
    ud.uwb_device_id,
    p.pos_type,
    p.stationary,
    extensions.st_x(p.point_gps) AS longitude,
	extensions.st_y(p.point_gps) AS latitude,
    nullif(extensions.st_z(p.point_gps), '-Infinity'::double precision) as altitude,
    to_char(p."time", 'YYYY-MM-DD"T"HH24:MI:SS.MS') || to_char(p."time", 'TZH:TZM') as last_update,
    area.name as estimated_location
  from rtls_config.uwb_device ud
  join lateral (
    select
      p_1."time",
      p_1.pos_type,
      p_1.stationary,
      p_1.point_gps
    from rtls_timeseries."position" p_1
    where p_1.id_device = ud.id_device
      and p_1."time" >= (now() - interval '3 days')
      and p_1."time" < now()
    order by p_1."time" desc
    limit 1
  ) p on true
  join rtls_timeseries.position_area using (id_device, "time")
  join rtls_config.area using (id_area)
  where ud.type = 'tag'
    and ud.valid_till is null
    and (id_param is null or ud.uwb_device_id = id_param);
end;
$$;


ALTER FUNCTION rtls_config.get_frontend_last_position_tag(id_param bigint) OWNER TO supabase_admin;

--
-- TOC entry 1003 (class 1255 OID 31823)
-- Name: update_area_hierarchy_path(); Type: FUNCTION; Schema: rtls_config; Owner: supabase_admin
--

CREATE FUNCTION rtls_config.update_area_hierarchy_path() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    parent_path uuid[];
BEGIN
    IF NEW.parent_area_id IS NULL THEN
        NEW.hierarchy_path := ARRAY[NEW.id_area];
        NEW.hierarchy_level := 1;
    ELSE
        SELECT hierarchy_path, hierarchy_level + 1
        INTO parent_path, NEW.hierarchy_level
        FROM rtls_config.area
        WHERE id_area = NEW.parent_area_id;
        
        IF parent_path IS NULL THEN
            RAISE EXCEPTION 'Parent area not found';
        END IF;
        
        NEW.hierarchy_path := array_append(parent_path, NEW.id_area);
    END IF;
    
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION rtls_config.update_area_hierarchy_path() OWNER TO supabase_admin;

--
-- TOC entry 1261 (class 1255 OID 31824)
-- Name: get_devices_for_setup(uuid); Type: FUNCTION; Schema: rtls_measurement_2; Owner: supabase_admin
--

CREATE FUNCTION rtls_measurement_2.get_devices_for_setup(p_id_setup uuid) RETURNS TABLE(id_device uuid, device_name text, device_type text, comment text, created_at timestamp with time zone, id_uwb_device bigint, id_setup uuid, location text, distance numeric)
    LANGUAGE sql STABLE
    AS $$
  select * from (
  select *
  from rtls_measurement_2.device d
  where d.id_setup = p_id_setup

  union

  select
    gen_random_uuid() as id_device,
    ud.uwb_device_id::text as device_name,
    ud."type" as device_type,
    null as comment,
    now() as created_at,
    ud.uwb_device_id as id_uwb_device,
    p_id_setup as id_setup,
    null as location,
    null as distance
  from rtls_config.uwb_device ud
  where ud.valid_till is null
    and type = 'tag'
    and not exists (
      select 1
      from rtls_measurement_2.device mesdev
      where mesdev.id_uwb_device = ud.uwb_device_id
        and mesdev.id_setup = p_id_setup
    )
  ) sub
  order by device_name;
$$;


ALTER FUNCTION rtls_measurement_2.get_devices_for_setup(p_id_setup uuid) OWNER TO supabase_admin;

--
-- TOC entry 976 (class 1255 OID 31825)
-- Name: get_position_dump_for_rp_v5(uuid, uuid, timestamp with time zone, timestamp with time zone, integer); Type: FUNCTION; Schema: rtls_measurement_2; Owner: supabase_admin
--

CREATE FUNCTION rtls_measurement_2.get_position_dump_for_rp_v5(p_setup_id uuid, p_rp_id uuid, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_uwb_id_device integer) RETURNS TABLE(id_device uuid, time_stamp timestamp with time zone, geom text, latitude double precision, longitude double precision, altitude double precision, id_setup uuid)
    LANGUAGE sql STABLE
    AS $$
SELECT
    rpm.id_device AS id_device,
    pd.time AS time_stamp,
    pd.point_gps::TEXT AS geom,
    extensions.ST_Y(pd.point_gps) AS latitude,
    extensions.ST_X(pd.point_gps) AS longitude,
    extensions.ST_Z(pd.point_gps) AS altitude,
    rpm.id_setup AS id_setup
FROM rtls_measurement_2.position AS pd
JOIN rtls_measurement_2.reference_point_measurement rpm
     USING (id_reference_point_measurement)
JOIN rtls_measurement_2.device dev USING (id_device)
WHERE rpm.id_setup = p_setup_id
  AND dev.id_uwb_device = p_uwb_id_device
  AND rpm.id_reference_point = p_rp_id
  AND pd.time BETWEEN p_time_start AND p_time_end
ORDER BY pd.time;
$$;


ALTER FUNCTION rtls_measurement_2.get_position_dump_for_rp_v5(p_setup_id uuid, p_rp_id uuid, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_uwb_id_device integer) OWNER TO supabase_admin;

--
-- TOC entry 974 (class 1255 OID 31826)
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1388 (class 1255 OID 31827)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 640 (class 1255 OID 31828)
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 550 (class 1255 OID 31829)
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 765 (class 1255 OID 31830)
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- TOC entry 890 (class 1255 OID 31831)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 986 (class 1255 OID 31832)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 665 (class 1255 OID 31833)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 861 (class 1255 OID 31834)
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 544 (class 1255 OID 31835)
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1350 (class 1255 OID 31836)
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1148 (class 1255 OID 31837)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 1303 (class 1255 OID 31838)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1054 (class 1255 OID 31839)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1084 (class 1255 OID 31840)
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 689 (class 1255 OID 31841)
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 1242 (class 1255 OID 31842)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 871 (class 1255 OID 31843)
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 758 (class 1255 OID 31844)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1225 (class 1255 OID 31845)
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1133 (class 1255 OID 31846)
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 1168 (class 1255 OID 31847)
-- Name: search_v2(text, text, integer, integer, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
BEGIN
    RETURN query EXECUTE
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name || '/' AS name,
                    NULL::uuid AS id,
                    NULL::timestamptz AS updated_at,
                    NULL::timestamptz AS created_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
                ORDER BY prefixes.name COLLATE "C" LIMIT $3
            )
            UNION ALL
            (SELECT split_part(name, '/', $4) AS key,
                name,
                id,
                updated_at,
                created_at,
                metadata
            FROM storage.objects
            WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
            ORDER BY name COLLATE "C" LIMIT $3)
        ) obj
        ORDER BY name COLLATE "C" LIMIT $3;
        $sql$
        USING prefix, bucket_name, limits, levels, start_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 586 (class 1255 OID 31848)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- TOC entry 1383 (class 1255 OID 31849)
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
    DECLARE
      request_id bigint;
      payload jsonb;
      url text := TG_ARGV[0]::text;
      method text := TG_ARGV[1]::text;
      headers jsonb DEFAULT '{}'::jsonb;
      params jsonb DEFAULT '{}'::jsonb;
      timeout_ms integer DEFAULT 1000;
    BEGIN
      IF url IS NULL OR url = 'null' THEN
        RAISE EXCEPTION 'url argument is missing';
      END IF;

      IF method IS NULL OR method = 'null' THEN
        RAISE EXCEPTION 'method argument is missing';
      END IF;

      IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
        headers = '{"Content-Type": "application/json"}'::jsonb;
      ELSE
        headers = TG_ARGV[2]::jsonb;
      END IF;

      IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
        params = '{}'::jsonb;
      ELSE
        params = TG_ARGV[3]::jsonb;
      END IF;

      IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
        timeout_ms = 1000;
      ELSE
        timeout_ms = TG_ARGV[4]::integer;
      END IF;

      CASE
        WHEN method = 'GET' THEN
          SELECT http_get INTO request_id FROM net.http_get(
            url,
            params,
            headers,
            timeout_ms
          );
        WHEN method = 'POST' THEN
          payload = jsonb_build_object(
            'old_record', OLD,
            'record', NEW,
            'type', TG_OP,
            'table', TG_TABLE_NAME,
            'schema', TG_TABLE_SCHEMA
          );

          SELECT http_post INTO request_id FROM net.http_post(
            url,
            payload,
            params,
            headers,
            timeout_ms
          );
        ELSE
          RAISE EXCEPTION 'method argument % is invalid', method;
      END CASE;

      INSERT INTO supabase_functions.hooks
        (hook_table_id, hook_name, request_id)
      VALUES
        (TG_RELID, TG_NAME, request_id);

      RETURN NEW;
    END
  $$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

--
-- TOC entry 4120 (class 2328 OID 31850)
-- Name: redis_wrapper; Type: FOREIGN DATA WRAPPER; Schema: -; Owner: supabase_admin
--

CREATE FOREIGN DATA WRAPPER redis_wrapper HANDLER extensions.redis_fdw_handler VALIDATOR extensions.redis_fdw_validator;


ALTER FOREIGN DATA WRAPPER redis_wrapper OWNER TO supabase_admin;

--
-- TOC entry 4121 (class 1417 OID 31851)
-- Name: rtls_redis_server; Type: SERVER; Schema: -; Owner: postgres
--

CREATE SERVER rtls_redis_server FOREIGN DATA WRAPPER redis_wrapper OPTIONS (
    conn_url 'redis://rtls-controller-redis:6379/'
);


ALTER SERVER rtls_redis_server OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 271 (class 1259 OID 31852)
-- Name: alert_queries; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.alert_queries (
    id bigint NOT NULL,
    name character varying(255),
    token uuid,
    query text,
    description text,
    language character varying(255),
    cron character varying(255),
    source_mapping jsonb,
    slack_hook_url character varying(255),
    webhook_notification_url character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.alert_queries OWNER TO supabase_admin;

--
-- TOC entry 272 (class 1259 OID 31857)
-- Name: alert_queries_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.alert_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.alert_queries_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7830 (class 0 OID 0)
-- Dependencies: 272
-- Name: alert_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.alert_queries_id_seq OWNED BY _analytics.alert_queries.id;


--
-- TOC entry 273 (class 1259 OID 31858)
-- Name: backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.backends (
    id bigint NOT NULL,
    name character varying(255),
    description text,
    user_id bigint,
    type character varying(255),
    config jsonb,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    token uuid NOT NULL,
    metadata jsonb,
    config_encrypted bytea
);


ALTER TABLE _analytics.backends OWNER TO supabase_admin;

--
-- TOC entry 274 (class 1259 OID 31863)
-- Name: backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.backends_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7831 (class 0 OID 0)
-- Dependencies: 274
-- Name: backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.backends_id_seq OWNED BY _analytics.backends.id;


--
-- TOC entry 275 (class 1259 OID 31864)
-- Name: billing_accounts; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.billing_accounts (
    id bigint NOT NULL,
    latest_successful_stripe_session jsonb,
    stripe_customer character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    stripe_subscriptions jsonb,
    stripe_invoices jsonb,
    "lifetime_plan?" boolean DEFAULT false,
    lifetime_plan_invoice character varying(255),
    default_payment_method character varying(255),
    custom_invoice_fields jsonb[] DEFAULT ARRAY[]::jsonb[],
    lifetime_plan boolean DEFAULT false NOT NULL
);


ALTER TABLE _analytics.billing_accounts OWNER TO supabase_admin;

--
-- TOC entry 276 (class 1259 OID 31872)
-- Name: billing_accounts_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.billing_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.billing_accounts_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7832 (class 0 OID 0)
-- Dependencies: 276
-- Name: billing_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.billing_accounts_id_seq OWNED BY _analytics.billing_accounts.id;


--
-- TOC entry 277 (class 1259 OID 31873)
-- Name: billing_counts; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.billing_counts (
    id bigint NOT NULL,
    node character varying(255),
    count integer,
    user_id bigint,
    source_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.billing_counts OWNER TO supabase_admin;

--
-- TOC entry 278 (class 1259 OID 31876)
-- Name: billing_counts_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.billing_counts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.billing_counts_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7833 (class 0 OID 0)
-- Dependencies: 278
-- Name: billing_counts_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.billing_counts_id_seq OWNED BY _analytics.billing_counts.id;


--
-- TOC entry 279 (class 1259 OID 31877)
-- Name: endpoint_queries; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.endpoint_queries (
    id bigint NOT NULL,
    name character varying(255),
    token uuid,
    query text,
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    source_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    sandboxable boolean DEFAULT false,
    cache_duration_seconds integer DEFAULT 3600,
    proactive_requerying_seconds integer DEFAULT 1800,
    max_limit integer DEFAULT 1000,
    enable_auth boolean DEFAULT false,
    language character varying(255) NOT NULL,
    description character varying(255),
    sandbox_query_id bigint
);


ALTER TABLE _analytics.endpoint_queries OWNER TO supabase_admin;

--
-- TOC entry 280 (class 1259 OID 31888)
-- Name: endpoint_queries_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.endpoint_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.endpoint_queries_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7834 (class 0 OID 0)
-- Dependencies: 280
-- Name: endpoint_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.endpoint_queries_id_seq OWNED BY _analytics.endpoint_queries.id;


--
-- TOC entry 281 (class 1259 OID 31889)
-- Name: log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5 OWNER TO supabase_admin;

--
-- TOC entry 282 (class 1259 OID 31894)
-- Name: log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e OWNER TO supabase_admin;

--
-- TOC entry 283 (class 1259 OID 31899)
-- Name: log_events_28d2ec64_d503_46e0_b858_c62a2a9de000; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_28d2ec64_d503_46e0_b858_c62a2a9de000 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_28d2ec64_d503_46e0_b858_c62a2a9de000 OWNER TO supabase_admin;

--
-- TOC entry 284 (class 1259 OID 31904)
-- Name: log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492 OWNER TO supabase_admin;

--
-- TOC entry 285 (class 1259 OID 31909)
-- Name: log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb OWNER TO supabase_admin;

--
-- TOC entry 286 (class 1259 OID 31914)
-- Name: log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72 OWNER TO supabase_admin;

--
-- TOC entry 287 (class 1259 OID 31919)
-- Name: log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9 OWNER TO supabase_admin;

--
-- TOC entry 288 (class 1259 OID 31924)
-- Name: log_events_f2cf0b56_836d_420d_84c0_639871495297; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_f2cf0b56_836d_420d_84c0_639871495297 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_f2cf0b56_836d_420d_84c0_639871495297 OWNER TO supabase_admin;

--
-- TOC entry 289 (class 1259 OID 31929)
-- Name: log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27 OWNER TO supabase_admin;

--
-- TOC entry 290 (class 1259 OID 31934)
-- Name: oauth_access_grants; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.oauth_access_grants (
    id bigint NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id bigint,
    token character varying(255) NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    revoked_at timestamp(0) without time zone,
    scopes character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.oauth_access_grants OWNER TO supabase_admin;

--
-- TOC entry 291 (class 1259 OID 31939)
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.oauth_access_grants_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7835 (class 0 OID 0)
-- Dependencies: 291
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.oauth_access_grants_id_seq OWNED BY _analytics.oauth_access_grants.id;


--
-- TOC entry 292 (class 1259 OID 31940)
-- Name: oauth_access_tokens; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.oauth_access_tokens (
    id bigint NOT NULL,
    application_id bigint,
    resource_owner_id integer,
    token character varying(255) NOT NULL,
    refresh_token character varying(255),
    expires_in integer,
    revoked_at timestamp(0) without time zone,
    scopes character varying(255),
    previous_refresh_token character varying(255) DEFAULT ''::character varying NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    description text
);


ALTER TABLE _analytics.oauth_access_tokens OWNER TO supabase_admin;

--
-- TOC entry 293 (class 1259 OID 31946)
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.oauth_access_tokens_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7836 (class 0 OID 0)
-- Dependencies: 293
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.oauth_access_tokens_id_seq OWNED BY _analytics.oauth_access_tokens.id;


--
-- TOC entry 294 (class 1259 OID 31947)
-- Name: oauth_applications; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.oauth_applications (
    id bigint NOT NULL,
    owner_id integer NOT NULL,
    name character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    secret character varying(255) DEFAULT ''::character varying NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    scopes character varying(255) DEFAULT ''::character varying NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.oauth_applications OWNER TO supabase_admin;

--
-- TOC entry 295 (class 1259 OID 31954)
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.oauth_applications_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7837 (class 0 OID 0)
-- Dependencies: 295
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.oauth_applications_id_seq OWNED BY _analytics.oauth_applications.id;


--
-- TOC entry 296 (class 1259 OID 31955)
-- Name: partner_users; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.partner_users (
    id bigint NOT NULL,
    partner_id bigint,
    user_id bigint,
    upgraded boolean DEFAULT false NOT NULL
);


ALTER TABLE _analytics.partner_users OWNER TO supabase_admin;

--
-- TOC entry 297 (class 1259 OID 31959)
-- Name: partner_users_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.partner_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.partner_users_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7838 (class 0 OID 0)
-- Dependencies: 297
-- Name: partner_users_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.partner_users_id_seq OWNED BY _analytics.partner_users.id;


--
-- TOC entry 298 (class 1259 OID 31960)
-- Name: partners; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.partners (
    id bigint NOT NULL,
    name bytea,
    token bytea
);


ALTER TABLE _analytics.partners OWNER TO supabase_admin;

--
-- TOC entry 299 (class 1259 OID 31965)
-- Name: partners_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.partners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.partners_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7839 (class 0 OID 0)
-- Dependencies: 299
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.partners_id_seq OWNED BY _analytics.partners.id;


--
-- TOC entry 300 (class 1259 OID 31966)
-- Name: payment_methods; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.payment_methods (
    id bigint NOT NULL,
    stripe_id character varying(255),
    price_id character varying(255),
    last_four character varying(255),
    brand character varying(255),
    exp_year integer,
    exp_month integer,
    customer_id character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.payment_methods OWNER TO supabase_admin;

--
-- TOC entry 301 (class 1259 OID 31971)
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.payment_methods_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7840 (class 0 OID 0)
-- Dependencies: 301
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.payment_methods_id_seq OWNED BY _analytics.payment_methods.id;


--
-- TOC entry 302 (class 1259 OID 31972)
-- Name: plans; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.plans (
    id bigint NOT NULL,
    name character varying(255),
    stripe_id character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    period character varying(255),
    price integer,
    limit_sources integer,
    limit_rate_limit integer,
    limit_alert_freq integer,
    limit_source_rate_limit integer,
    limit_saved_search_limit integer,
    limit_team_users_limit integer,
    limit_source_fields_limit integer,
    limit_source_ttl bigint DEFAULT 259200000,
    type character varying(255) DEFAULT 'standard'::character varying
);


ALTER TABLE _analytics.plans OWNER TO supabase_admin;

--
-- TOC entry 303 (class 1259 OID 31979)
-- Name: plans_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.plans_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7841 (class 0 OID 0)
-- Dependencies: 303
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.plans_id_seq OWNED BY _analytics.plans.id;


--
-- TOC entry 304 (class 1259 OID 31980)
-- Name: rules; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.rules (
    id bigint NOT NULL,
    regex character varying(255),
    sink uuid,
    source_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    regex_struct bytea,
    lql_string text DEFAULT ''::text NOT NULL,
    lql_filters bytea DEFAULT '\x836a'::bytea NOT NULL,
    backend_id bigint,
    token uuid DEFAULT gen_random_uuid()
);

ALTER TABLE ONLY _analytics.rules REPLICA IDENTITY FULL;


ALTER TABLE _analytics.rules OWNER TO supabase_admin;

--
-- TOC entry 305 (class 1259 OID 31988)
-- Name: rules_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.rules_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7842 (class 0 OID 0)
-- Dependencies: 305
-- Name: rules_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.rules_id_seq OWNED BY _analytics.rules.id;


--
-- TOC entry 306 (class 1259 OID 31989)
-- Name: saved_search_counters; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.saved_search_counters (
    id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    saved_search_id bigint NOT NULL,
    granularity text DEFAULT 'day'::text NOT NULL,
    non_tailing_count integer,
    tailing_count integer
);


ALTER TABLE _analytics.saved_search_counters OWNER TO supabase_admin;

--
-- TOC entry 307 (class 1259 OID 31995)
-- Name: saved_search_counters_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.saved_search_counters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.saved_search_counters_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7843 (class 0 OID 0)
-- Dependencies: 307
-- Name: saved_search_counters_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.saved_search_counters_id_seq OWNED BY _analytics.saved_search_counters.id;


--
-- TOC entry 308 (class 1259 OID 31996)
-- Name: saved_searches; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.saved_searches (
    id bigint NOT NULL,
    querystring text,
    source_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    saved_by_user boolean,
    lql_filters jsonb,
    lql_charts jsonb,
    "tailing?" boolean DEFAULT true NOT NULL,
    tailing boolean DEFAULT true NOT NULL
);


ALTER TABLE _analytics.saved_searches OWNER TO supabase_admin;

--
-- TOC entry 309 (class 1259 OID 32003)
-- Name: saved_searches_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.saved_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.saved_searches_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7844 (class 0 OID 0)
-- Dependencies: 309
-- Name: saved_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.saved_searches_id_seq OWNED BY _analytics.saved_searches.id;


--
-- TOC entry 310 (class 1259 OID 32004)
-- Name: schema_migrations; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _analytics.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 311 (class 1259 OID 32007)
-- Name: source_backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.source_backends (
    id bigint NOT NULL,
    source_id bigint,
    type character varying(255),
    config jsonb,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.source_backends OWNER TO supabase_admin;

--
-- TOC entry 312 (class 1259 OID 32012)
-- Name: source_backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.source_backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.source_backends_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7845 (class 0 OID 0)
-- Dependencies: 312
-- Name: source_backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.source_backends_id_seq OWNED BY _analytics.source_backends.id;


--
-- TOC entry 313 (class 1259 OID 32013)
-- Name: source_schemas; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.source_schemas (
    id bigint NOT NULL,
    bigquery_schema bytea,
    source_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    schema_flat_map bytea
);


ALTER TABLE _analytics.source_schemas OWNER TO supabase_admin;

--
-- TOC entry 314 (class 1259 OID 32018)
-- Name: source_schemas_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.source_schemas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.source_schemas_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7846 (class 0 OID 0)
-- Dependencies: 314
-- Name: source_schemas_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.source_schemas_id_seq OWNED BY _analytics.source_schemas.id;


--
-- TOC entry 315 (class 1259 OID 32019)
-- Name: sources; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.sources (
    id bigint NOT NULL,
    name character varying(255),
    token uuid NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    user_id integer NOT NULL,
    public_token character varying(255),
    favorite boolean DEFAULT false NOT NULL,
    bigquery_table_ttl integer,
    api_quota integer DEFAULT 5 NOT NULL,
    webhook_notification_url character varying(255),
    slack_hook_url character varying(255),
    notifications jsonb DEFAULT '{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}'::jsonb NOT NULL,
    custom_event_message_keys character varying(255),
    log_events_updated_at timestamp(0) without time zone,
    bigquery_schema bytea,
    notifications_every integer DEFAULT 14400000,
    bq_table_partition_type text,
    lock_schema boolean DEFAULT false,
    validate_schema boolean DEFAULT true,
    drop_lql_filters bytea DEFAULT '\x836a'::bytea NOT NULL,
    drop_lql_string character varying(255),
    v2_pipeline boolean DEFAULT false,
    suggested_keys character varying(255) DEFAULT ''::character varying,
    service_name character varying(255),
    transform_copy_fields character varying(255),
    disable_tailing boolean DEFAULT false
);

ALTER TABLE ONLY _analytics.sources REPLICA IDENTITY FULL;


ALTER TABLE _analytics.sources OWNER TO supabase_admin;

--
-- TOC entry 316 (class 1259 OID 32034)
-- Name: sources_backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.sources_backends (
    id bigint NOT NULL,
    backend_id bigint,
    source_id bigint
);


ALTER TABLE _analytics.sources_backends OWNER TO supabase_admin;

--
-- TOC entry 317 (class 1259 OID 32037)
-- Name: sources_backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.sources_backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.sources_backends_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7847 (class 0 OID 0)
-- Dependencies: 317
-- Name: sources_backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.sources_backends_id_seq OWNED BY _analytics.sources_backends.id;


--
-- TOC entry 318 (class 1259 OID 32038)
-- Name: sources_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.sources_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7848 (class 0 OID 0)
-- Dependencies: 318
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.sources_id_seq OWNED BY _analytics.sources.id;


--
-- TOC entry 319 (class 1259 OID 32039)
-- Name: system_metrics; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.system_metrics (
    id bigint NOT NULL,
    all_logs_logged bigint,
    node character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.system_metrics OWNER TO supabase_admin;

--
-- TOC entry 320 (class 1259 OID 32042)
-- Name: system_metrics_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.system_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.system_metrics_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7849 (class 0 OID 0)
-- Dependencies: 320
-- Name: system_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.system_metrics_id_seq OWNED BY _analytics.system_metrics.id;


--
-- TOC entry 321 (class 1259 OID 32043)
-- Name: team_users; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.team_users (
    id bigint NOT NULL,
    email character varying(255),
    token character varying(255),
    provider character varying(255),
    email_preferred character varying(255),
    name character varying(255),
    image character varying(255),
    email_me_product boolean DEFAULT false NOT NULL,
    phone character varying(255),
    valid_google_account boolean DEFAULT false NOT NULL,
    provider_uid character varying(255),
    team_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    preferences jsonb
);


ALTER TABLE _analytics.team_users OWNER TO supabase_admin;

--
-- TOC entry 322 (class 1259 OID 32050)
-- Name: team_users_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.team_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.team_users_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7850 (class 0 OID 0)
-- Dependencies: 322
-- Name: team_users_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.team_users_id_seq OWNED BY _analytics.team_users.id;


--
-- TOC entry 323 (class 1259 OID 32051)
-- Name: teams; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.teams (
    id bigint NOT NULL,
    name character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    token character varying(255) DEFAULT gen_random_uuid()
);


ALTER TABLE _analytics.teams OWNER TO supabase_admin;

--
-- TOC entry 324 (class 1259 OID 32057)
-- Name: teams_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.teams_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7851 (class 0 OID 0)
-- Dependencies: 324
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.teams_id_seq OWNED BY _analytics.teams.id;


--
-- TOC entry 325 (class 1259 OID 32058)
-- Name: users; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.users (
    id bigint NOT NULL,
    email character varying(255),
    provider character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    api_key character varying(255) NOT NULL,
    old_api_key character varying(255),
    email_preferred character varying(255),
    name character varying(255),
    image character varying(255),
    email_me_product boolean DEFAULT true NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    phone character varying(255),
    bigquery_project_id character varying(255),
    api_quota integer DEFAULT 125 NOT NULL,
    bigquery_dataset_location character varying(255),
    bigquery_dataset_id character varying(255),
    valid_google_account boolean,
    provider_uid character varying(255),
    company character varying(255),
    bigquery_udfs_hash character varying(255) DEFAULT ''::character varying NOT NULL,
    bigquery_processed_bytes_limit bigint DEFAULT '10000000000'::bigint NOT NULL,
    "billing_enabled?" boolean DEFAULT false NOT NULL,
    preferences jsonb,
    billing_enabled boolean DEFAULT false NOT NULL,
    endpoints_beta boolean DEFAULT false,
    metadata jsonb,
    partner_upgraded boolean DEFAULT false,
    partner_id bigint
);


ALTER TABLE _analytics.users OWNER TO supabase_admin;

--
-- TOC entry 326 (class 1259 OID 32072)
-- Name: users_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.users_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7852 (class 0 OID 0)
-- Dependencies: 326
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.users_id_seq OWNED BY _analytics.users.id;


--
-- TOC entry 327 (class 1259 OID 32073)
-- Name: vercel_auths; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.vercel_auths (
    id bigint NOT NULL,
    access_token character varying(255),
    installation_id character varying(255),
    team_id character varying(255),
    token_type character varying(255),
    vercel_user_id character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.vercel_auths OWNER TO supabase_admin;

--
-- TOC entry 328 (class 1259 OID 32078)
-- Name: vercel_auths_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.vercel_auths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.vercel_auths_id_seq OWNER TO supabase_admin;

--
-- TOC entry 7853 (class 0 OID 0)
-- Dependencies: 328
-- Name: vercel_auths_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.vercel_auths_id_seq OWNED BY _analytics.vercel_auths.id;


--
-- TOC entry 329 (class 1259 OID 32079)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 7854 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 330 (class 1259 OID 32088)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 7856 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 331 (class 1259 OID 32099)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 7858 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 7859 (class 0 OID 0)
-- Dependencies: 331
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 332 (class 1259 OID 32106)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 7861 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 333 (class 1259 OID 32111)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 7863 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 334 (class 1259 OID 32116)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 7865 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 335 (class 1259 OID 32121)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 7867 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 336 (class 1259 OID 32126)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 337 (class 1259 OID 32134)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 7870 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 338 (class 1259 OID 32139)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 7872 (class 0 OID 0)
-- Dependencies: 338
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 339 (class 1259 OID 32140)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 7874 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 340 (class 1259 OID 32148)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 7876 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 341 (class 1259 OID 32154)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 7878 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 342 (class 1259 OID 32157)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 7880 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 7881 (class 0 OID 0)
-- Dependencies: 342
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 343 (class 1259 OID 32162)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 7883 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 344 (class 1259 OID 32168)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 7885 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 7886 (class 0 OID 0)
-- Dependencies: 344
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 345 (class 1259 OID 32174)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 7888 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 7889 (class 0 OID 0)
-- Dependencies: 345
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 346 (class 1259 OID 32189)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    firstname text NOT NULL,
    lastname text DEFAULT ''::text NOT NULL,
    email text NOT NULL,
    language public.elanguage DEFAULT 'en'::public.elanguage NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    avatar text
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- TOC entry 7894 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.profiles IS 'User profile information linked to authentication accounts';


--
-- TOC entry 7895 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.id IS 'Primary key and foreign key to auth.users';


--
-- TOC entry 7896 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.firstname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.firstname IS 'User''s first name';


--
-- TOC entry 7897 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.lastname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.lastname IS 'User''s last name, defaults to empty string';


--
-- TOC entry 7898 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.email IS 'User''s email address';


--
-- TOC entry 7899 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.language IS 'User''s preferred language (en or de)';


--
-- TOC entry 7900 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.created_at IS 'Timestamp when the profile was created';


--
-- TOC entry 7901 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.updated_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.updated_at IS 'Timestamp when the profile was last updated';


--
-- TOC entry 7902 (class 0 OID 0)
-- Dependencies: 346
-- Name: COLUMN profiles.avatar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.avatar IS 'URL of the user''s avatar image inside the avatars storage bucket';


--
-- TOC entry 347 (class 1259 OID 32198)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text,
    ordering integer DEFAULT 0 NOT NULL,
    permissions public.epermission[] DEFAULT ARRAY[]::public.epermission[] NOT NULL,
    superadmin boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT roles_ordering_check CHECK ((ordering >= 0))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 7904 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.roles IS 'Roles available in the application.';


--
-- TOC entry 7905 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.id IS 'Primary key for the role';


--
-- TOC entry 7906 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.name IS 'Name of the role';


--
-- TOC entry 7907 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.description IS 'Description of the role';


--
-- TOC entry 7908 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.ordering; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.ordering IS 'Ordering of the role, used for sorting';


--
-- TOC entry 7909 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.permissions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.permissions IS 'Array of permissions associated with the role';


--
-- TOC entry 7910 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.superadmin; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.superadmin IS 'Indicates if the role is a superadmin and automatically got all permissions available';


--
-- TOC entry 7911 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.created_at IS 'Timestamp when the role was created';


--
-- TOC entry 7912 (class 0 OID 0)
-- Dependencies: 347
-- Name: COLUMN roles.updated_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.roles.updated_at IS 'Timestamp when the role was last updated';


--
-- TOC entry 348 (class 1259 OID 32210)
-- Name: device; Type: TABLE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE TABLE rtls_measurement.device (
    id_device integer NOT NULL,
    device_name text NOT NULL,
    device_type text,
    comment text,
    created_at timestamp without time zone DEFAULT now(),
    id_uwb_device integer,
    id_setup integer,
    location text,
    distance real
);


ALTER TABLE rtls_measurement.device OWNER TO supabase_admin;

--
-- TOC entry 349 (class 1259 OID 32216)
-- Name: rtls_measurement_device; Type: VIEW; Schema: public; Owner: supabase_admin
--

CREATE VIEW public.rtls_measurement_device AS
 SELECT id_device,
    device_name,
    device_type,
    comment,
    created_at,
    id_uwb_device,
    id_setup,
    location,
    distance
   FROM rtls_measurement.device;


ALTER VIEW public.rtls_measurement_device OWNER TO supabase_admin;

--
-- TOC entry 350 (class 1259 OID 32220)
-- Name: position_dump; Type: TABLE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE TABLE rtls_measurement.position_dump (
    "time" timestamp without time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type text NOT NULL,
    quality integer NOT NULL,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    dumped_db text
);


ALTER TABLE rtls_measurement.position_dump OWNER TO supabase_admin;

--
-- TOC entry 351 (class 1259 OID 32225)
-- Name: rtls_measurement_position_dump; Type: VIEW; Schema: public; Owner: supabase_admin
--

CREATE VIEW public.rtls_measurement_position_dump AS
 SELECT "time",
    id_device,
    stationary,
    pos_type,
    quality,
    point_gps,
    point_xyz,
    probably_moved,
    dumped_db
   FROM rtls_measurement.position_dump;


ALTER VIEW public.rtls_measurement_position_dump OWNER TO supabase_admin;

--
-- TOC entry 352 (class 1259 OID 32229)
-- Name: reference_point; Type: TABLE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE TABLE rtls_measurement.reference_point (
    id_reference_point integer NOT NULL,
    setup_id integer,
    name text NOT NULL,
    latitude numeric(9,6),
    longitude numeric(9,6),
    altitude numeric,
    geom extensions.geometry(PointZ,4326),
    comment text
);


ALTER TABLE rtls_measurement.reference_point OWNER TO supabase_admin;

--
-- TOC entry 353 (class 1259 OID 32234)
-- Name: rtls_measurement_reference_point; Type: VIEW; Schema: public; Owner: supabase_admin
--

CREATE VIEW public.rtls_measurement_reference_point AS
 SELECT id_reference_point,
    setup_id,
    name,
    latitude,
    longitude,
    altitude,
    geom,
    comment
   FROM rtls_measurement.reference_point;


ALTER VIEW public.rtls_measurement_reference_point OWNER TO supabase_admin;

--
-- TOC entry 354 (class 1259 OID 32238)
-- Name: reference_point_measurement; Type: TABLE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE TABLE rtls_measurement.reference_point_measurement (
    id_reference_point_measurement integer NOT NULL,
    id_device integer NOT NULL,
    id_reference_point integer NOT NULL,
    id_setup integer NOT NULL,
    time_start timestamp with time zone,
    time_end timestamp with time zone,
    duration integer,
    repetition_count integer DEFAULT 0,
    status_preparation text,
    status_measurement text,
    status_quality text,
    status_repetition text,
    id_reference_point_01 integer,
    id_reference_point_02 integer,
    calc_point boolean,
    calc_line boolean,
    mindeltax numeric,
    maxdeltax numeric,
    meandeltax numeric,
    stddeltax numeric,
    mindeltax_m numeric,
    maxdeltax_m numeric,
    meandeltax_m numeric,
    stddeltax_m numeric,
    mindeltay numeric,
    maxdeltay numeric,
    meandeltay numeric,
    stddeltay numeric,
    mindeltay_m numeric,
    maxdeltay_m numeric,
    meandeltay_m numeric,
    stddeltay_m numeric,
    mindeltaz numeric,
    maxdeltaz numeric,
    meandeltaz numeric,
    stddeltaz numeric,
    mindeltaz_m numeric,
    maxdeltaz_m numeric,
    meandeltaz_m numeric,
    stddeltaz_m numeric,
    mindistance numeric,
    maxdistance numeric,
    meandistance numeric,
    sigma2distance numeric,
    sigma2vector numeric,
    CONSTRAINT reference_point_measurement_status_measurement_check CHECK ((status_measurement = ANY (ARRAY['prepend'::text, 'measuring'::text, 'done'::text]))),
    CONSTRAINT reference_point_measurement_status_preparation_check CHECK ((status_preparation = ANY (ARRAY['prepend'::text, 'measuring'::text, 'done'::text]))),
    CONSTRAINT reference_point_measurement_status_quality_check CHECK ((status_quality = ANY (ARRAY['accept'::text, 'notaccept'::text]))),
    CONSTRAINT reference_point_measurement_status_repetition_check CHECK ((status_repetition = ANY (ARRAY['first'::text, 'repeat'::text])))
);


ALTER TABLE rtls_measurement.reference_point_measurement OWNER TO supabase_admin;

--
-- TOC entry 355 (class 1259 OID 32248)
-- Name: rtls_measurement_reference_point_measurement; Type: VIEW; Schema: public; Owner: supabase_admin
--

CREATE VIEW public.rtls_measurement_reference_point_measurement AS
 SELECT id_reference_point_measurement,
    id_device,
    id_reference_point,
    id_setup,
    time_start,
    time_end,
    duration,
    repetition_count,
    status_preparation,
    status_measurement,
    status_quality,
    status_repetition,
    id_reference_point_01,
    id_reference_point_02,
    calc_point,
    calc_line,
    mindeltax,
    maxdeltax,
    meandeltax,
    stddeltax,
    mindeltax_m,
    maxdeltax_m,
    meandeltax_m,
    stddeltax_m,
    mindeltay,
    maxdeltay,
    meandeltay,
    stddeltay,
    mindeltay_m,
    maxdeltay_m,
    meandeltay_m,
    stddeltay_m,
    mindeltaz,
    maxdeltaz,
    meandeltaz,
    stddeltaz,
    mindeltaz_m,
    maxdeltaz_m,
    meandeltaz_m,
    stddeltaz_m,
    mindistance,
    maxdistance,
    meandistance,
    sigma2distance,
    sigma2vector
   FROM rtls_measurement.reference_point_measurement;


ALTER VIEW public.rtls_measurement_reference_point_measurement OWNER TO supabase_admin;

--
-- TOC entry 356 (class 1259 OID 32253)
-- Name: setup; Type: TABLE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE TABLE rtls_measurement.setup (
    id_setup integer NOT NULL,
    setupname text NOT NULL,
    comment text,
    create_day timestamp without time zone DEFAULT now(),
    count_refpints integer,
    source_position text,
    source_db text,
    dumped_db text,
    count_refpoints integer,
    CONSTRAINT setup_source_position_check CHECK ((source_position = ANY (ARRAY['position_live'::text, 'position_dump'::text, 'position_demo'::text])))
);


ALTER TABLE rtls_measurement.setup OWNER TO supabase_admin;

--
-- TOC entry 357 (class 1259 OID 32260)
-- Name: rtls_measurement_setup; Type: VIEW; Schema: public; Owner: supabase_admin
--

CREATE VIEW public.rtls_measurement_setup AS
 SELECT id_setup,
    setupname,
    comment,
    create_day,
    count_refpints,
    source_position,
    source_db
   FROM rtls_measurement.setup;


ALTER VIEW public.rtls_measurement_setup OWNER TO supabase_admin;

--
-- TOC entry 358 (class 1259 OID 32264)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id uuid NOT NULL,
    role_id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 7924 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE user_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.user_roles IS 'Application roles for each user.';


--
-- TOC entry 7925 (class 0 OID 0)
-- Dependencies: 358
-- Name: COLUMN user_roles.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_roles.user_id IS 'User ID from the profiles table';


--
-- TOC entry 7926 (class 0 OID 0)
-- Dependencies: 358
-- Name: COLUMN user_roles.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_roles.role_id IS 'Role ID from the roles table';


--
-- TOC entry 7927 (class 0 OID 0)
-- Dependencies: 358
-- Name: COLUMN user_roles.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_roles.created_at IS 'Timestamp when the user role was created';


--
-- TOC entry 359 (class 1259 OID 32268)
-- Name: user_permissions; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_permissions WITH (security_invoker='true') AS
 SELECT p.id AS user_id,
    p.email,
    COALESCE(array_agg(DISTINCT perm.perm) FILTER (WHERE (perm.perm IS NOT NULL)), ARRAY[]::public.epermission[]) AS permissions,
    COALESCE(bool_or(r.superadmin), false) AS is_superadmin,
    private.get_user_min_role_ordering(p.id) AS min_role_ordering
   FROM (((public.profiles p
     LEFT JOIN public.user_roles ur ON ((p.id = ur.user_id)))
     LEFT JOIN public.roles r ON ((ur.role_id = r.id)))
     LEFT JOIN LATERAL unnest(r.permissions) perm(perm) ON (true))
  GROUP BY p.id, p.email;


ALTER VIEW public.user_permissions OWNER TO postgres;

--
-- TOC entry 7929 (class 0 OID 0)
-- Dependencies: 359
-- Name: VIEW user_permissions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.user_permissions IS 'Aggregated permissions for each user based on their assigned roles, including minimum role ordering for privilege restrictions';


--
-- TOC entry 360 (class 1259 OID 32273)
-- Name: alarm_events; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.alarm_events (
    id_alarm bigint NOT NULL,
    id_asset bigint NOT NULL,
    id_area uuid,
    alarm_type rtls_config.permission_type,
    geom extensions.geometry(Point,4326),
    triggered_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    resolved_at timestamp with time zone
);


ALTER TABLE rtls_config.alarm_events OWNER TO supabase_admin;

--
-- TOC entry 361 (class 1259 OID 32279)
-- Name: alarm_events_id_alarm_seq; Type: SEQUENCE; Schema: rtls_config; Owner: supabase_admin
--

CREATE SEQUENCE rtls_config.alarm_events_id_alarm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_config.alarm_events_id_alarm_seq OWNER TO supabase_admin;

--
-- TOC entry 7932 (class 0 OID 0)
-- Dependencies: 361
-- Name: alarm_events_id_alarm_seq; Type: SEQUENCE OWNED BY; Schema: rtls_config; Owner: supabase_admin
--

ALTER SEQUENCE rtls_config.alarm_events_id_alarm_seq OWNED BY rtls_config.alarm_events.id_alarm;


--
-- TOC entry 362 (class 1259 OID 32280)
-- Name: area; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.area (
    id_area uuid NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text,
    parent_area_id uuid,
    area_type rtls_config.area_type NOT NULL,
    hierarchy_level integer DEFAULT 1 NOT NULL,
    hierarchy_path uuid[],
    geom extensions.geometry(Polygon,4326) NOT NULL,
    alt_min double precision,
    alt_max double precision,
    color text DEFAULT ''::text,
    created_at timestamp with time zone,
    created_by uuid,
    updated_at timestamp with time zone,
    updated_by uuid,
    CONSTRAINT area_level_consistency CHECK ((((parent_area_id IS NULL) AND (hierarchy_level = 1)) OR ((parent_area_id IS NOT NULL) AND (hierarchy_level > 1)))),
    CONSTRAINT area_no_self_reference CHECK ((id_area <> parent_area_id))
);


ALTER TABLE rtls_config.area OWNER TO supabase_admin;

--
-- TOC entry 7934 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.name; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.name IS 'Name of the area';


--
-- TOC entry 7935 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.description; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.description IS 'Detailed description of the area';


--
-- TOC entry 7936 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.geom; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.geom IS 'Polygon geometry representing the area (latitude and longitude coordinates)';


--
-- TOC entry 7937 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.alt_min; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.alt_min IS 'Minimum altitude value within the area';


--
-- TOC entry 7938 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.alt_max; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.alt_max IS 'Maximum altitude value within the area';


--
-- TOC entry 7939 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.color; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.color IS 'Optional color value (e.g., "#FF0000")';


--
-- TOC entry 7940 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.created_at; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.created_at IS 'Timestamp of creation';


--
-- TOC entry 7941 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.created_by; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.created_by IS 'User ID who created the area';


--
-- TOC entry 7942 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.updated_at; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.updated_at IS 'Timestamp of last modification';


--
-- TOC entry 7943 (class 0 OID 0)
-- Dependencies: 362
-- Name: COLUMN area.updated_by; Type: COMMENT; Schema: rtls_config; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_config.area.updated_by IS 'User ID who last updated the area';


--
-- TOC entry 363 (class 1259 OID 32290)
-- Name: area_permission; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.area_permission (
    id_area uuid NOT NULL,
    id_asset integer NOT NULL,
    permission rtls_config.permission_type NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    created_by uuid,
    updated_at timestamp with time zone,
    updated_by uuid
);


ALTER TABLE rtls_config.area_permission OWNER TO supabase_admin;

--
-- TOC entry 364 (class 1259 OID 32294)
-- Name: asset; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.asset (
    id_asset bigint NOT NULL,
    name_en text,
    name_de text,
    external_erp_id text,
    id_asset_type bigint NOT NULL,
    description text
);


ALTER TABLE rtls_config.asset OWNER TO supabase_admin;

--
-- TOC entry 365 (class 1259 OID 32299)
-- Name: asset_id_asset_seq; Type: SEQUENCE; Schema: rtls_config; Owner: supabase_admin
--

CREATE SEQUENCE rtls_config.asset_id_asset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_config.asset_id_asset_seq OWNER TO supabase_admin;

--
-- TOC entry 7947 (class 0 OID 0)
-- Dependencies: 365
-- Name: asset_id_asset_seq; Type: SEQUENCE OWNED BY; Schema: rtls_config; Owner: supabase_admin
--

ALTER SEQUENCE rtls_config.asset_id_asset_seq OWNED BY rtls_config.asset.id_asset;


--
-- TOC entry 366 (class 1259 OID 32300)
-- Name: asset_type; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.asset_type (
    id_asset_type bigint NOT NULL,
    name_en text,
    name_de text
);


ALTER TABLE rtls_config.asset_type OWNER TO supabase_admin;

--
-- TOC entry 367 (class 1259 OID 32305)
-- Name: asset_type_id_asset_type_seq; Type: SEQUENCE; Schema: rtls_config; Owner: supabase_admin
--

CREATE SEQUENCE rtls_config.asset_type_id_asset_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_config.asset_type_id_asset_type_seq OWNER TO supabase_admin;

--
-- TOC entry 7950 (class 0 OID 0)
-- Dependencies: 367
-- Name: asset_type_id_asset_type_seq; Type: SEQUENCE OWNED BY; Schema: rtls_config; Owner: supabase_admin
--

ALTER SEQUENCE rtls_config.asset_type_id_asset_type_seq OWNED BY rtls_config.asset_type.id_asset_type;


--
-- TOC entry 368 (class 1259 OID 32306)
-- Name: flyway_schema_history; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE rtls_config.flyway_schema_history OWNER TO supabase_admin;

--
-- TOC entry 369 (class 1259 OID 32312)
-- Name: frontend_last_position_tag; Type: VIEW; Schema: rtls_config; Owner: supabase_admin
--

CREATE VIEW rtls_config.frontend_last_position_tag AS
 SELECT uwb_device_id,
    pos_type,
    stationary,
    longitude,
    latitude,
    altitude,
    last_update,
    estimated_location
   FROM rtls_config.get_frontend_last_position_tag() get_frontend_last_position_tag(uwb_device_id, pos_type, stationary, longitude, latitude, altitude, last_update, estimated_location);


ALTER VIEW rtls_config.frontend_last_position_tag OWNER TO supabase_admin;

--
-- TOC entry 370 (class 1259 OID 32316)
-- Name: frontend_raster_layers; Type: MATERIALIZED VIEW; Schema: rtls_config; Owner: supabase_admin
--

CREATE MATERIALIZED VIEW rtls_config.frontend_raster_layers AS
 WITH areas AS (
         SELECT a_1.id_area,
            a_1.name,
            a_1.description,
            a_1.area_type,
            a_1.hierarchy_level,
            a_1.geom,
            array_to_string(a_1.hierarchy_path, '/'::text) AS hierarchy_path,
            ( SELECT string_agg(a_2.name, ', '::text ORDER BY a_2.hierarchy_level) AS string_agg
                   FROM (unnest(a_1.hierarchy_path) h(id)
                     JOIN rtls_config.area a_2 ON ((h.id = a_2.id_area)))) AS hierarchy_name
           FROM rtls_config.area a_1
          WHERE (a_1.area_type = ANY (ARRAY['site'::rtls_config.area_type, 'compound'::rtls_config.area_type, 'hall'::rtls_config.area_type, 'raster'::rtls_config.area_type]))
        )
 SELECT area_type,
    json_build_object('type', 'FeatureCollection', 'features', json_agg((extensions.st_asgeojson(a.*))::json)) AS layer
   FROM areas a
  GROUP BY area_type
  WITH NO DATA;


ALTER MATERIALIZED VIEW rtls_config.frontend_raster_layers OWNER TO supabase_admin;

--
-- TOC entry 371 (class 1259 OID 32323)
-- Name: gateway; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.gateway (
    id_gateway bigint NOT NULL,
    gateway_name text
);


ALTER TABLE rtls_config.gateway OWNER TO supabase_admin;

--
-- TOC entry 372 (class 1259 OID 32328)
-- Name: gateway_id_gateway_seq; Type: SEQUENCE; Schema: rtls_config; Owner: supabase_admin
--

CREATE SEQUENCE rtls_config.gateway_id_gateway_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_config.gateway_id_gateway_seq OWNER TO supabase_admin;

--
-- TOC entry 7955 (class 0 OID 0)
-- Dependencies: 372
-- Name: gateway_id_gateway_seq; Type: SEQUENCE OWNED BY; Schema: rtls_config; Owner: supabase_admin
--

ALTER SEQUENCE rtls_config.gateway_id_gateway_seq OWNED BY rtls_config.gateway.id_gateway;


--
-- TOC entry 373 (class 1259 OID 32329)
-- Name: map_image; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.map_image (
    id_map_image uuid NOT NULL,
    name text,
    description text,
    location text,
    bounding_box extensions.geometry(Polygon,4326),
    keep_ratio boolean,
    opacity numeric,
    z_index integer,
    altitude double precision,
    color text,
    file_uri text,
    file_name text,
    file_size integer,
    file_content_type text,
    image_width integer,
    image_height integer,
    created_at timestamp with time zone,
    created_by uuid,
    updated_at timestamp with time zone,
    updated_by uuid
);


ALTER TABLE rtls_config.map_image OWNER TO supabase_admin;

--
-- TOC entry 374 (class 1259 OID 32334)
-- Name: uwb_device; Type: TABLE; Schema: rtls_config; Owner: supabase_admin
--

CREATE TABLE rtls_config.uwb_device (
    id_device bigint NOT NULL,
    uwb_device_id bigint,
    id_asset bigint DEFAULT 0 NOT NULL,
    type text NOT NULL,
    board_name text NOT NULL,
    sw_version text NOT NULL,
    uwbmac_version text NOT NULL,
    eui_64 bigint NOT NULL,
    config jsonb NOT NULL,
    cfg_loc_engine text,
    cfg_update_rate_ms integer,
    cfg_pos_gps extensions.geometry(PointZ,4326),
    cfg_pos_xyz extensions.geometry(PointZ),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    valid_till timestamp with time zone,
    transmitted_at timestamp with time zone,
    desired_cfg_pos_gps extensions.geometry(PointZ,4326)
);


ALTER TABLE rtls_config.uwb_device OWNER TO supabase_admin;

--
-- TOC entry 375 (class 1259 OID 32341)
-- Name: uwb_device_id_device_seq; Type: SEQUENCE; Schema: rtls_config; Owner: supabase_admin
--

CREATE SEQUENCE rtls_config.uwb_device_id_device_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_config.uwb_device_id_device_seq OWNER TO supabase_admin;

--
-- TOC entry 7958 (class 0 OID 0)
-- Dependencies: 375
-- Name: uwb_device_id_device_seq; Type: SEQUENCE OWNED BY; Schema: rtls_config; Owner: supabase_admin
--

ALTER SEQUENCE rtls_config.uwb_device_id_device_seq OWNED BY rtls_config.uwb_device.id_device;


--
-- TOC entry 376 (class 1259 OID 32342)
-- Name: device_id_device_seq; Type: SEQUENCE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement.device_id_device_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement.device_id_device_seq OWNER TO supabase_admin;

--
-- TOC entry 7960 (class 0 OID 0)
-- Dependencies: 376
-- Name: device_id_device_seq; Type: SEQUENCE OWNED BY; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER SEQUENCE rtls_measurement.device_id_device_seq OWNED BY rtls_measurement.device.id_device;


--
-- TOC entry 377 (class 1259 OID 32343)
-- Name: position; Type: TABLE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE TABLE rtls_measurement."position" (
    id bigint NOT NULL,
    point_gps extensions.geometry,
    lat numeric,
    long numeric,
    alt numeric,
    "time" timestamp with time zone,
    uwb_device_id integer,
    id_device_1 integer,
    id_device_2 integer,
    client text DEFAULT ''::text,
    id_setup integer
);


ALTER TABLE rtls_measurement."position" OWNER TO supabase_admin;

--
-- TOC entry 378 (class 1259 OID 32349)
-- Name: position_dump_geojson; Type: VIEW; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE VIEW rtls_measurement.position_dump_geojson AS
 SELECT id_device,
    dumped_db,
    "time",
    extensions.st_asgeojson(extensions.st_makepoint(extensions.st_x(point_gps), extensions.st_y(point_gps),
        CASE
            WHEN ((extensions.st_z(point_gps) IS NULL) OR (extensions.st_z(point_gps) = 'Infinity'::double precision) OR (extensions.st_z(point_gps) = '-Infinity'::double precision) OR (extensions.st_z(point_gps) <> extensions.st_z(point_gps))) THEN (0)::double precision
            ELSE extensions.st_z(point_gps)
        END)) AS point_gps
   FROM rtls_measurement.position_dump;


ALTER VIEW rtls_measurement.position_dump_geojson OWNER TO supabase_admin;

--
-- TOC entry 379 (class 1259 OID 32353)
-- Name: reference_point_id_reference_point_seq; Type: SEQUENCE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement.reference_point_id_reference_point_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement.reference_point_id_reference_point_seq OWNER TO supabase_admin;

--
-- TOC entry 7963 (class 0 OID 0)
-- Dependencies: 379
-- Name: reference_point_id_reference_point_seq; Type: SEQUENCE OWNED BY; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER SEQUENCE rtls_measurement.reference_point_id_reference_point_seq OWNED BY rtls_measurement.reference_point.id_reference_point;


--
-- TOC entry 380 (class 1259 OID 32354)
-- Name: reference_point_measurement_id_reference_point_measurement_seq; Type: SEQUENCE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq OWNER TO supabase_admin;

--
-- TOC entry 7965 (class 0 OID 0)
-- Dependencies: 380
-- Name: reference_point_measurement_id_reference_point_measurement_seq; Type: SEQUENCE OWNED BY; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER SEQUENCE rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq OWNED BY rtls_measurement.reference_point_measurement.id_reference_point_measurement;


--
-- TOC entry 381 (class 1259 OID 32355)
-- Name: setup_id_setup_seq; Type: SEQUENCE; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement.setup_id_setup_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement.setup_id_setup_seq OWNER TO supabase_admin;

--
-- TOC entry 7967 (class 0 OID 0)
-- Dependencies: 381
-- Name: setup_id_setup_seq; Type: SEQUENCE OWNED BY; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER SEQUENCE rtls_measurement.setup_id_setup_seq OWNED BY rtls_measurement.setup.id_setup;


--
-- TOC entry 382 (class 1259 OID 32356)
-- Name: device; Type: TABLE; Schema: rtls_measurement_2; Owner: postgres
--

CREATE TABLE rtls_measurement_2.device (
    id_device uuid DEFAULT gen_random_uuid() NOT NULL,
    device_name text NOT NULL,
    device_type text,
    comment text,
    created_at timestamp without time zone DEFAULT now(),
    id_uwb_device integer,
    id_setup uuid,
    location text,
    distance real
);


ALTER TABLE rtls_measurement_2.device OWNER TO postgres;

--
-- TOC entry 383 (class 1259 OID 32363)
-- Name: position; Type: TABLE; Schema: rtls_measurement_2; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_2."position" (
    id_device uuid NOT NULL,
    "time" timestamp with time zone NOT NULL,
    point_gps extensions.geometry,
    lat numeric,
    long numeric,
    alt numeric,
    client text DEFAULT ''::text
);


ALTER TABLE rtls_measurement_2."position" OWNER TO supabase_admin;

--
-- TOC entry 384 (class 1259 OID 32369)
-- Name: reference_point; Type: TABLE; Schema: rtls_measurement_2; Owner: postgres
--

CREATE TABLE rtls_measurement_2.reference_point (
    id_reference_point uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    latitude numeric(9,6),
    longitude numeric(9,6),
    altitude numeric,
    geom extensions.geometry(PointZ,4326),
    comment text
);


ALTER TABLE rtls_measurement_2.reference_point OWNER TO postgres;

--
-- TOC entry 385 (class 1259 OID 32375)
-- Name: reference_point_measurement; Type: TABLE; Schema: rtls_measurement_2; Owner: postgres
--

CREATE TABLE rtls_measurement_2.reference_point_measurement (
    id_reference_point_measurement uuid DEFAULT gen_random_uuid() NOT NULL,
    id_device uuid NOT NULL,
    id_reference_point uuid NOT NULL,
    id_setup uuid NOT NULL,
    time_start timestamp with time zone,
    time_end timestamp with time zone,
    duration integer,
    repetition_count integer DEFAULT 0,
    status_preparation text,
    status_measurement text,
    status_quality text,
    status_repetition text,
    id_reference_point_01 uuid,
    id_reference_point_02 uuid,
    calc_point boolean,
    calc_line boolean,
    mindeltax numeric,
    maxdeltax numeric,
    meandeltax numeric,
    stddeltax numeric,
    mindeltax_m numeric,
    maxdeltax_m numeric,
    meandeltax_m numeric,
    stddeltax_m numeric,
    mindeltay numeric,
    maxdeltay numeric,
    meandeltay numeric,
    stddeltay numeric,
    mindeltay_m numeric,
    maxdeltay_m numeric,
    meandeltay_m numeric,
    stddeltay_m numeric,
    mindeltaz numeric,
    maxdeltaz numeric,
    meandeltaz numeric,
    stddeltaz numeric,
    mindeltaz_m numeric,
    maxdeltaz_m numeric,
    meandeltaz_m numeric,
    stddeltaz_m numeric,
    mindistance numeric,
    maxdistance numeric,
    meandistance numeric,
    sigma2distance numeric,
    sigma2vector numeric,
    frontend_corrections jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT reference_point_measurement_status_measurement_check CHECK ((status_measurement = ANY (ARRAY['prepend'::text, 'measuring'::text, 'done'::text]))),
    CONSTRAINT reference_point_measurement_status_preparation_check CHECK ((status_preparation = ANY (ARRAY['prepend'::text, 'measuring'::text, 'done'::text]))),
    CONSTRAINT reference_point_measurement_status_quality_check CHECK ((status_quality = ANY (ARRAY['accept'::text, 'notaccept'::text]))),
    CONSTRAINT reference_point_measurement_status_repetition_check CHECK ((status_repetition = ANY (ARRAY['first'::text, 'repeat'::text])))
);


ALTER TABLE rtls_measurement_2.reference_point_measurement OWNER TO postgres;

--
-- TOC entry 386 (class 1259 OID 32387)
-- Name: setup; Type: TABLE; Schema: rtls_measurement_2; Owner: postgres
--

CREATE TABLE rtls_measurement_2.setup (
    id_setup uuid DEFAULT gen_random_uuid() NOT NULL,
    setupname text NOT NULL,
    comment text,
    create_day timestamp without time zone DEFAULT now(),
    source_position text,
    source_db text,
    dumped_db text,
    count_refpoints integer,
    CONSTRAINT setup_source_position_check CHECK ((source_position = ANY (ARRAY['position_live'::text, 'position_dump'::text, 'position_demo'::text])))
);


ALTER TABLE rtls_measurement_2.setup OWNER TO postgres;

--
-- TOC entry 387 (class 1259 OID 32395)
-- Name: setup_reference_point; Type: TABLE; Schema: rtls_measurement_2; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_2.setup_reference_point (
    id_setup uuid NOT NULL,
    id_reference_point uuid NOT NULL
);


ALTER TABLE rtls_measurement_2.setup_reference_point OWNER TO supabase_admin;

--
-- TOC entry 388 (class 1259 OID 32398)
-- Name: batch_job_execution; Type: TABLE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_etl.batch_job_execution (
    job_execution_id bigint NOT NULL,
    version bigint,
    job_instance_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE rtls_measurement_etl.batch_job_execution OWNER TO supabase_admin;

--
-- TOC entry 389 (class 1259 OID 32403)
-- Name: batch_job_execution_context; Type: TABLE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_etl.batch_job_execution_context (
    job_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE rtls_measurement_etl.batch_job_execution_context OWNER TO supabase_admin;

--
-- TOC entry 390 (class 1259 OID 32408)
-- Name: batch_job_execution_params; Type: TABLE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_etl.batch_job_execution_params (
    job_execution_id bigint NOT NULL,
    parameter_name character varying(100) NOT NULL,
    parameter_type character varying(100) NOT NULL,
    parameter_value character varying(2500),
    identifying character(1) NOT NULL
);


ALTER TABLE rtls_measurement_etl.batch_job_execution_params OWNER TO supabase_admin;

--
-- TOC entry 391 (class 1259 OID 32413)
-- Name: batch_job_execution_seq; Type: SEQUENCE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement_etl.batch_job_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement_etl.batch_job_execution_seq OWNER TO supabase_admin;

--
-- TOC entry 392 (class 1259 OID 32414)
-- Name: batch_job_instance; Type: TABLE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_etl.batch_job_instance (
    job_instance_id bigint NOT NULL,
    version bigint,
    job_name character varying(100) NOT NULL,
    job_key character varying(32) NOT NULL
);


ALTER TABLE rtls_measurement_etl.batch_job_instance OWNER TO supabase_admin;

--
-- TOC entry 393 (class 1259 OID 32417)
-- Name: batch_job_seq; Type: SEQUENCE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement_etl.batch_job_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement_etl.batch_job_seq OWNER TO supabase_admin;

--
-- TOC entry 394 (class 1259 OID 32418)
-- Name: batch_step_execution; Type: TABLE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_etl.batch_step_execution (
    step_execution_id bigint NOT NULL,
    version bigint NOT NULL,
    step_name character varying(100) NOT NULL,
    job_execution_id bigint NOT NULL,
    create_time timestamp without time zone NOT NULL,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    status character varying(10),
    commit_count bigint,
    read_count bigint,
    filter_count bigint,
    write_count bigint,
    read_skip_count bigint,
    write_skip_count bigint,
    process_skip_count bigint,
    rollback_count bigint,
    exit_code character varying(2500),
    exit_message character varying(2500),
    last_updated timestamp without time zone
);


ALTER TABLE rtls_measurement_etl.batch_step_execution OWNER TO supabase_admin;

--
-- TOC entry 395 (class 1259 OID 32423)
-- Name: batch_step_execution_context; Type: TABLE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE TABLE rtls_measurement_etl.batch_step_execution_context (
    step_execution_id bigint NOT NULL,
    short_context character varying(2500) NOT NULL,
    serialized_context text
);


ALTER TABLE rtls_measurement_etl.batch_step_execution_context OWNER TO supabase_admin;

--
-- TOC entry 396 (class 1259 OID 32428)
-- Name: batch_step_execution_seq; Type: SEQUENCE; Schema: rtls_measurement_etl; Owner: supabase_admin
--

CREATE SEQUENCE rtls_measurement_etl.batch_step_execution_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_measurement_etl.batch_step_execution_seq OWNER TO supabase_admin;

--
-- TOC entry 397 (class 1259 OID 32429)
-- Name: uwb_device; Type: FOREIGN TABLE; Schema: rtls_redis; Owner: postgres
--

CREATE FOREIGN TABLE rtls_redis.uwb_device (
    key text,
    items jsonb
)
SERVER rtls_redis_server
OPTIONS (
    src_key 'uwb:device:*',
    src_type 'multi_hash'
);


ALTER FOREIGN TABLE rtls_redis.uwb_device OWNER TO postgres;

--
-- TOC entry 398 (class 1259 OID 32432)
-- Name: device_status; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
)
PARTITION BY RANGE ("time");


ALTER TABLE rtls_timeseries.device_status OWNER TO supabase_admin;

--
-- TOC entry 7975 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN device_status.battery_is_charging; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.device_status.battery_is_charging IS 'Battery charging status';


--
-- TOC entry 7976 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN device_status.battery_level_mv; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.device_status.battery_level_mv IS 'Battery voltage in millivolts';


--
-- TOC entry 7977 (class 0 OID 0)
-- Dependencies: 398
-- Name: COLUMN device_status.battery_temperature_degc; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.device_status.battery_temperature_degc IS 'Temperature in degrees Celsius';


--
-- TOC entry 399 (class 1259 OID 32435)
-- Name: device_status_2026_01_19; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_01_19 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_01_19 OWNER TO supabase_admin;

--
-- TOC entry 400 (class 1259 OID 32438)
-- Name: device_status_2026_01_26; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_01_26 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_01_26 OWNER TO supabase_admin;

--
-- TOC entry 401 (class 1259 OID 32441)
-- Name: device_status_2026_02_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_02_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_02_02 OWNER TO supabase_admin;

--
-- TOC entry 402 (class 1259 OID 32444)
-- Name: device_status_2026_02_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_02_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_02_09 OWNER TO supabase_admin;

--
-- TOC entry 403 (class 1259 OID 32447)
-- Name: device_status_2026_02_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_02_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_02_16 OWNER TO supabase_admin;

--
-- TOC entry 404 (class 1259 OID 32450)
-- Name: device_status_2026_02_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_02_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_02_23 OWNER TO supabase_admin;

--
-- TOC entry 405 (class 1259 OID 32453)
-- Name: device_status_2026_03_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_03_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_03_02 OWNER TO supabase_admin;

--
-- TOC entry 406 (class 1259 OID 32456)
-- Name: device_status_2026_03_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_03_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_03_09 OWNER TO supabase_admin;

--
-- TOC entry 407 (class 1259 OID 32459)
-- Name: device_status_2026_03_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_03_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_03_16 OWNER TO supabase_admin;

--
-- TOC entry 408 (class 1259 OID 32462)
-- Name: device_status_2026_03_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_03_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_03_23 OWNER TO supabase_admin;

--
-- TOC entry 409 (class 1259 OID 32465)
-- Name: device_status_2026_03_30; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_03_30 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_03_30 OWNER TO supabase_admin;

--
-- TOC entry 410 (class 1259 OID 32468)
-- Name: device_status_2026_04_06; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_04_06 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_04_06 OWNER TO supabase_admin;

--
-- TOC entry 411 (class 1259 OID 32471)
-- Name: device_status_2026_04_13; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_04_13 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_04_13 OWNER TO supabase_admin;

--
-- TOC entry 412 (class 1259 OID 32474)
-- Name: device_status_2026_04_20; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_04_20 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_04_20 OWNER TO supabase_admin;

--
-- TOC entry 413 (class 1259 OID 32477)
-- Name: device_status_2026_04_27; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_04_27 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 511 (class 1259 OID 36084)
-- Name: device_status_2026_05_04; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_05_04 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_05_04 OWNER TO supabase_admin;

--
-- TOC entry 517 (class 1259 OID 36594)
-- Name: device_status_2026_05_11; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_05_11 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_05_11 OWNER TO supabase_admin;

--
-- TOC entry 523 (class 1259 OID 37061)
-- Name: device_status_2026_05_18; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_05_18 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_05_18 OWNER TO supabase_admin;

--
-- TOC entry 529 (class 1259 OID 37720)
-- Name: device_status_2026_05_25; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_05_25 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_05_25 OWNER TO supabase_admin;

--
-- TOC entry 535 (class 1259 OID 38184)
-- Name: device_status_2026_06_01; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.device_status_2026_06_01 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    battery_is_charging boolean NOT NULL,
    battery_level_mv integer NOT NULL,
    battery_temperature_degc integer NOT NULL,
    pressure_sensor_status boolean NOT NULL,
    pressure_sensor_is_calibrated boolean NOT NULL
);


ALTER TABLE rtls_timeseries.device_status_2026_06_01 OWNER TO supabase_admin;

--
-- TOC entry 414 (class 1259 OID 32480)
-- Name: gateway_info; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
)
PARTITION BY RANGE ("time");


ALTER TABLE rtls_timeseries.gateway_info OWNER TO supabase_admin;

--
-- TOC entry 415 (class 1259 OID 32483)
-- Name: gateway_info_2026_01_19; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_01_19 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_01_19 OWNER TO supabase_admin;

--
-- TOC entry 416 (class 1259 OID 32488)
-- Name: gateway_info_2026_01_26; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_01_26 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_01_26 OWNER TO supabase_admin;

--
-- TOC entry 417 (class 1259 OID 32493)
-- Name: gateway_info_2026_02_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_02_02 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_02_02 OWNER TO supabase_admin;

--
-- TOC entry 418 (class 1259 OID 32498)
-- Name: gateway_info_2026_02_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_02_09 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_02_09 OWNER TO supabase_admin;

--
-- TOC entry 419 (class 1259 OID 32503)
-- Name: gateway_info_2026_02_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_02_16 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_02_16 OWNER TO supabase_admin;

--
-- TOC entry 420 (class 1259 OID 32508)
-- Name: gateway_info_2026_02_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_02_23 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_02_23 OWNER TO supabase_admin;

--
-- TOC entry 421 (class 1259 OID 32513)
-- Name: gateway_info_2026_03_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_03_02 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_03_02 OWNER TO supabase_admin;

--
-- TOC entry 422 (class 1259 OID 32518)
-- Name: gateway_info_2026_03_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_03_09 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_03_09 OWNER TO supabase_admin;

--
-- TOC entry 423 (class 1259 OID 32523)
-- Name: gateway_info_2026_03_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_03_16 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_03_16 OWNER TO supabase_admin;

--
-- TOC entry 424 (class 1259 OID 32528)
-- Name: gateway_info_2026_03_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_03_23 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_03_23 OWNER TO supabase_admin;

--
-- TOC entry 425 (class 1259 OID 32533)
-- Name: gateway_info_2026_03_30; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_03_30 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_03_30 OWNER TO supabase_admin;

--
-- TOC entry 426 (class 1259 OID 32538)
-- Name: gateway_info_2026_04_06; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_04_06 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_04_06 OWNER TO supabase_admin;

--
-- TOC entry 427 (class 1259 OID 32543)
-- Name: gateway_info_2026_04_13; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_04_13 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_04_13 OWNER TO supabase_admin;

--
-- TOC entry 428 (class 1259 OID 32548)
-- Name: gateway_info_2026_04_20; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_04_20 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_04_20 OWNER TO supabase_admin;

--
-- TOC entry 429 (class 1259 OID 32553)
-- Name: gateway_info_2026_04_27; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_04_27 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 514 (class 1259 OID 36122)
-- Name: gateway_info_2026_05_04; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_05_04 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_05_04 OWNER TO supabase_admin;

--
-- TOC entry 520 (class 1259 OID 36632)
-- Name: gateway_info_2026_05_11; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_05_11 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_05_11 OWNER TO supabase_admin;

--
-- TOC entry 526 (class 1259 OID 37099)
-- Name: gateway_info_2026_05_18; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_05_18 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_05_18 OWNER TO supabase_admin;

--
-- TOC entry 532 (class 1259 OID 37758)
-- Name: gateway_info_2026_05_25; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_05_25 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_05_25 OWNER TO supabase_admin;

--
-- TOC entry 538 (class 1259 OID 38222)
-- Name: gateway_info_2026_06_01; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.gateway_info_2026_06_01 (
    "time" timestamp with time zone NOT NULL,
    id_gateway bigint NOT NULL,
    info jsonb NOT NULL
);


ALTER TABLE rtls_timeseries.gateway_info_2026_06_01 OWNER TO supabase_admin;

--
-- TOC entry 430 (class 1259 OID 32558)
-- Name: position; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries."position" (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
)
PARTITION BY RANGE ("time");


ALTER TABLE rtls_timeseries."position" OWNER TO supabase_admin;

--
-- TOC entry 7978 (class 0 OID 0)
-- Dependencies: 430
-- Name: COLUMN "position".stationary; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries."position".stationary IS 'Is the device currently stationary?';


--
-- TOC entry 7979 (class 0 OID 0)
-- Dependencies: 430
-- Name: COLUMN "position".pos_type; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries."position".pos_type IS 'GPS or XYZ';


--
-- TOC entry 7980 (class 0 OID 0)
-- Dependencies: 430
-- Name: COLUMN "position".quality; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries."position".quality IS 'quality factor or parameter of positioning (0-100%)';


--
-- TOC entry 7981 (class 0 OID 0)
-- Dependencies: 430
-- Name: COLUMN "position".point_gps; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries."position".point_gps IS 'SRID 4326 for type GPS.';


--
-- TOC entry 7982 (class 0 OID 0)
-- Dependencies: 430
-- Name: COLUMN "position".point_xyz; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries."position".point_xyz IS 'SRID 0 for type XYZ.';


--
-- TOC entry 431 (class 1259 OID 32563)
-- Name: position_2026_01_19; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_01_19 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_01_19 OWNER TO supabase_admin;

--
-- TOC entry 432 (class 1259 OID 32570)
-- Name: position_2026_01_26; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_01_26 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_01_26 OWNER TO supabase_admin;

--
-- TOC entry 433 (class 1259 OID 32577)
-- Name: position_2026_02_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_02_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_02_02 OWNER TO supabase_admin;

--
-- TOC entry 434 (class 1259 OID 32584)
-- Name: position_2026_02_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_02_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_02_09 OWNER TO supabase_admin;

--
-- TOC entry 435 (class 1259 OID 32591)
-- Name: position_2026_02_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_02_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_02_16 OWNER TO supabase_admin;

--
-- TOC entry 436 (class 1259 OID 32598)
-- Name: position_2026_02_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_02_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_02_23 OWNER TO supabase_admin;

--
-- TOC entry 437 (class 1259 OID 32605)
-- Name: position_2026_03_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_03_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_03_02 OWNER TO supabase_admin;

--
-- TOC entry 438 (class 1259 OID 32612)
-- Name: position_2026_03_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_03_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_03_09 OWNER TO supabase_admin;

--
-- TOC entry 439 (class 1259 OID 32619)
-- Name: position_2026_03_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_03_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_03_16 OWNER TO supabase_admin;

--
-- TOC entry 440 (class 1259 OID 32626)
-- Name: position_2026_03_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_03_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_03_23 OWNER TO supabase_admin;

--
-- TOC entry 441 (class 1259 OID 32633)
-- Name: position_2026_03_30; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_03_30 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_03_30 OWNER TO supabase_admin;

--
-- TOC entry 442 (class 1259 OID 32640)
-- Name: position_2026_04_06; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_04_06 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_04_06 OWNER TO supabase_admin;

--
-- TOC entry 443 (class 1259 OID 32647)
-- Name: position_2026_04_13; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_04_13 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_04_13 OWNER TO supabase_admin;

--
-- TOC entry 444 (class 1259 OID 32654)
-- Name: position_2026_04_20; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_04_20 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_04_20 OWNER TO supabase_admin;

--
-- TOC entry 445 (class 1259 OID 32661)
-- Name: position_2026_04_27; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_04_27 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 512 (class 1259 OID 36092)
-- Name: position_2026_05_04; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_05_04 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_05_04 OWNER TO supabase_admin;

--
-- TOC entry 518 (class 1259 OID 36602)
-- Name: position_2026_05_11; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_05_11 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_05_11 OWNER TO supabase_admin;

--
-- TOC entry 524 (class 1259 OID 37069)
-- Name: position_2026_05_18; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_05_18 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_05_18 OWNER TO supabase_admin;

--
-- TOC entry 530 (class 1259 OID 37728)
-- Name: position_2026_05_25; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_05_25 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_05_25 OWNER TO supabase_admin;

--
-- TOC entry 536 (class 1259 OID 38192)
-- Name: position_2026_06_01; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_2026_06_01 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pos_type rtls_timeseries.position_type NOT NULL,
    quality integer,
    point_gps extensions.geometry(PointZ,4326),
    point_xyz extensions.geometry(PointZ),
    probably_moved boolean NOT NULL,
    pos_origin rtls_timeseries.position_origin DEFAULT 'ESTIMATED'::rtls_timeseries.position_origin,
    CONSTRAINT chk_point_presence CHECK (((point_gps IS NOT NULL) OR (point_xyz IS NOT NULL)))
);


ALTER TABLE rtls_timeseries.position_2026_06_01 OWNER TO supabase_admin;

--
-- TOC entry 446 (class 1259 OID 32668)
-- Name: position_area; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
)
PARTITION BY RANGE ("time");


ALTER TABLE rtls_timeseries.position_area OWNER TO supabase_admin;

--
-- TOC entry 447 (class 1259 OID 32671)
-- Name: position_area_2026_01_19; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_01_19 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_01_19 OWNER TO supabase_admin;

--
-- TOC entry 448 (class 1259 OID 32674)
-- Name: position_area_2026_01_26; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_01_26 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_01_26 OWNER TO supabase_admin;

--
-- TOC entry 449 (class 1259 OID 32677)
-- Name: position_area_2026_02_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_02_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_02_02 OWNER TO supabase_admin;

--
-- TOC entry 450 (class 1259 OID 32680)
-- Name: position_area_2026_02_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_02_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_02_09 OWNER TO supabase_admin;

--
-- TOC entry 451 (class 1259 OID 32683)
-- Name: position_area_2026_02_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_02_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_02_16 OWNER TO supabase_admin;

--
-- TOC entry 452 (class 1259 OID 32686)
-- Name: position_area_2026_02_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_02_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_02_23 OWNER TO supabase_admin;

--
-- TOC entry 453 (class 1259 OID 32689)
-- Name: position_area_2026_03_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_03_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_03_02 OWNER TO supabase_admin;

--
-- TOC entry 454 (class 1259 OID 32692)
-- Name: position_area_2026_03_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_03_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_03_09 OWNER TO supabase_admin;

--
-- TOC entry 455 (class 1259 OID 32695)
-- Name: position_area_2026_03_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_03_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_03_16 OWNER TO supabase_admin;

--
-- TOC entry 456 (class 1259 OID 32698)
-- Name: position_area_2026_03_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_03_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_03_23 OWNER TO supabase_admin;

--
-- TOC entry 457 (class 1259 OID 32701)
-- Name: position_area_2026_03_30; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_03_30 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_03_30 OWNER TO supabase_admin;

--
-- TOC entry 458 (class 1259 OID 32704)
-- Name: position_area_2026_04_06; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_04_06 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_04_06 OWNER TO supabase_admin;

--
-- TOC entry 459 (class 1259 OID 32707)
-- Name: position_area_2026_04_13; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_04_13 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_04_13 OWNER TO supabase_admin;

--
-- TOC entry 460 (class 1259 OID 32710)
-- Name: position_area_2026_04_20; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_04_20 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_04_20 OWNER TO supabase_admin;

--
-- TOC entry 461 (class 1259 OID 32713)
-- Name: position_area_2026_04_27; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_04_27 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 513 (class 1259 OID 36111)
-- Name: position_area_2026_05_04; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_05_04 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_05_04 OWNER TO supabase_admin;

--
-- TOC entry 519 (class 1259 OID 36621)
-- Name: position_area_2026_05_11; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_05_11 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_05_11 OWNER TO supabase_admin;

--
-- TOC entry 525 (class 1259 OID 37088)
-- Name: position_area_2026_05_18; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_05_18 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_05_18 OWNER TO supabase_admin;

--
-- TOC entry 531 (class 1259 OID 37747)
-- Name: position_area_2026_05_25; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_05_25 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_05_25 OWNER TO supabase_admin;

--
-- TOC entry 537 (class 1259 OID 38211)
-- Name: position_area_2026_06_01; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.position_area_2026_06_01 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    id_area uuid NOT NULL
);


ALTER TABLE rtls_timeseries.position_area_2026_06_01 OWNER TO supabase_admin;

--
-- TOC entry 462 (class 1259 OID 32716)
-- Name: position_dump_geojson; Type: VIEW; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE VIEW rtls_timeseries.position_dump_geojson AS
 SELECT id_device,
    "time",
    extensions.st_asgeojson(extensions.st_makepoint(extensions.st_x(point_gps), extensions.st_y(point_gps),
        CASE
            WHEN ((extensions.st_z(point_gps) IS NULL) OR (extensions.st_z(point_gps) = 'Infinity'::double precision) OR (extensions.st_z(point_gps) = '-Infinity'::double precision) OR (extensions.st_z(point_gps) <> extensions.st_z(point_gps))) THEN (0)::double precision
            ELSE extensions.st_z(point_gps)
        END)) AS point_gps
   FROM rtls_timeseries."position";


ALTER VIEW rtls_timeseries.position_dump_geojson OWNER TO supabase_admin;

--
-- TOC entry 463 (class 1259 OID 32720)
-- Name: ranging; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
)
PARTITION BY RANGE ("time");


ALTER TABLE rtls_timeseries.ranging OWNER TO supabase_admin;

--
-- TOC entry 7986 (class 0 OID 0)
-- Dependencies: 463
-- Name: COLUMN ranging.stationary; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging.stationary IS 'Is the device currently stationary?';


--
-- TOC entry 7987 (class 0 OID 0)
-- Dependencies: 463
-- Name: COLUMN ranging.pressure_pa; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging.pressure_pa IS 'air pressure [Pa] (if enabled and send by the device)';


--
-- TOC entry 7988 (class 0 OID 0)
-- Dependencies: 463
-- Name: COLUMN ranging.seq_number; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging.seq_number IS 'ranging sequence number (0-255) (if enabled and send by the device)';


--
-- TOC entry 7989 (class 0 OID 0)
-- Dependencies: 463
-- Name: COLUMN ranging.superframe_idx; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging.superframe_idx IS 'corresponding superframe idx (0-65535) (if enabled and send by the device)';


--
-- TOC entry 7990 (class 0 OID 0)
-- Dependencies: 463
-- Name: COLUMN ranging.uwb_network_timestamp; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging.uwb_network_timestamp IS 'uwb network timestamp in seconds (since begin of hyperframe) (if enabled and send by the device)';


--
-- TOC entry 464 (class 1259 OID 32723)
-- Name: ranging_2026_01_19; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_01_19 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_01_19 OWNER TO supabase_admin;

--
-- TOC entry 465 (class 1259 OID 32726)
-- Name: ranging_2026_01_26; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_01_26 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_01_26 OWNER TO supabase_admin;

--
-- TOC entry 466 (class 1259 OID 32729)
-- Name: ranging_2026_02_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_02_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_02_02 OWNER TO supabase_admin;

--
-- TOC entry 467 (class 1259 OID 32732)
-- Name: ranging_2026_02_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_02_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_02_09 OWNER TO supabase_admin;

--
-- TOC entry 468 (class 1259 OID 32735)
-- Name: ranging_2026_02_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_02_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_02_16 OWNER TO supabase_admin;

--
-- TOC entry 469 (class 1259 OID 32738)
-- Name: ranging_2026_02_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_02_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_02_23 OWNER TO supabase_admin;

--
-- TOC entry 470 (class 1259 OID 32741)
-- Name: ranging_2026_03_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_03_02 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_03_02 OWNER TO supabase_admin;

--
-- TOC entry 471 (class 1259 OID 32744)
-- Name: ranging_2026_03_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_03_09 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_03_09 OWNER TO supabase_admin;

--
-- TOC entry 472 (class 1259 OID 32747)
-- Name: ranging_2026_03_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_03_16 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_03_16 OWNER TO supabase_admin;

--
-- TOC entry 473 (class 1259 OID 32750)
-- Name: ranging_2026_03_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_03_23 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_03_23 OWNER TO supabase_admin;

--
-- TOC entry 474 (class 1259 OID 32753)
-- Name: ranging_2026_03_30; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_03_30 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_03_30 OWNER TO supabase_admin;

--
-- TOC entry 475 (class 1259 OID 32756)
-- Name: ranging_2026_04_06; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_04_06 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_04_06 OWNER TO supabase_admin;

--
-- TOC entry 476 (class 1259 OID 32759)
-- Name: ranging_2026_04_13; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_04_13 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_04_13 OWNER TO supabase_admin;

--
-- TOC entry 477 (class 1259 OID 32762)
-- Name: ranging_2026_04_20; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_04_20 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_04_20 OWNER TO supabase_admin;

--
-- TOC entry 478 (class 1259 OID 32765)
-- Name: ranging_2026_04_27; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_04_27 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 509 (class 1259 OID 36058)
-- Name: ranging_2026_05_04; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_05_04 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_05_04 OWNER TO supabase_admin;

--
-- TOC entry 515 (class 1259 OID 36568)
-- Name: ranging_2026_05_11; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_05_11 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_05_11 OWNER TO supabase_admin;

--
-- TOC entry 521 (class 1259 OID 37035)
-- Name: ranging_2026_05_18; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_05_18 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_05_18 OWNER TO supabase_admin;

--
-- TOC entry 527 (class 1259 OID 37694)
-- Name: ranging_2026_05_25; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_05_25 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_05_25 OWNER TO supabase_admin;

--
-- TOC entry 533 (class 1259 OID 38158)
-- Name: ranging_2026_06_01; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_2026_06_01 (
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    stationary boolean NOT NULL,
    pressure_pa integer,
    seq_number smallint,
    superframe_idx integer,
    uwb_network_timestamp double precision
);


ALTER TABLE rtls_timeseries.ranging_2026_06_01 OWNER TO supabase_admin;

--
-- TOC entry 479 (class 1259 OID 32768)
-- Name: ranging_item; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item (
    id_ranging_item bigint NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
)
PARTITION BY RANGE ("time");


ALTER TABLE rtls_timeseries.ranging_item OWNER TO supabase_admin;

--
-- TOC entry 7991 (class 0 OID 0)
-- Dependencies: 479
-- Name: COLUMN ranging_item.dist_mm; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging_item.dist_mm IS 'ranging distance in millimeter';


--
-- TOC entry 7992 (class 0 OID 0)
-- Dependencies: 479
-- Name: COLUMN ranging_item.h_diff_mm; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging_item.h_diff_mm IS 'height in millimeter to the corresponding anchor (via pressure difference) (if pressure available)';


--
-- TOC entry 7993 (class 0 OID 0)
-- Dependencies: 479
-- Name: COLUMN ranging_item.link_quality; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging_item.link_quality IS 'link quality (0-100%) between devices (at the moment only available for anchors)';


--
-- TOC entry 7994 (class 0 OID 0)
-- Dependencies: 479
-- Name: COLUMN ranging_item.rssi; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging_item.rssi IS 'received signal strength indication [dBm] (if enabled and send by the device)';


--
-- TOC entry 7995 (class 0 OID 0)
-- Dependencies: 479
-- Name: COLUMN ranging_item.pressure_pa; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON COLUMN rtls_timeseries.ranging_item.pressure_pa IS 'air pressure [Pa] (if enabled and send by the device)';


--
-- TOC entry 480 (class 1259 OID 32771)
-- Name: ranging_item_id_ranging_item_seq; Type: SEQUENCE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE SEQUENCE rtls_timeseries.ranging_item_id_ranging_item_seq
    START WITH 1
    INCREMENT BY 1000
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE rtls_timeseries.ranging_item_id_ranging_item_seq OWNER TO supabase_admin;

--
-- TOC entry 7996 (class 0 OID 0)
-- Dependencies: 480
-- Name: ranging_item_id_ranging_item_seq; Type: SEQUENCE OWNED BY; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER SEQUENCE rtls_timeseries.ranging_item_id_ranging_item_seq OWNED BY rtls_timeseries.ranging_item.id_ranging_item;


--
-- TOC entry 481 (class 1259 OID 32772)
-- Name: ranging_item_2026_01_19; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_01_19 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_01_19 OWNER TO supabase_admin;

--
-- TOC entry 482 (class 1259 OID 32776)
-- Name: ranging_item_2026_01_26; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_01_26 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_01_26 OWNER TO supabase_admin;

--
-- TOC entry 483 (class 1259 OID 32780)
-- Name: ranging_item_2026_02_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_02_02 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_02_02 OWNER TO supabase_admin;

--
-- TOC entry 484 (class 1259 OID 32784)
-- Name: ranging_item_2026_02_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_02_09 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_02_09 OWNER TO supabase_admin;

--
-- TOC entry 485 (class 1259 OID 32788)
-- Name: ranging_item_2026_02_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_02_16 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_02_16 OWNER TO supabase_admin;

--
-- TOC entry 486 (class 1259 OID 32792)
-- Name: ranging_item_2026_02_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_02_23 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_02_23 OWNER TO supabase_admin;

--
-- TOC entry 487 (class 1259 OID 32796)
-- Name: ranging_item_2026_03_02; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_03_02 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_03_02 OWNER TO supabase_admin;

--
-- TOC entry 488 (class 1259 OID 32800)
-- Name: ranging_item_2026_03_09; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_03_09 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_03_09 OWNER TO supabase_admin;

--
-- TOC entry 489 (class 1259 OID 32804)
-- Name: ranging_item_2026_03_16; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_03_16 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_03_16 OWNER TO supabase_admin;

--
-- TOC entry 490 (class 1259 OID 32808)
-- Name: ranging_item_2026_03_23; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_03_23 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_03_23 OWNER TO supabase_admin;

--
-- TOC entry 491 (class 1259 OID 32812)
-- Name: ranging_item_2026_03_30; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_03_30 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_03_30 OWNER TO supabase_admin;

--
-- TOC entry 492 (class 1259 OID 32816)
-- Name: ranging_item_2026_04_06; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_04_06 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_04_06 OWNER TO supabase_admin;

--
-- TOC entry 493 (class 1259 OID 32820)
-- Name: ranging_item_2026_04_13; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_04_13 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_04_13 OWNER TO supabase_admin;

--
-- TOC entry 494 (class 1259 OID 32824)
-- Name: ranging_item_2026_04_20; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_04_20 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_04_20 OWNER TO supabase_admin;

--
-- TOC entry 495 (class 1259 OID 32828)
-- Name: ranging_item_2026_04_27; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_04_27 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_04_27 OWNER TO supabase_admin;

--
-- TOC entry 510 (class 1259 OID 36069)
-- Name: ranging_item_2026_05_04; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_05_04 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_05_04 OWNER TO supabase_admin;

--
-- TOC entry 516 (class 1259 OID 36579)
-- Name: ranging_item_2026_05_11; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_05_11 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_05_11 OWNER TO supabase_admin;

--
-- TOC entry 522 (class 1259 OID 37046)
-- Name: ranging_item_2026_05_18; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_05_18 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_05_18 OWNER TO supabase_admin;

--
-- TOC entry 528 (class 1259 OID 37705)
-- Name: ranging_item_2026_05_25; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_05_25 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_05_25 OWNER TO supabase_admin;

--
-- TOC entry 534 (class 1259 OID 38169)
-- Name: ranging_item_2026_06_01; Type: TABLE; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE TABLE rtls_timeseries.ranging_item_2026_06_01 (
    id_ranging_item bigint DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass) NOT NULL,
    "time" timestamp with time zone NOT NULL,
    id_device bigint NOT NULL,
    opposite_id_device bigint NOT NULL,
    dist_mm integer NOT NULL,
    h_diff_mm integer,
    link_quality smallint,
    rssi smallint,
    rssi2 smallint,
    pressure_pa integer
);


ALTER TABLE rtls_timeseries.ranging_item_2026_06_01 OWNER TO supabase_admin;

--
-- TOC entry 496 (class 1259 OID 32832)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 7997 (class 0 OID 0)
-- Dependencies: 496
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 497 (class 1259 OID 32842)
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- TOC entry 498 (class 1259 OID 32851)
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.iceberg_namespaces OWNER TO supabase_storage_admin;

--
-- TOC entry 499 (class 1259 OID 32859)
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.iceberg_tables OWNER TO supabase_storage_admin;

--
-- TOC entry 500 (class 1259 OID 32867)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 501 (class 1259 OID 32871)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 8002 (class 0 OID 0)
-- Dependencies: 501
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 502 (class 1259 OID 32881)
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- TOC entry 503 (class 1259 OID 32889)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 504 (class 1259 OID 32896)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 505 (class 1259 OID 32904)
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- TOC entry 8007 (class 0 OID 0)
-- Dependencies: 505
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- TOC entry 506 (class 1259 OID 32910)
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- TOC entry 8009 (class 0 OID 0)
-- Dependencies: 506
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- TOC entry 507 (class 1259 OID 32911)
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- TOC entry 508 (class 1259 OID 32917)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- TOC entry 5358 (class 0 OID 0)
-- Name: device_status_2026_01_19; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00+00') TO ('2026-01-26 00:00:00+00');


--
-- TOC entry 5359 (class 0 OID 0)
-- Name: device_status_2026_01_26; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_01_26 FOR VALUES FROM ('2026-01-26 00:00:00+00') TO ('2026-02-02 00:00:00+00');


--
-- TOC entry 5360 (class 0 OID 0)
-- Name: device_status_2026_02_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00+00') TO ('2026-02-09 00:00:00+00');


--
-- TOC entry 5361 (class 0 OID 0)
-- Name: device_status_2026_02_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_02_09 FOR VALUES FROM ('2026-02-09 00:00:00+00') TO ('2026-02-16 00:00:00+00');


--
-- TOC entry 5362 (class 0 OID 0)
-- Name: device_status_2026_02_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_02_16 FOR VALUES FROM ('2026-02-16 00:00:00+00') TO ('2026-02-23 00:00:00+00');


--
-- TOC entry 5363 (class 0 OID 0)
-- Name: device_status_2026_02_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_02_23 FOR VALUES FROM ('2026-02-23 00:00:00+00') TO ('2026-03-02 00:00:00+00');


--
-- TOC entry 5364 (class 0 OID 0)
-- Name: device_status_2026_03_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_03_02 FOR VALUES FROM ('2026-03-02 00:00:00+00') TO ('2026-03-09 00:00:00+00');


--
-- TOC entry 5365 (class 0 OID 0)
-- Name: device_status_2026_03_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_03_09 FOR VALUES FROM ('2026-03-09 00:00:00+00') TO ('2026-03-16 00:00:00+00');


--
-- TOC entry 5366 (class 0 OID 0)
-- Name: device_status_2026_03_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_03_16 FOR VALUES FROM ('2026-03-16 00:00:00+00') TO ('2026-03-23 00:00:00+00');


--
-- TOC entry 5367 (class 0 OID 0)
-- Name: device_status_2026_03_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_03_23 FOR VALUES FROM ('2026-03-23 00:00:00+00') TO ('2026-03-30 00:00:00+00');


--
-- TOC entry 5368 (class 0 OID 0)
-- Name: device_status_2026_03_30; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_03_30 FOR VALUES FROM ('2026-03-30 00:00:00+00') TO ('2026-04-06 00:00:00+00');


--
-- TOC entry 5369 (class 0 OID 0)
-- Name: device_status_2026_04_06; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00+00') TO ('2026-04-13 00:00:00+00');


--
-- TOC entry 5370 (class 0 OID 0)
-- Name: device_status_2026_04_13; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_04_13 FOR VALUES FROM ('2026-04-13 00:00:00+00') TO ('2026-04-20 00:00:00+00');


--
-- TOC entry 5371 (class 0 OID 0)
-- Name: device_status_2026_04_20; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_04_20 FOR VALUES FROM ('2026-04-20 00:00:00+00') TO ('2026-04-27 00:00:00+00');


--
-- TOC entry 5372 (class 0 OID 0)
-- Name: device_status_2026_04_27; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00+00') TO ('2026-05-04 00:00:00+00');


--
-- TOC entry 5450 (class 0 OID 0)
-- Name: device_status_2026_05_04; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_05_04 FOR VALUES FROM ('2026-05-04 00:00:00+00') TO ('2026-05-11 00:00:00+00');


--
-- TOC entry 5456 (class 0 OID 0)
-- Name: device_status_2026_05_11; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_05_11 FOR VALUES FROM ('2026-05-11 00:00:00+00') TO ('2026-05-18 00:00:00+00');


--
-- TOC entry 5462 (class 0 OID 0)
-- Name: device_status_2026_05_18; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_05_18 FOR VALUES FROM ('2026-05-18 00:00:00+00') TO ('2026-05-25 00:00:00+00');


--
-- TOC entry 5468 (class 0 OID 0)
-- Name: device_status_2026_05_25; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_05_25 FOR VALUES FROM ('2026-05-25 00:00:00+00') TO ('2026-06-01 00:00:00+00');


--
-- TOC entry 5474 (class 0 OID 0)
-- Name: device_status_2026_06_01; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status ATTACH PARTITION rtls_timeseries.device_status_2026_06_01 FOR VALUES FROM ('2026-06-01 00:00:00+00') TO ('2026-06-08 00:00:00+00');


--
-- TOC entry 5373 (class 0 OID 0)
-- Name: gateway_info_2026_01_19; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00+00') TO ('2026-01-26 00:00:00+00');


--
-- TOC entry 5374 (class 0 OID 0)
-- Name: gateway_info_2026_01_26; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_01_26 FOR VALUES FROM ('2026-01-26 00:00:00+00') TO ('2026-02-02 00:00:00+00');


--
-- TOC entry 5375 (class 0 OID 0)
-- Name: gateway_info_2026_02_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00+00') TO ('2026-02-09 00:00:00+00');


--
-- TOC entry 5376 (class 0 OID 0)
-- Name: gateway_info_2026_02_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_09 FOR VALUES FROM ('2026-02-09 00:00:00+00') TO ('2026-02-16 00:00:00+00');


--
-- TOC entry 5377 (class 0 OID 0)
-- Name: gateway_info_2026_02_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_16 FOR VALUES FROM ('2026-02-16 00:00:00+00') TO ('2026-02-23 00:00:00+00');


--
-- TOC entry 5378 (class 0 OID 0)
-- Name: gateway_info_2026_02_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_23 FOR VALUES FROM ('2026-02-23 00:00:00+00') TO ('2026-03-02 00:00:00+00');


--
-- TOC entry 5379 (class 0 OID 0)
-- Name: gateway_info_2026_03_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_02 FOR VALUES FROM ('2026-03-02 00:00:00+00') TO ('2026-03-09 00:00:00+00');


--
-- TOC entry 5380 (class 0 OID 0)
-- Name: gateway_info_2026_03_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_09 FOR VALUES FROM ('2026-03-09 00:00:00+00') TO ('2026-03-16 00:00:00+00');


--
-- TOC entry 5381 (class 0 OID 0)
-- Name: gateway_info_2026_03_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_16 FOR VALUES FROM ('2026-03-16 00:00:00+00') TO ('2026-03-23 00:00:00+00');


--
-- TOC entry 5382 (class 0 OID 0)
-- Name: gateway_info_2026_03_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_23 FOR VALUES FROM ('2026-03-23 00:00:00+00') TO ('2026-03-30 00:00:00+00');


--
-- TOC entry 5383 (class 0 OID 0)
-- Name: gateway_info_2026_03_30; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_30 FOR VALUES FROM ('2026-03-30 00:00:00+00') TO ('2026-04-06 00:00:00+00');


--
-- TOC entry 5384 (class 0 OID 0)
-- Name: gateway_info_2026_04_06; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00+00') TO ('2026-04-13 00:00:00+00');


--
-- TOC entry 5385 (class 0 OID 0)
-- Name: gateway_info_2026_04_13; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_13 FOR VALUES FROM ('2026-04-13 00:00:00+00') TO ('2026-04-20 00:00:00+00');


--
-- TOC entry 5386 (class 0 OID 0)
-- Name: gateway_info_2026_04_20; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_20 FOR VALUES FROM ('2026-04-20 00:00:00+00') TO ('2026-04-27 00:00:00+00');


--
-- TOC entry 5387 (class 0 OID 0)
-- Name: gateway_info_2026_04_27; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00+00') TO ('2026-05-04 00:00:00+00');


--
-- TOC entry 5453 (class 0 OID 0)
-- Name: gateway_info_2026_05_04; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_04 FOR VALUES FROM ('2026-05-04 00:00:00+00') TO ('2026-05-11 00:00:00+00');


--
-- TOC entry 5459 (class 0 OID 0)
-- Name: gateway_info_2026_05_11; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_11 FOR VALUES FROM ('2026-05-11 00:00:00+00') TO ('2026-05-18 00:00:00+00');


--
-- TOC entry 5465 (class 0 OID 0)
-- Name: gateway_info_2026_05_18; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_18 FOR VALUES FROM ('2026-05-18 00:00:00+00') TO ('2026-05-25 00:00:00+00');


--
-- TOC entry 5471 (class 0 OID 0)
-- Name: gateway_info_2026_05_25; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_25 FOR VALUES FROM ('2026-05-25 00:00:00+00') TO ('2026-06-01 00:00:00+00');


--
-- TOC entry 5477 (class 0 OID 0)
-- Name: gateway_info_2026_06_01; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_06_01 FOR VALUES FROM ('2026-06-01 00:00:00+00') TO ('2026-06-08 00:00:00+00');


--
-- TOC entry 5388 (class 0 OID 0)
-- Name: position_2026_01_19; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00+00') TO ('2026-01-26 00:00:00+00');


--
-- TOC entry 5389 (class 0 OID 0)
-- Name: position_2026_01_26; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_01_26 FOR VALUES FROM ('2026-01-26 00:00:00+00') TO ('2026-02-02 00:00:00+00');


--
-- TOC entry 5390 (class 0 OID 0)
-- Name: position_2026_02_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00+00') TO ('2026-02-09 00:00:00+00');


--
-- TOC entry 5391 (class 0 OID 0)
-- Name: position_2026_02_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_02_09 FOR VALUES FROM ('2026-02-09 00:00:00+00') TO ('2026-02-16 00:00:00+00');


--
-- TOC entry 5392 (class 0 OID 0)
-- Name: position_2026_02_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_02_16 FOR VALUES FROM ('2026-02-16 00:00:00+00') TO ('2026-02-23 00:00:00+00');


--
-- TOC entry 5393 (class 0 OID 0)
-- Name: position_2026_02_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_02_23 FOR VALUES FROM ('2026-02-23 00:00:00+00') TO ('2026-03-02 00:00:00+00');


--
-- TOC entry 5394 (class 0 OID 0)
-- Name: position_2026_03_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_03_02 FOR VALUES FROM ('2026-03-02 00:00:00+00') TO ('2026-03-09 00:00:00+00');


--
-- TOC entry 5395 (class 0 OID 0)
-- Name: position_2026_03_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_03_09 FOR VALUES FROM ('2026-03-09 00:00:00+00') TO ('2026-03-16 00:00:00+00');


--
-- TOC entry 5396 (class 0 OID 0)
-- Name: position_2026_03_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_03_16 FOR VALUES FROM ('2026-03-16 00:00:00+00') TO ('2026-03-23 00:00:00+00');


--
-- TOC entry 5397 (class 0 OID 0)
-- Name: position_2026_03_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_03_23 FOR VALUES FROM ('2026-03-23 00:00:00+00') TO ('2026-03-30 00:00:00+00');


--
-- TOC entry 5398 (class 0 OID 0)
-- Name: position_2026_03_30; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_03_30 FOR VALUES FROM ('2026-03-30 00:00:00+00') TO ('2026-04-06 00:00:00+00');


--
-- TOC entry 5399 (class 0 OID 0)
-- Name: position_2026_04_06; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00+00') TO ('2026-04-13 00:00:00+00');


--
-- TOC entry 5400 (class 0 OID 0)
-- Name: position_2026_04_13; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_04_13 FOR VALUES FROM ('2026-04-13 00:00:00+00') TO ('2026-04-20 00:00:00+00');


--
-- TOC entry 5401 (class 0 OID 0)
-- Name: position_2026_04_20; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_04_20 FOR VALUES FROM ('2026-04-20 00:00:00+00') TO ('2026-04-27 00:00:00+00');


--
-- TOC entry 5402 (class 0 OID 0)
-- Name: position_2026_04_27; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00+00') TO ('2026-05-04 00:00:00+00');


--
-- TOC entry 5451 (class 0 OID 0)
-- Name: position_2026_05_04; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_05_04 FOR VALUES FROM ('2026-05-04 00:00:00+00') TO ('2026-05-11 00:00:00+00');


--
-- TOC entry 5457 (class 0 OID 0)
-- Name: position_2026_05_11; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_05_11 FOR VALUES FROM ('2026-05-11 00:00:00+00') TO ('2026-05-18 00:00:00+00');


--
-- TOC entry 5463 (class 0 OID 0)
-- Name: position_2026_05_18; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_05_18 FOR VALUES FROM ('2026-05-18 00:00:00+00') TO ('2026-05-25 00:00:00+00');


--
-- TOC entry 5469 (class 0 OID 0)
-- Name: position_2026_05_25; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_05_25 FOR VALUES FROM ('2026-05-25 00:00:00+00') TO ('2026-06-01 00:00:00+00');


--
-- TOC entry 5475 (class 0 OID 0)
-- Name: position_2026_06_01; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position" ATTACH PARTITION rtls_timeseries.position_2026_06_01 FOR VALUES FROM ('2026-06-01 00:00:00+00') TO ('2026-06-08 00:00:00+00');


--
-- TOC entry 5403 (class 0 OID 0)
-- Name: position_area_2026_01_19; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00+00') TO ('2026-01-26 00:00:00+00');


--
-- TOC entry 5404 (class 0 OID 0)
-- Name: position_area_2026_01_26; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_01_26 FOR VALUES FROM ('2026-01-26 00:00:00+00') TO ('2026-02-02 00:00:00+00');


--
-- TOC entry 5405 (class 0 OID 0)
-- Name: position_area_2026_02_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00+00') TO ('2026-02-09 00:00:00+00');


--
-- TOC entry 5406 (class 0 OID 0)
-- Name: position_area_2026_02_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_02_09 FOR VALUES FROM ('2026-02-09 00:00:00+00') TO ('2026-02-16 00:00:00+00');


--
-- TOC entry 5407 (class 0 OID 0)
-- Name: position_area_2026_02_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_02_16 FOR VALUES FROM ('2026-02-16 00:00:00+00') TO ('2026-02-23 00:00:00+00');


--
-- TOC entry 5408 (class 0 OID 0)
-- Name: position_area_2026_02_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_02_23 FOR VALUES FROM ('2026-02-23 00:00:00+00') TO ('2026-03-02 00:00:00+00');


--
-- TOC entry 5409 (class 0 OID 0)
-- Name: position_area_2026_03_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_03_02 FOR VALUES FROM ('2026-03-02 00:00:00+00') TO ('2026-03-09 00:00:00+00');


--
-- TOC entry 5410 (class 0 OID 0)
-- Name: position_area_2026_03_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_03_09 FOR VALUES FROM ('2026-03-09 00:00:00+00') TO ('2026-03-16 00:00:00+00');


--
-- TOC entry 5411 (class 0 OID 0)
-- Name: position_area_2026_03_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_03_16 FOR VALUES FROM ('2026-03-16 00:00:00+00') TO ('2026-03-23 00:00:00+00');


--
-- TOC entry 5412 (class 0 OID 0)
-- Name: position_area_2026_03_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_03_23 FOR VALUES FROM ('2026-03-23 00:00:00+00') TO ('2026-03-30 00:00:00+00');


--
-- TOC entry 5413 (class 0 OID 0)
-- Name: position_area_2026_03_30; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_03_30 FOR VALUES FROM ('2026-03-30 00:00:00+00') TO ('2026-04-06 00:00:00+00');


--
-- TOC entry 5414 (class 0 OID 0)
-- Name: position_area_2026_04_06; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00+00') TO ('2026-04-13 00:00:00+00');


--
-- TOC entry 5415 (class 0 OID 0)
-- Name: position_area_2026_04_13; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_04_13 FOR VALUES FROM ('2026-04-13 00:00:00+00') TO ('2026-04-20 00:00:00+00');


--
-- TOC entry 5416 (class 0 OID 0)
-- Name: position_area_2026_04_20; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_04_20 FOR VALUES FROM ('2026-04-20 00:00:00+00') TO ('2026-04-27 00:00:00+00');


--
-- TOC entry 5417 (class 0 OID 0)
-- Name: position_area_2026_04_27; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00+00') TO ('2026-05-04 00:00:00+00');


--
-- TOC entry 5452 (class 0 OID 0)
-- Name: position_area_2026_05_04; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_05_04 FOR VALUES FROM ('2026-05-04 00:00:00+00') TO ('2026-05-11 00:00:00+00');


--
-- TOC entry 5458 (class 0 OID 0)
-- Name: position_area_2026_05_11; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_05_11 FOR VALUES FROM ('2026-05-11 00:00:00+00') TO ('2026-05-18 00:00:00+00');


--
-- TOC entry 5464 (class 0 OID 0)
-- Name: position_area_2026_05_18; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_05_18 FOR VALUES FROM ('2026-05-18 00:00:00+00') TO ('2026-05-25 00:00:00+00');


--
-- TOC entry 5470 (class 0 OID 0)
-- Name: position_area_2026_05_25; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_05_25 FOR VALUES FROM ('2026-05-25 00:00:00+00') TO ('2026-06-01 00:00:00+00');


--
-- TOC entry 5476 (class 0 OID 0)
-- Name: position_area_2026_06_01; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area ATTACH PARTITION rtls_timeseries.position_area_2026_06_01 FOR VALUES FROM ('2026-06-01 00:00:00+00') TO ('2026-06-08 00:00:00+00');


--
-- TOC entry 5418 (class 0 OID 0)
-- Name: ranging_2026_01_19; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00+00') TO ('2026-01-26 00:00:00+00');


--
-- TOC entry 5419 (class 0 OID 0)
-- Name: ranging_2026_01_26; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_01_26 FOR VALUES FROM ('2026-01-26 00:00:00+00') TO ('2026-02-02 00:00:00+00');


--
-- TOC entry 5420 (class 0 OID 0)
-- Name: ranging_2026_02_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00+00') TO ('2026-02-09 00:00:00+00');


--
-- TOC entry 5421 (class 0 OID 0)
-- Name: ranging_2026_02_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_02_09 FOR VALUES FROM ('2026-02-09 00:00:00+00') TO ('2026-02-16 00:00:00+00');


--
-- TOC entry 5422 (class 0 OID 0)
-- Name: ranging_2026_02_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_02_16 FOR VALUES FROM ('2026-02-16 00:00:00+00') TO ('2026-02-23 00:00:00+00');


--
-- TOC entry 5423 (class 0 OID 0)
-- Name: ranging_2026_02_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_02_23 FOR VALUES FROM ('2026-02-23 00:00:00+00') TO ('2026-03-02 00:00:00+00');


--
-- TOC entry 5424 (class 0 OID 0)
-- Name: ranging_2026_03_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_03_02 FOR VALUES FROM ('2026-03-02 00:00:00+00') TO ('2026-03-09 00:00:00+00');


--
-- TOC entry 5425 (class 0 OID 0)
-- Name: ranging_2026_03_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_03_09 FOR VALUES FROM ('2026-03-09 00:00:00+00') TO ('2026-03-16 00:00:00+00');


--
-- TOC entry 5426 (class 0 OID 0)
-- Name: ranging_2026_03_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_03_16 FOR VALUES FROM ('2026-03-16 00:00:00+00') TO ('2026-03-23 00:00:00+00');


--
-- TOC entry 5427 (class 0 OID 0)
-- Name: ranging_2026_03_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_03_23 FOR VALUES FROM ('2026-03-23 00:00:00+00') TO ('2026-03-30 00:00:00+00');


--
-- TOC entry 5428 (class 0 OID 0)
-- Name: ranging_2026_03_30; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_03_30 FOR VALUES FROM ('2026-03-30 00:00:00+00') TO ('2026-04-06 00:00:00+00');


--
-- TOC entry 5429 (class 0 OID 0)
-- Name: ranging_2026_04_06; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00+00') TO ('2026-04-13 00:00:00+00');


--
-- TOC entry 5430 (class 0 OID 0)
-- Name: ranging_2026_04_13; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_04_13 FOR VALUES FROM ('2026-04-13 00:00:00+00') TO ('2026-04-20 00:00:00+00');


--
-- TOC entry 5431 (class 0 OID 0)
-- Name: ranging_2026_04_20; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_04_20 FOR VALUES FROM ('2026-04-20 00:00:00+00') TO ('2026-04-27 00:00:00+00');


--
-- TOC entry 5432 (class 0 OID 0)
-- Name: ranging_2026_04_27; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00+00') TO ('2026-05-04 00:00:00+00');


--
-- TOC entry 5448 (class 0 OID 0)
-- Name: ranging_2026_05_04; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_05_04 FOR VALUES FROM ('2026-05-04 00:00:00+00') TO ('2026-05-11 00:00:00+00');


--
-- TOC entry 5454 (class 0 OID 0)
-- Name: ranging_2026_05_11; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_05_11 FOR VALUES FROM ('2026-05-11 00:00:00+00') TO ('2026-05-18 00:00:00+00');


--
-- TOC entry 5460 (class 0 OID 0)
-- Name: ranging_2026_05_18; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_05_18 FOR VALUES FROM ('2026-05-18 00:00:00+00') TO ('2026-05-25 00:00:00+00');


--
-- TOC entry 5466 (class 0 OID 0)
-- Name: ranging_2026_05_25; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_05_25 FOR VALUES FROM ('2026-05-25 00:00:00+00') TO ('2026-06-01 00:00:00+00');


--
-- TOC entry 5472 (class 0 OID 0)
-- Name: ranging_2026_06_01; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging ATTACH PARTITION rtls_timeseries.ranging_2026_06_01 FOR VALUES FROM ('2026-06-01 00:00:00+00') TO ('2026-06-08 00:00:00+00');


--
-- TOC entry 5433 (class 0 OID 0)
-- Name: ranging_item_2026_01_19; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_01_19 FOR VALUES FROM ('2026-01-19 00:00:00+00') TO ('2026-01-26 00:00:00+00');


--
-- TOC entry 5434 (class 0 OID 0)
-- Name: ranging_item_2026_01_26; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_01_26 FOR VALUES FROM ('2026-01-26 00:00:00+00') TO ('2026-02-02 00:00:00+00');


--
-- TOC entry 5435 (class 0 OID 0)
-- Name: ranging_item_2026_02_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_02 FOR VALUES FROM ('2026-02-02 00:00:00+00') TO ('2026-02-09 00:00:00+00');


--
-- TOC entry 5436 (class 0 OID 0)
-- Name: ranging_item_2026_02_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_09 FOR VALUES FROM ('2026-02-09 00:00:00+00') TO ('2026-02-16 00:00:00+00');


--
-- TOC entry 5437 (class 0 OID 0)
-- Name: ranging_item_2026_02_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_16 FOR VALUES FROM ('2026-02-16 00:00:00+00') TO ('2026-02-23 00:00:00+00');


--
-- TOC entry 5438 (class 0 OID 0)
-- Name: ranging_item_2026_02_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_23 FOR VALUES FROM ('2026-02-23 00:00:00+00') TO ('2026-03-02 00:00:00+00');


--
-- TOC entry 5439 (class 0 OID 0)
-- Name: ranging_item_2026_03_02; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_02 FOR VALUES FROM ('2026-03-02 00:00:00+00') TO ('2026-03-09 00:00:00+00');


--
-- TOC entry 5440 (class 0 OID 0)
-- Name: ranging_item_2026_03_09; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_09 FOR VALUES FROM ('2026-03-09 00:00:00+00') TO ('2026-03-16 00:00:00+00');


--
-- TOC entry 5441 (class 0 OID 0)
-- Name: ranging_item_2026_03_16; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_16 FOR VALUES FROM ('2026-03-16 00:00:00+00') TO ('2026-03-23 00:00:00+00');


--
-- TOC entry 5442 (class 0 OID 0)
-- Name: ranging_item_2026_03_23; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_23 FOR VALUES FROM ('2026-03-23 00:00:00+00') TO ('2026-03-30 00:00:00+00');


--
-- TOC entry 5443 (class 0 OID 0)
-- Name: ranging_item_2026_03_30; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_30 FOR VALUES FROM ('2026-03-30 00:00:00+00') TO ('2026-04-06 00:00:00+00');


--
-- TOC entry 5444 (class 0 OID 0)
-- Name: ranging_item_2026_04_06; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_06 FOR VALUES FROM ('2026-04-06 00:00:00+00') TO ('2026-04-13 00:00:00+00');


--
-- TOC entry 5445 (class 0 OID 0)
-- Name: ranging_item_2026_04_13; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_13 FOR VALUES FROM ('2026-04-13 00:00:00+00') TO ('2026-04-20 00:00:00+00');


--
-- TOC entry 5446 (class 0 OID 0)
-- Name: ranging_item_2026_04_20; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_20 FOR VALUES FROM ('2026-04-20 00:00:00+00') TO ('2026-04-27 00:00:00+00');


--
-- TOC entry 5447 (class 0 OID 0)
-- Name: ranging_item_2026_04_27; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_27 FOR VALUES FROM ('2026-04-27 00:00:00+00') TO ('2026-05-04 00:00:00+00');


--
-- TOC entry 5449 (class 0 OID 0)
-- Name: ranging_item_2026_05_04; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_04 FOR VALUES FROM ('2026-05-04 00:00:00+00') TO ('2026-05-11 00:00:00+00');


--
-- TOC entry 5455 (class 0 OID 0)
-- Name: ranging_item_2026_05_11; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_11 FOR VALUES FROM ('2026-05-11 00:00:00+00') TO ('2026-05-18 00:00:00+00');


--
-- TOC entry 5461 (class 0 OID 0)
-- Name: ranging_item_2026_05_18; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_18 FOR VALUES FROM ('2026-05-18 00:00:00+00') TO ('2026-05-25 00:00:00+00');


--
-- TOC entry 5467 (class 0 OID 0)
-- Name: ranging_item_2026_05_25; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_25 FOR VALUES FROM ('2026-05-25 00:00:00+00') TO ('2026-06-01 00:00:00+00');


--
-- TOC entry 5473 (class 0 OID 0)
-- Name: ranging_item_2026_06_01; Type: TABLE ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ATTACH PARTITION rtls_timeseries.ranging_item_2026_06_01 FOR VALUES FROM ('2026-06-01 00:00:00+00') TO ('2026-06-08 00:00:00+00');


--
-- TOC entry 5484 (class 2604 OID 32922)
-- Name: alert_queries id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries ALTER COLUMN id SET DEFAULT nextval('_analytics.alert_queries_id_seq'::regclass);


--
-- TOC entry 5485 (class 2604 OID 32923)
-- Name: backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.backends ALTER COLUMN id SET DEFAULT nextval('_analytics.backends_id_seq'::regclass);


--
-- TOC entry 5486 (class 2604 OID 32924)
-- Name: billing_accounts id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_accounts ALTER COLUMN id SET DEFAULT nextval('_analytics.billing_accounts_id_seq'::regclass);


--
-- TOC entry 5490 (class 2604 OID 32925)
-- Name: billing_counts id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_counts ALTER COLUMN id SET DEFAULT nextval('_analytics.billing_counts_id_seq'::regclass);


--
-- TOC entry 5491 (class 2604 OID 32926)
-- Name: endpoint_queries id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries ALTER COLUMN id SET DEFAULT nextval('_analytics.endpoint_queries_id_seq'::regclass);


--
-- TOC entry 5498 (class 2604 OID 32927)
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('_analytics.oauth_access_grants_id_seq'::regclass);


--
-- TOC entry 5499 (class 2604 OID 32928)
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('_analytics.oauth_access_tokens_id_seq'::regclass);


--
-- TOC entry 5501 (class 2604 OID 32929)
-- Name: oauth_applications id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_applications ALTER COLUMN id SET DEFAULT nextval('_analytics.oauth_applications_id_seq'::regclass);


--
-- TOC entry 5504 (class 2604 OID 32930)
-- Name: partner_users id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users ALTER COLUMN id SET DEFAULT nextval('_analytics.partner_users_id_seq'::regclass);


--
-- TOC entry 5506 (class 2604 OID 32931)
-- Name: partners id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partners ALTER COLUMN id SET DEFAULT nextval('_analytics.partners_id_seq'::regclass);


--
-- TOC entry 5507 (class 2604 OID 32932)
-- Name: payment_methods id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.payment_methods ALTER COLUMN id SET DEFAULT nextval('_analytics.payment_methods_id_seq'::regclass);


--
-- TOC entry 5508 (class 2604 OID 32933)
-- Name: plans id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.plans ALTER COLUMN id SET DEFAULT nextval('_analytics.plans_id_seq'::regclass);


--
-- TOC entry 5511 (class 2604 OID 32934)
-- Name: rules id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules ALTER COLUMN id SET DEFAULT nextval('_analytics.rules_id_seq'::regclass);


--
-- TOC entry 5515 (class 2604 OID 32935)
-- Name: saved_search_counters id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_search_counters ALTER COLUMN id SET DEFAULT nextval('_analytics.saved_search_counters_id_seq'::regclass);


--
-- TOC entry 5517 (class 2604 OID 32936)
-- Name: saved_searches id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_searches ALTER COLUMN id SET DEFAULT nextval('_analytics.saved_searches_id_seq'::regclass);


--
-- TOC entry 5520 (class 2604 OID 32937)
-- Name: source_backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_backends ALTER COLUMN id SET DEFAULT nextval('_analytics.source_backends_id_seq'::regclass);


--
-- TOC entry 5521 (class 2604 OID 32938)
-- Name: source_schemas id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_schemas ALTER COLUMN id SET DEFAULT nextval('_analytics.source_schemas_id_seq'::regclass);


--
-- TOC entry 5522 (class 2604 OID 32939)
-- Name: sources id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources ALTER COLUMN id SET DEFAULT nextval('_analytics.sources_id_seq'::regclass);


--
-- TOC entry 5533 (class 2604 OID 32940)
-- Name: sources_backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends ALTER COLUMN id SET DEFAULT nextval('_analytics.sources_backends_id_seq'::regclass);


--
-- TOC entry 5534 (class 2604 OID 32941)
-- Name: system_metrics id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.system_metrics ALTER COLUMN id SET DEFAULT nextval('_analytics.system_metrics_id_seq'::regclass);


--
-- TOC entry 5535 (class 2604 OID 32942)
-- Name: team_users id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.team_users ALTER COLUMN id SET DEFAULT nextval('_analytics.team_users_id_seq'::regclass);


--
-- TOC entry 5538 (class 2604 OID 32943)
-- Name: teams id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.teams ALTER COLUMN id SET DEFAULT nextval('_analytics.teams_id_seq'::regclass);


--
-- TOC entry 5540 (class 2604 OID 32944)
-- Name: users id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.users ALTER COLUMN id SET DEFAULT nextval('_analytics.users_id_seq'::regclass);


--
-- TOC entry 5550 (class 2604 OID 32945)
-- Name: vercel_auths id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.vercel_auths ALTER COLUMN id SET DEFAULT nextval('_analytics.vercel_auths_id_seq'::regclass);


--
-- TOC entry 5556 (class 2604 OID 32946)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 5584 (class 2604 OID 32947)
-- Name: alarm_events id_alarm; Type: DEFAULT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.alarm_events ALTER COLUMN id_alarm SET DEFAULT nextval('rtls_config.alarm_events_id_alarm_seq'::regclass);


--
-- TOC entry 5590 (class 2604 OID 32948)
-- Name: asset id_asset; Type: DEFAULT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.asset ALTER COLUMN id_asset SET DEFAULT nextval('rtls_config.asset_id_asset_seq'::regclass);


--
-- TOC entry 5591 (class 2604 OID 32949)
-- Name: asset_type id_asset_type; Type: DEFAULT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.asset_type ALTER COLUMN id_asset_type SET DEFAULT nextval('rtls_config.asset_type_id_asset_type_seq'::regclass);


--
-- TOC entry 5593 (class 2604 OID 32950)
-- Name: gateway id_gateway; Type: DEFAULT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.gateway ALTER COLUMN id_gateway SET DEFAULT nextval('rtls_config.gateway_id_gateway_seq'::regclass);


--
-- TOC entry 5594 (class 2604 OID 32951)
-- Name: uwb_device id_device; Type: DEFAULT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.uwb_device ALTER COLUMN id_device SET DEFAULT nextval('rtls_config.uwb_device_id_device_seq'::regclass);


--
-- TOC entry 5576 (class 2604 OID 32952)
-- Name: device id_device; Type: DEFAULT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.device ALTER COLUMN id_device SET DEFAULT nextval('rtls_measurement.device_id_device_seq'::regclass);


--
-- TOC entry 5578 (class 2604 OID 32953)
-- Name: reference_point id_reference_point; Type: DEFAULT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point ALTER COLUMN id_reference_point SET DEFAULT nextval('rtls_measurement.reference_point_id_reference_point_seq'::regclass);


--
-- TOC entry 5579 (class 2604 OID 32954)
-- Name: reference_point_measurement id_reference_point_measurement; Type: DEFAULT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement ALTER COLUMN id_reference_point_measurement SET DEFAULT nextval('rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq'::regclass);


--
-- TOC entry 5581 (class 2604 OID 32955)
-- Name: setup id_setup; Type: DEFAULT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.setup ALTER COLUMN id_setup SET DEFAULT nextval('rtls_measurement.setup_id_setup_seq'::regclass);


--
-- TOC entry 5623 (class 2604 OID 32956)
-- Name: ranging_item id_ranging_item; Type: DEFAULT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item ALTER COLUMN id_ranging_item SET DEFAULT nextval('rtls_timeseries.ranging_item_id_ranging_item_seq'::regclass);


--
-- TOC entry 5668 (class 2604 OID 32957)
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- TOC entry 5730 (class 2606 OID 33104)
-- Name: alert_queries alert_queries_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries
    ADD CONSTRAINT alert_queries_pkey PRIMARY KEY (id);


--
-- TOC entry 5734 (class 2606 OID 33096)
-- Name: backends backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.backends
    ADD CONSTRAINT backends_pkey PRIMARY KEY (id);


--
-- TOC entry 5736 (class 2606 OID 33058)
-- Name: billing_accounts billing_accounts_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_accounts
    ADD CONSTRAINT billing_accounts_pkey PRIMARY KEY (id);


--
-- TOC entry 5741 (class 2606 OID 33091)
-- Name: billing_counts billing_counts_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_counts
    ADD CONSTRAINT billing_counts_pkey PRIMARY KEY (id);


--
-- TOC entry 5745 (class 2606 OID 33086)
-- Name: endpoint_queries endpoint_queries_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_pkey PRIMARY KEY (id);


--
-- TOC entry 5749 (class 2606 OID 33119)
-- Name: log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5 log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5
    ADD CONSTRAINT log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5_pkey PRIMARY KEY (id);


--
-- TOC entry 5752 (class 2606 OID 33134)
-- Name: log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e
    ADD CONSTRAINT log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e_pkey PRIMARY KEY (id);


--
-- TOC entry 5755 (class 2606 OID 33106)
-- Name: log_events_28d2ec64_d503_46e0_b858_c62a2a9de000 log_events_28d2ec64_d503_46e0_b858_c62a2a9de000_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_28d2ec64_d503_46e0_b858_c62a2a9de000
    ADD CONSTRAINT log_events_28d2ec64_d503_46e0_b858_c62a2a9de000_pkey PRIMARY KEY (id);


--
-- TOC entry 5758 (class 2606 OID 33108)
-- Name: log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492 log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492
    ADD CONSTRAINT log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492_pkey PRIMARY KEY (id);


--
-- TOC entry 5761 (class 2606 OID 33100)
-- Name: log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb
    ADD CONSTRAINT log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb_pkey PRIMARY KEY (id);


--
-- TOC entry 5764 (class 2606 OID 33098)
-- Name: log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72 log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72
    ADD CONSTRAINT log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72_pkey PRIMARY KEY (id);


--
-- TOC entry 5767 (class 2606 OID 33116)
-- Name: log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9 log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9
    ADD CONSTRAINT log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9_pkey PRIMARY KEY (id);


--
-- TOC entry 5770 (class 2606 OID 33140)
-- Name: log_events_f2cf0b56_836d_420d_84c0_639871495297 log_events_f2cf0b56_836d_420d_84c0_639871495297_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_f2cf0b56_836d_420d_84c0_639871495297
    ADD CONSTRAINT log_events_f2cf0b56_836d_420d_84c0_639871495297_pkey PRIMARY KEY (id);


--
-- TOC entry 5773 (class 2606 OID 33127)
-- Name: log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27 log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27
    ADD CONSTRAINT log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27_pkey PRIMARY KEY (id);


--
-- TOC entry 5776 (class 2606 OID 33040)
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- TOC entry 5779 (class 2606 OID 33042)
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5785 (class 2606 OID 33038)
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- TOC entry 5790 (class 2606 OID 33102)
-- Name: partner_users partner_users_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users
    ADD CONSTRAINT partner_users_pkey PRIMARY KEY (id);


--
-- TOC entry 5792 (class 2606 OID 33088)
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- TOC entry 5795 (class 2606 OID 33077)
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- TOC entry 5798 (class 2606 OID 33069)
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- TOC entry 5800 (class 2606 OID 33036)
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);


--
-- TOC entry 5804 (class 2606 OID 33067)
-- Name: saved_search_counters saved_search_counters_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_search_counters
    ADD CONSTRAINT saved_search_counters_pkey PRIMARY KEY (id);


--
-- TOC entry 5807 (class 2606 OID 33052)
-- Name: saved_searches saved_searches_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_searches
    ADD CONSTRAINT saved_searches_pkey PRIMARY KEY (id);


--
-- TOC entry 5810 (class 2606 OID 32998)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 5812 (class 2606 OID 33093)
-- Name: source_backends source_backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_backends
    ADD CONSTRAINT source_backends_pkey PRIMARY KEY (id);


--
-- TOC entry 5814 (class 2606 OID 33074)
-- Name: source_schemas source_schemas_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_schemas
    ADD CONSTRAINT source_schemas_pkey PRIMARY KEY (id);


--
-- TOC entry 5823 (class 2606 OID 33114)
-- Name: sources_backends sources_backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends
    ADD CONSTRAINT sources_backends_pkey PRIMARY KEY (id);


--
-- TOC entry 5818 (class 2606 OID 33032)
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- TOC entry 5826 (class 2606 OID 33050)
-- Name: system_metrics system_metrics_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.system_metrics
    ADD CONSTRAINT system_metrics_pkey PRIMARY KEY (id);


--
-- TOC entry 5828 (class 2606 OID 33056)
-- Name: team_users team_users_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.team_users
    ADD CONSTRAINT team_users_pkey PRIMARY KEY (id);


--
-- TOC entry 5832 (class 2606 OID 33054)
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- TOC entry 5838 (class 2606 OID 33007)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5840 (class 2606 OID 33079)
-- Name: vercel_auths vercel_auths_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.vercel_auths
    ADD CONSTRAINT vercel_auths_pkey PRIMARY KEY (id);


--
-- TOC entry 5858 (class 2606 OID 33157)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 5842 (class 2606 OID 32988)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 5846 (class 2606 OID 33192)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 5851 (class 2606 OID 33123)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 5853 (class 2606 OID 33129)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 5856 (class 2606 OID 32986)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 5860 (class 2606 OID 33171)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 5863 (class 2606 OID 33173)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 5866 (class 2606 OID 33146)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 5868 (class 2606 OID 33153)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 5873 (class 2606 OID 33200)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5881 (class 2606 OID 32978)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 5884 (class 2606 OID 32984)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 5887 (class 2606 OID 33184)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 5889 (class 2606 OID 33189)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 5894 (class 2606 OID 33194)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 5897 (class 2606 OID 32980)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 5900 (class 2606 OID 33169)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5905 (class 2606 OID 33182)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 5908 (class 2606 OID 33175)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 5920 (class 2606 OID 32971)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 5922 (class 2606 OID 32976)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5924 (class 2606 OID 33020)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5926 (class 2606 OID 33022)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 5928 (class 2606 OID 33028)
-- Name: roles roles_ordering_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_ordering_key UNIQUE (ordering);


--
-- TOC entry 5930 (class 2606 OID 33034)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 5940 (class 2606 OID 33030)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 5942 (class 2606 OID 33224)
-- Name: alarm_events alarm_events_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.alarm_events
    ADD CONSTRAINT alarm_events_pkey PRIMARY KEY (id_alarm);


--
-- TOC entry 5949 (class 2606 OID 33220)
-- Name: area_permission area_permission_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.area_permission
    ADD CONSTRAINT area_permission_pkey PRIMARY KEY (id_area, id_asset);


--
-- TOC entry 5944 (class 2606 OID 33218)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id_area);


--
-- TOC entry 5951 (class 2606 OID 33212)
-- Name: asset asset_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY (id_asset);


--
-- TOC entry 5954 (class 2606 OID 33210)
-- Name: asset_type asset_type_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.asset_type
    ADD CONSTRAINT asset_type_pkey PRIMARY KEY (id_asset_type);


--
-- TOC entry 5956 (class 2606 OID 33208)
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 5959 (class 2606 OID 33242)
-- Name: gateway gateway_gateway_name_key; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.gateway
    ADD CONSTRAINT gateway_gateway_name_key UNIQUE (gateway_name);


--
-- TOC entry 5961 (class 2606 OID 33249)
-- Name: gateway gateway_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.gateway
    ADD CONSTRAINT gateway_pkey PRIMARY KEY (id_gateway);


--
-- TOC entry 5963 (class 2606 OID 33216)
-- Name: map_image map_image_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.map_image
    ADD CONSTRAINT map_image_pkey PRIMARY KEY (id_map_image);


--
-- TOC entry 5970 (class 2606 OID 33222)
-- Name: uwb_device uwb_device_pkey; Type: CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.uwb_device
    ADD CONSTRAINT uwb_device_pkey PRIMARY KEY (id_device);


--
-- TOC entry 5932 (class 2606 OID 33256)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id_device);


--
-- TOC entry 5936 (class 2606 OID 33258)
-- Name: reference_point_measurement reference_point_measurement_pkey; Type: CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement
    ADD CONSTRAINT reference_point_measurement_pkey PRIMARY KEY (id_reference_point_measurement);


--
-- TOC entry 5934 (class 2606 OID 33254)
-- Name: reference_point reference_point_pkey; Type: CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point
    ADD CONSTRAINT reference_point_pkey PRIMARY KEY (id_reference_point);


--
-- TOC entry 5938 (class 2606 OID 33252)
-- Name: setup setup_pkey; Type: CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.setup
    ADD CONSTRAINT setup_pkey PRIMARY KEY (id_setup);


--
-- TOC entry 5972 (class 2606 OID 33260)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (id_device);


--
-- TOC entry 5974 (class 2606 OID 33282)
-- Name: position position_new_pkey; Type: CONSTRAINT; Schema: rtls_measurement_2; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_2."position"
    ADD CONSTRAINT position_new_pkey PRIMARY KEY (id_device, "time");


--
-- TOC entry 5978 (class 2606 OID 33264)
-- Name: reference_point_measurement reference_point_measurement_pkey; Type: CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point_measurement
    ADD CONSTRAINT reference_point_measurement_pkey PRIMARY KEY (id_reference_point_measurement);


--
-- TOC entry 5976 (class 2606 OID 33262)
-- Name: reference_point reference_point_pkey; Type: CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point
    ADD CONSTRAINT reference_point_pkey PRIMARY KEY (id_reference_point);


--
-- TOC entry 5980 (class 2606 OID 33266)
-- Name: setup setup_pkey; Type: CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.setup
    ADD CONSTRAINT setup_pkey PRIMARY KEY (id_setup);


--
-- TOC entry 5982 (class 2606 OID 33268)
-- Name: setup_reference_point setup_reference_point_pkey; Type: CONSTRAINT; Schema: rtls_measurement_2; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_2.setup_reference_point
    ADD CONSTRAINT setup_reference_point_pkey PRIMARY KEY (id_setup, id_reference_point);


--
-- TOC entry 5986 (class 2606 OID 33280)
-- Name: batch_job_execution_context batch_job_execution_context_pkey; Type: CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_execution_context
    ADD CONSTRAINT batch_job_execution_context_pkey PRIMARY KEY (job_execution_id);


--
-- TOC entry 5984 (class 2606 OID 33272)
-- Name: batch_job_execution batch_job_execution_pkey; Type: CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_execution
    ADD CONSTRAINT batch_job_execution_pkey PRIMARY KEY (job_execution_id);


--
-- TOC entry 5988 (class 2606 OID 33270)
-- Name: batch_job_instance batch_job_instance_pkey; Type: CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_instance
    ADD CONSTRAINT batch_job_instance_pkey PRIMARY KEY (job_instance_id);


--
-- TOC entry 5994 (class 2606 OID 33276)
-- Name: batch_step_execution_context batch_step_execution_context_pkey; Type: CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_step_execution_context
    ADD CONSTRAINT batch_step_execution_context_pkey PRIMARY KEY (step_execution_id);


--
-- TOC entry 5992 (class 2606 OID 33274)
-- Name: batch_step_execution batch_step_execution_pkey; Type: CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_step_execution
    ADD CONSTRAINT batch_step_execution_pkey PRIMARY KEY (step_execution_id);


--
-- TOC entry 5990 (class 2606 OID 33278)
-- Name: batch_job_instance job_inst_un; Type: CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_instance
    ADD CONSTRAINT job_inst_un UNIQUE (job_name, job_key);


--
-- TOC entry 5996 (class 2606 OID 33228)
-- Name: device_status device_status_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status
    ADD CONSTRAINT device_status_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 5998 (class 2606 OID 33360)
-- Name: device_status_2026_01_19 device_status_2026_01_19_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_01_19
    ADD CONSTRAINT device_status_2026_01_19_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6000 (class 2606 OID 33415)
-- Name: device_status_2026_01_26 device_status_2026_01_26_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_01_26
    ADD CONSTRAINT device_status_2026_01_26_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6002 (class 2606 OID 33286)
-- Name: device_status_2026_02_02 device_status_2026_02_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_02_02
    ADD CONSTRAINT device_status_2026_02_02_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6004 (class 2606 OID 33302)
-- Name: device_status_2026_02_09 device_status_2026_02_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_02_09
    ADD CONSTRAINT device_status_2026_02_09_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6006 (class 2606 OID 33319)
-- Name: device_status_2026_02_16 device_status_2026_02_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_02_16
    ADD CONSTRAINT device_status_2026_02_16_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6008 (class 2606 OID 33336)
-- Name: device_status_2026_02_23 device_status_2026_02_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_02_23
    ADD CONSTRAINT device_status_2026_02_23_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6010 (class 2606 OID 33348)
-- Name: device_status_2026_03_02 device_status_2026_03_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_03_02
    ADD CONSTRAINT device_status_2026_03_02_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6012 (class 2606 OID 33383)
-- Name: device_status_2026_03_09 device_status_2026_03_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_03_09
    ADD CONSTRAINT device_status_2026_03_09_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6014 (class 2606 OID 33398)
-- Name: device_status_2026_03_16 device_status_2026_03_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_03_16
    ADD CONSTRAINT device_status_2026_03_16_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6016 (class 2606 OID 33438)
-- Name: device_status_2026_03_23 device_status_2026_03_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_03_23
    ADD CONSTRAINT device_status_2026_03_23_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6018 (class 2606 OID 33449)
-- Name: device_status_2026_03_30 device_status_2026_03_30_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_03_30
    ADD CONSTRAINT device_status_2026_03_30_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6020 (class 2606 OID 33466)
-- Name: device_status_2026_04_06 device_status_2026_04_06_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_04_06
    ADD CONSTRAINT device_status_2026_04_06_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6022 (class 2606 OID 33483)
-- Name: device_status_2026_04_13 device_status_2026_04_13_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_04_13
    ADD CONSTRAINT device_status_2026_04_13_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6024 (class 2606 OID 33500)
-- Name: device_status_2026_04_20 device_status_2026_04_20_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_04_20
    ADD CONSTRAINT device_status_2026_04_20_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6026 (class 2606 OID 33523)
-- Name: device_status_2026_04_27 device_status_2026_04_27_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_04_27
    ADD CONSTRAINT device_status_2026_04_27_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6311 (class 2606 OID 36088)
-- Name: device_status_2026_05_04 device_status_2026_05_04_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_05_04
    ADD CONSTRAINT device_status_2026_05_04_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6328 (class 2606 OID 36598)
-- Name: device_status_2026_05_11 device_status_2026_05_11_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_05_11
    ADD CONSTRAINT device_status_2026_05_11_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6345 (class 2606 OID 37065)
-- Name: device_status_2026_05_18 device_status_2026_05_18_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_05_18
    ADD CONSTRAINT device_status_2026_05_18_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6362 (class 2606 OID 37724)
-- Name: device_status_2026_05_25 device_status_2026_05_25_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_05_25
    ADD CONSTRAINT device_status_2026_05_25_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6379 (class 2606 OID 38188)
-- Name: device_status_2026_06_01 device_status_2026_06_01_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.device_status_2026_06_01
    ADD CONSTRAINT device_status_2026_06_01_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6028 (class 2606 OID 33244)
-- Name: gateway_info gateway_info_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info
    ADD CONSTRAINT gateway_info_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6032 (class 2606 OID 33379)
-- Name: gateway_info_2026_01_19 gateway_info_2026_01_19_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_01_19
    ADD CONSTRAINT gateway_info_2026_01_19_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6035 (class 2606 OID 33430)
-- Name: gateway_info_2026_01_26 gateway_info_2026_01_26_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_01_26
    ADD CONSTRAINT gateway_info_2026_01_26_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6038 (class 2606 OID 33296)
-- Name: gateway_info_2026_02_02 gateway_info_2026_02_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_02_02
    ADD CONSTRAINT gateway_info_2026_02_02_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6041 (class 2606 OID 33311)
-- Name: gateway_info_2026_02_09 gateway_info_2026_02_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_02_09
    ADD CONSTRAINT gateway_info_2026_02_09_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6044 (class 2606 OID 33328)
-- Name: gateway_info_2026_02_16 gateway_info_2026_02_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_02_16
    ADD CONSTRAINT gateway_info_2026_02_16_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6047 (class 2606 OID 33342)
-- Name: gateway_info_2026_02_23 gateway_info_2026_02_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_02_23
    ADD CONSTRAINT gateway_info_2026_02_23_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6050 (class 2606 OID 33368)
-- Name: gateway_info_2026_03_02 gateway_info_2026_03_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_03_02
    ADD CONSTRAINT gateway_info_2026_03_02_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6053 (class 2606 OID 33394)
-- Name: gateway_info_2026_03_09 gateway_info_2026_03_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_03_09
    ADD CONSTRAINT gateway_info_2026_03_09_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6056 (class 2606 OID 33411)
-- Name: gateway_info_2026_03_16 gateway_info_2026_03_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_03_16
    ADD CONSTRAINT gateway_info_2026_03_16_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6059 (class 2606 OID 33445)
-- Name: gateway_info_2026_03_23 gateway_info_2026_03_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_03_23
    ADD CONSTRAINT gateway_info_2026_03_23_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6062 (class 2606 OID 33462)
-- Name: gateway_info_2026_03_30 gateway_info_2026_03_30_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_03_30
    ADD CONSTRAINT gateway_info_2026_03_30_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6065 (class 2606 OID 33479)
-- Name: gateway_info_2026_04_06 gateway_info_2026_04_06_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_04_06
    ADD CONSTRAINT gateway_info_2026_04_06_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6068 (class 2606 OID 33496)
-- Name: gateway_info_2026_04_13 gateway_info_2026_04_13_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_04_13
    ADD CONSTRAINT gateway_info_2026_04_13_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6071 (class 2606 OID 33513)
-- Name: gateway_info_2026_04_20 gateway_info_2026_04_20_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_04_20
    ADD CONSTRAINT gateway_info_2026_04_20_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6074 (class 2606 OID 33529)
-- Name: gateway_info_2026_04_27 gateway_info_2026_04_27_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_04_27
    ADD CONSTRAINT gateway_info_2026_04_27_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6322 (class 2606 OID 36126)
-- Name: gateway_info_2026_05_04 gateway_info_2026_05_04_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_05_04
    ADD CONSTRAINT gateway_info_2026_05_04_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6339 (class 2606 OID 36636)
-- Name: gateway_info_2026_05_11 gateway_info_2026_05_11_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_05_11
    ADD CONSTRAINT gateway_info_2026_05_11_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6356 (class 2606 OID 37103)
-- Name: gateway_info_2026_05_18 gateway_info_2026_05_18_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_05_18
    ADD CONSTRAINT gateway_info_2026_05_18_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6373 (class 2606 OID 37762)
-- Name: gateway_info_2026_05_25 gateway_info_2026_05_25_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_05_25
    ADD CONSTRAINT gateway_info_2026_05_25_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6390 (class 2606 OID 38226)
-- Name: gateway_info_2026_06_01 gateway_info_2026_06_01_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.gateway_info_2026_06_01
    ADD CONSTRAINT gateway_info_2026_06_01_pkey PRIMARY KEY ("time", id_gateway);


--
-- TOC entry 6080 (class 2606 OID 33240)
-- Name: position position_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6083 (class 2606 OID 33385)
-- Name: position_2026_01_19 position_2026_01_19_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_01_19
    ADD CONSTRAINT position_2026_01_19_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6089 (class 2606 OID 33434)
-- Name: position_2026_01_26 position_2026_01_26_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_01_26
    ADD CONSTRAINT position_2026_01_26_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6095 (class 2606 OID 33298)
-- Name: position_2026_02_02 position_2026_02_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_02_02
    ADD CONSTRAINT position_2026_02_02_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6101 (class 2606 OID 33317)
-- Name: position_2026_02_09 position_2026_02_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_02_09
    ADD CONSTRAINT position_2026_02_09_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6107 (class 2606 OID 33332)
-- Name: position_2026_02_16 position_2026_02_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_02_16
    ADD CONSTRAINT position_2026_02_16_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6113 (class 2606 OID 33346)
-- Name: position_2026_02_23 position_2026_02_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_02_23
    ADD CONSTRAINT position_2026_02_23_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6119 (class 2606 OID 33356)
-- Name: position_2026_03_02 position_2026_03_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_03_02
    ADD CONSTRAINT position_2026_03_02_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6125 (class 2606 OID 33400)
-- Name: position_2026_03_09 position_2026_03_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_03_09
    ADD CONSTRAINT position_2026_03_09_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6131 (class 2606 OID 33417)
-- Name: position_2026_03_16 position_2026_03_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_03_16
    ADD CONSTRAINT position_2026_03_16_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6137 (class 2606 OID 33451)
-- Name: position_2026_03_23 position_2026_03_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_03_23
    ADD CONSTRAINT position_2026_03_23_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6143 (class 2606 OID 33468)
-- Name: position_2026_03_30 position_2026_03_30_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_03_30
    ADD CONSTRAINT position_2026_03_30_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6149 (class 2606 OID 33485)
-- Name: position_2026_04_06 position_2026_04_06_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_04_06
    ADD CONSTRAINT position_2026_04_06_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6155 (class 2606 OID 33502)
-- Name: position_2026_04_13 position_2026_04_13_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_04_13
    ADD CONSTRAINT position_2026_04_13_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6161 (class 2606 OID 33519)
-- Name: position_2026_04_20 position_2026_04_20_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_04_20
    ADD CONSTRAINT position_2026_04_20_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6167 (class 2606 OID 33534)
-- Name: position_2026_04_27 position_2026_04_27_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_04_27
    ADD CONSTRAINT position_2026_04_27_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6314 (class 2606 OID 36102)
-- Name: position_2026_05_04 position_2026_05_04_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_05_04
    ADD CONSTRAINT position_2026_05_04_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6331 (class 2606 OID 36612)
-- Name: position_2026_05_11 position_2026_05_11_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_05_11
    ADD CONSTRAINT position_2026_05_11_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6348 (class 2606 OID 37079)
-- Name: position_2026_05_18 position_2026_05_18_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_05_18
    ADD CONSTRAINT position_2026_05_18_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6365 (class 2606 OID 37738)
-- Name: position_2026_05_25 position_2026_05_25_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_05_25
    ADD CONSTRAINT position_2026_05_25_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6382 (class 2606 OID 38202)
-- Name: position_2026_06_01 position_2026_06_01_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_2026_06_01
    ADD CONSTRAINT position_2026_06_01_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6172 (class 2606 OID 33234)
-- Name: position_area position_area_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area
    ADD CONSTRAINT position_area_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6174 (class 2606 OID 33377)
-- Name: position_area_2026_01_19 position_area_2026_01_19_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_01_19
    ADD CONSTRAINT position_area_2026_01_19_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6176 (class 2606 OID 33428)
-- Name: position_area_2026_01_26 position_area_2026_01_26_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_01_26
    ADD CONSTRAINT position_area_2026_01_26_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6178 (class 2606 OID 33292)
-- Name: position_area_2026_02_02 position_area_2026_02_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_02_02
    ADD CONSTRAINT position_area_2026_02_02_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6180 (class 2606 OID 33309)
-- Name: position_area_2026_02_09 position_area_2026_02_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_02_09
    ADD CONSTRAINT position_area_2026_02_09_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6182 (class 2606 OID 33326)
-- Name: position_area_2026_02_16 position_area_2026_02_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_02_16
    ADD CONSTRAINT position_area_2026_02_16_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6184 (class 2606 OID 33352)
-- Name: position_area_2026_02_23 position_area_2026_02_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_02_23
    ADD CONSTRAINT position_area_2026_02_23_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6186 (class 2606 OID 33366)
-- Name: position_area_2026_03_02 position_area_2026_03_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_03_02
    ADD CONSTRAINT position_area_2026_03_02_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6188 (class 2606 OID 33402)
-- Name: position_area_2026_03_09 position_area_2026_03_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_03_09
    ADD CONSTRAINT position_area_2026_03_09_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6190 (class 2606 OID 33419)
-- Name: position_area_2026_03_16 position_area_2026_03_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_03_16
    ADD CONSTRAINT position_area_2026_03_16_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6192 (class 2606 OID 33453)
-- Name: position_area_2026_03_23 position_area_2026_03_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_03_23
    ADD CONSTRAINT position_area_2026_03_23_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6194 (class 2606 OID 33470)
-- Name: position_area_2026_03_30 position_area_2026_03_30_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_03_30
    ADD CONSTRAINT position_area_2026_03_30_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6196 (class 2606 OID 33487)
-- Name: position_area_2026_04_06 position_area_2026_04_06_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_04_06
    ADD CONSTRAINT position_area_2026_04_06_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6198 (class 2606 OID 33504)
-- Name: position_area_2026_04_13 position_area_2026_04_13_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_04_13
    ADD CONSTRAINT position_area_2026_04_13_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6200 (class 2606 OID 33521)
-- Name: position_area_2026_04_20 position_area_2026_04_20_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_04_20
    ADD CONSTRAINT position_area_2026_04_20_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6202 (class 2606 OID 33532)
-- Name: position_area_2026_04_27 position_area_2026_04_27_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_04_27
    ADD CONSTRAINT position_area_2026_04_27_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6319 (class 2606 OID 36115)
-- Name: position_area_2026_05_04 position_area_2026_05_04_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_05_04
    ADD CONSTRAINT position_area_2026_05_04_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6336 (class 2606 OID 36625)
-- Name: position_area_2026_05_11 position_area_2026_05_11_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_05_11
    ADD CONSTRAINT position_area_2026_05_11_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6353 (class 2606 OID 37092)
-- Name: position_area_2026_05_18 position_area_2026_05_18_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_05_18
    ADD CONSTRAINT position_area_2026_05_18_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6370 (class 2606 OID 37751)
-- Name: position_area_2026_05_25 position_area_2026_05_25_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_05_25
    ADD CONSTRAINT position_area_2026_05_25_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6387 (class 2606 OID 38215)
-- Name: position_area_2026_06_01 position_area_2026_06_01_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.position_area_2026_06_01
    ADD CONSTRAINT position_area_2026_06_01_pkey PRIMARY KEY ("time", id_device, id_area);


--
-- TOC entry 6204 (class 2606 OID 33236)
-- Name: ranging ranging_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging
    ADD CONSTRAINT ranging_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6206 (class 2606 OID 33370)
-- Name: ranging_2026_01_19 ranging_2026_01_19_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_01_19
    ADD CONSTRAINT ranging_2026_01_19_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6208 (class 2606 OID 33422)
-- Name: ranging_2026_01_26 ranging_2026_01_26_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_01_26
    ADD CONSTRAINT ranging_2026_01_26_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6210 (class 2606 OID 33246)
-- Name: ranging_2026_02_02 ranging_2026_02_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_02_02
    ADD CONSTRAINT ranging_2026_02_02_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6212 (class 2606 OID 33294)
-- Name: ranging_2026_02_09 ranging_2026_02_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_02_09
    ADD CONSTRAINT ranging_2026_02_09_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6214 (class 2606 OID 33316)
-- Name: ranging_2026_02_16 ranging_2026_02_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_02_16
    ADD CONSTRAINT ranging_2026_02_16_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6216 (class 2606 OID 33334)
-- Name: ranging_2026_02_23 ranging_2026_02_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_02_23
    ADD CONSTRAINT ranging_2026_02_23_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6218 (class 2606 OID 33353)
-- Name: ranging_2026_03_02 ranging_2026_03_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_03_02
    ADD CONSTRAINT ranging_2026_03_02_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6220 (class 2606 OID 33387)
-- Name: ranging_2026_03_09 ranging_2026_03_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_03_09
    ADD CONSTRAINT ranging_2026_03_09_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6222 (class 2606 OID 33404)
-- Name: ranging_2026_03_16 ranging_2026_03_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_03_16
    ADD CONSTRAINT ranging_2026_03_16_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6224 (class 2606 OID 33436)
-- Name: ranging_2026_03_23 ranging_2026_03_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_03_23
    ADD CONSTRAINT ranging_2026_03_23_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6226 (class 2606 OID 33455)
-- Name: ranging_2026_03_30 ranging_2026_03_30_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_03_30
    ADD CONSTRAINT ranging_2026_03_30_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6228 (class 2606 OID 33472)
-- Name: ranging_2026_04_06 ranging_2026_04_06_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_04_06
    ADD CONSTRAINT ranging_2026_04_06_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6230 (class 2606 OID 33489)
-- Name: ranging_2026_04_13 ranging_2026_04_13_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_04_13
    ADD CONSTRAINT ranging_2026_04_13_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6232 (class 2606 OID 33506)
-- Name: ranging_2026_04_20 ranging_2026_04_20_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_04_20
    ADD CONSTRAINT ranging_2026_04_20_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6234 (class 2606 OID 33515)
-- Name: ranging_2026_04_27 ranging_2026_04_27_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_04_27
    ADD CONSTRAINT ranging_2026_04_27_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6307 (class 2606 OID 36062)
-- Name: ranging_2026_05_04 ranging_2026_05_04_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_05_04
    ADD CONSTRAINT ranging_2026_05_04_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6324 (class 2606 OID 36572)
-- Name: ranging_2026_05_11 ranging_2026_05_11_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_05_11
    ADD CONSTRAINT ranging_2026_05_11_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6341 (class 2606 OID 37039)
-- Name: ranging_2026_05_18 ranging_2026_05_18_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_05_18
    ADD CONSTRAINT ranging_2026_05_18_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6358 (class 2606 OID 37698)
-- Name: ranging_2026_05_25 ranging_2026_05_25_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_05_25
    ADD CONSTRAINT ranging_2026_05_25_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6375 (class 2606 OID 38162)
-- Name: ranging_2026_06_01 ranging_2026_06_01_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_2026_06_01
    ADD CONSTRAINT ranging_2026_06_01_pkey PRIMARY KEY ("time", id_device);


--
-- TOC entry 6236 (class 2606 OID 33238)
-- Name: ranging_item ranging_item_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item
    ADD CONSTRAINT ranging_item_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6238 (class 2606 OID 33361)
-- Name: ranging_item_2026_01_19 ranging_item_2026_01_19_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_01_19
    ADD CONSTRAINT ranging_item_2026_01_19_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6240 (class 2606 OID 33413)
-- Name: ranging_item_2026_01_26 ranging_item_2026_01_26_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_01_26
    ADD CONSTRAINT ranging_item_2026_01_26_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6242 (class 2606 OID 33285)
-- Name: ranging_item_2026_02_02 ranging_item_2026_02_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_02_02
    ADD CONSTRAINT ranging_item_2026_02_02_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6244 (class 2606 OID 33300)
-- Name: ranging_item_2026_02_09 ranging_item_2026_02_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_02_09
    ADD CONSTRAINT ranging_item_2026_02_09_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6246 (class 2606 OID 33313)
-- Name: ranging_item_2026_02_16 ranging_item_2026_02_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_02_16
    ADD CONSTRAINT ranging_item_2026_02_16_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6248 (class 2606 OID 33330)
-- Name: ranging_item_2026_02_23 ranging_item_2026_02_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_02_23
    ADD CONSTRAINT ranging_item_2026_02_23_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6250 (class 2606 OID 33345)
-- Name: ranging_item_2026_03_02 ranging_item_2026_03_02_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_03_02
    ADD CONSTRAINT ranging_item_2026_03_02_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6252 (class 2606 OID 33381)
-- Name: ranging_item_2026_03_09 ranging_item_2026_03_09_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_03_09
    ADD CONSTRAINT ranging_item_2026_03_09_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6254 (class 2606 OID 33396)
-- Name: ranging_item_2026_03_16 ranging_item_2026_03_16_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_03_16
    ADD CONSTRAINT ranging_item_2026_03_16_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6256 (class 2606 OID 33432)
-- Name: ranging_item_2026_03_23 ranging_item_2026_03_23_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_03_23
    ADD CONSTRAINT ranging_item_2026_03_23_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6258 (class 2606 OID 33447)
-- Name: ranging_item_2026_03_30 ranging_item_2026_03_30_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_03_30
    ADD CONSTRAINT ranging_item_2026_03_30_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6260 (class 2606 OID 33464)
-- Name: ranging_item_2026_04_06 ranging_item_2026_04_06_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_04_06
    ADD CONSTRAINT ranging_item_2026_04_06_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6262 (class 2606 OID 33481)
-- Name: ranging_item_2026_04_13 ranging_item_2026_04_13_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_04_13
    ADD CONSTRAINT ranging_item_2026_04_13_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6264 (class 2606 OID 33498)
-- Name: ranging_item_2026_04_20 ranging_item_2026_04_20_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_04_20
    ADD CONSTRAINT ranging_item_2026_04_20_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6266 (class 2606 OID 33517)
-- Name: ranging_item_2026_04_27 ranging_item_2026_04_27_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_04_27
    ADD CONSTRAINT ranging_item_2026_04_27_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6309 (class 2606 OID 36074)
-- Name: ranging_item_2026_05_04 ranging_item_2026_05_04_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_05_04
    ADD CONSTRAINT ranging_item_2026_05_04_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6326 (class 2606 OID 36584)
-- Name: ranging_item_2026_05_11 ranging_item_2026_05_11_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_05_11
    ADD CONSTRAINT ranging_item_2026_05_11_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6343 (class 2606 OID 37051)
-- Name: ranging_item_2026_05_18 ranging_item_2026_05_18_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_05_18
    ADD CONSTRAINT ranging_item_2026_05_18_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6360 (class 2606 OID 37710)
-- Name: ranging_item_2026_05_25 ranging_item_2026_05_25_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_05_25
    ADD CONSTRAINT ranging_item_2026_05_25_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6377 (class 2606 OID 38174)
-- Name: ranging_item_2026_06_01 ranging_item_2026_06_01_pkey; Type: CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_timeseries.ranging_item_2026_06_01
    ADD CONSTRAINT ranging_item_2026_06_01_pkey PRIMARY KEY ("time", id_ranging_item);


--
-- TOC entry 6271 (class 2606 OID 33110)
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 6269 (class 2606 OID 32990)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 6273 (class 2606 OID 33155)
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- TOC entry 6276 (class 2606 OID 33163)
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- TOC entry 6279 (class 2606 OID 33001)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 6281 (class 2606 OID 33009)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 6289 (class 2606 OID 33003)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 6292 (class 2606 OID 33159)
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- TOC entry 6297 (class 2606 OID 33148)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 6295 (class 2606 OID 33150)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 6299 (class 2606 OID 33011)
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- TOC entry 6303 (class 2606 OID 33005)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 6305 (class 2606 OID 33018)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 5731 (class 1259 OID 33111)
-- Name: alert_queries_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX alert_queries_token_index ON _analytics.alert_queries USING btree (token);


--
-- TOC entry 5732 (class 1259 OID 33112)
-- Name: alert_queries_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX alert_queries_user_id_index ON _analytics.alert_queries USING btree (user_id);


--
-- TOC entry 5737 (class 1259 OID 33064)
-- Name: billing_accounts_stripe_customer_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX billing_accounts_stripe_customer_index ON _analytics.billing_accounts USING btree (stripe_customer);


--
-- TOC entry 5738 (class 1259 OID 33065)
-- Name: billing_accounts_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX billing_accounts_user_id_index ON _analytics.billing_accounts USING btree (user_id);


--
-- TOC entry 5739 (class 1259 OID 33081)
-- Name: billing_counts_inserted_at_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX billing_counts_inserted_at_index ON _analytics.billing_counts USING btree (inserted_at);


--
-- TOC entry 5742 (class 1259 OID 33083)
-- Name: billing_counts_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX billing_counts_source_id_index ON _analytics.billing_counts USING btree (source_id);


--
-- TOC entry 5743 (class 1259 OID 33084)
-- Name: billing_counts_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX billing_counts_user_id_index ON _analytics.billing_counts USING btree (user_id);


--
-- TOC entry 5746 (class 1259 OID 33075)
-- Name: endpoint_queries_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX endpoint_queries_token_index ON _analytics.endpoint_queries USING btree (token);


--
-- TOC entry 5747 (class 1259 OID 33080)
-- Name: endpoint_queries_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX endpoint_queries_user_id_index ON _analytics.endpoint_queries USING btree (user_id);


--
-- TOC entry 5750 (class 1259 OID 33125)
-- Name: log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5_timestamp_brin_ ON _analytics.log_events_0cf8b9b8_3a28_463b_a8bc_c5599b39acc5 USING brin ("timestamp");


--
-- TOC entry 5753 (class 1259 OID 33138)
-- Name: log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e_timestamp_brin_ ON _analytics.log_events_23743b1b_4978_46e2_bd15_a93dc7d0903e USING brin ("timestamp");


--
-- TOC entry 5756 (class 1259 OID 33131)
-- Name: log_events_28d2ec64_d503_46e0_b858_c62a2a9de000_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_28d2ec64_d503_46e0_b858_c62a2a9de000_timestamp_brin_ ON _analytics.log_events_28d2ec64_d503_46e0_b858_c62a2a9de000 USING brin ("timestamp");


--
-- TOC entry 5759 (class 1259 OID 33142)
-- Name: log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492_timestamp_brin_ ON _analytics.log_events_997962cf_6523_4afa_bcc0_7c5a2ec11492 USING brin ("timestamp");


--
-- TOC entry 5762 (class 1259 OID 33130)
-- Name: log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb_timestamp_brin_ ON _analytics.log_events_9c8d76f8_811c_4b1b_a3e8_8f717b92f4eb USING brin ("timestamp");


--
-- TOC entry 5765 (class 1259 OID 33124)
-- Name: log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72_timestamp_brin_ ON _analytics.log_events_cbcccb4e_3a9d_4bf8_89ca_1dbf071b5b72 USING brin ("timestamp");


--
-- TOC entry 5768 (class 1259 OID 33121)
-- Name: log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9_timestamp_brin_ ON _analytics.log_events_e8e47c48_7135_47b9_85ca_168f453c3cd9 USING brin ("timestamp");


--
-- TOC entry 5771 (class 1259 OID 33144)
-- Name: log_events_f2cf0b56_836d_420d_84c0_639871495297_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_f2cf0b56_836d_420d_84c0_639871495297_timestamp_brin_ ON _analytics.log_events_f2cf0b56_836d_420d_84c0_639871495297 USING brin ("timestamp");


--
-- TOC entry 5774 (class 1259 OID 33132)
-- Name: log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27_timestamp_brin_ ON _analytics.log_events_f74f6825_cc8d_4fa5_ad6b_30fbb151dd27 USING brin ("timestamp");


--
-- TOC entry 5777 (class 1259 OID 33045)
-- Name: oauth_access_grants_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_access_grants_token_index ON _analytics.oauth_access_grants USING btree (token);


--
-- TOC entry 5780 (class 1259 OID 33046)
-- Name: oauth_access_tokens_refresh_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_access_tokens_refresh_token_index ON _analytics.oauth_access_tokens USING btree (refresh_token);


--
-- TOC entry 5781 (class 1259 OID 33047)
-- Name: oauth_access_tokens_resource_owner_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX oauth_access_tokens_resource_owner_id_index ON _analytics.oauth_access_tokens USING btree (resource_owner_id);


--
-- TOC entry 5782 (class 1259 OID 33048)
-- Name: oauth_access_tokens_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_access_tokens_token_index ON _analytics.oauth_access_tokens USING btree (token);


--
-- TOC entry 5783 (class 1259 OID 33027)
-- Name: oauth_applications_owner_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX oauth_applications_owner_id_index ON _analytics.oauth_applications USING btree (owner_id);


--
-- TOC entry 5786 (class 1259 OID 33044)
-- Name: oauth_applications_uid_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_applications_uid_index ON _analytics.oauth_applications USING btree (uid);


--
-- TOC entry 5787 (class 1259 OID 33089)
-- Name: partner_users_partner_id_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX partner_users_partner_id_user_id_index ON _analytics.partner_users USING btree (partner_id, user_id);


--
-- TOC entry 5788 (class 1259 OID 33094)
-- Name: partner_users_partner_id_user_id_upgraded_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX partner_users_partner_id_user_id_upgraded_index ON _analytics.partner_users USING btree (partner_id, user_id, upgraded);


--
-- TOC entry 5793 (class 1259 OID 33071)
-- Name: payment_methods_customer_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX payment_methods_customer_id_index ON _analytics.payment_methods USING btree (customer_id);


--
-- TOC entry 5796 (class 1259 OID 33082)
-- Name: payment_methods_stripe_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX payment_methods_stripe_id_index ON _analytics.payment_methods USING btree (stripe_id);


--
-- TOC entry 5801 (class 1259 OID 33024)
-- Name: rules_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX rules_source_id_index ON _analytics.rules USING btree (source_id);


--
-- TOC entry 5802 (class 1259 OID 33025)
-- Name: rules_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX rules_token_index ON _analytics.rules USING btree (token);


--
-- TOC entry 5805 (class 1259 OID 33072)
-- Name: saved_search_counters_timestamp_saved_search_id_granularity_ind; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX saved_search_counters_timestamp_saved_search_id_granularity_ind ON _analytics.saved_search_counters USING btree ("timestamp", saved_search_id, granularity);


--
-- TOC entry 5808 (class 1259 OID 33059)
-- Name: saved_searches_querystring_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX saved_searches_querystring_source_id_index ON _analytics.saved_searches USING btree (querystring, source_id);


--
-- TOC entry 5815 (class 1259 OID 33070)
-- Name: source_schemas_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX source_schemas_source_id_index ON _analytics.source_schemas USING btree (source_id);


--
-- TOC entry 5816 (class 1259 OID 33012)
-- Name: sources_name_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_name_index ON _analytics.sources USING btree (id, name);


--
-- TOC entry 5819 (class 1259 OID 33013)
-- Name: sources_public_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_public_token_index ON _analytics.sources USING btree (public_token);


--
-- TOC entry 5820 (class 1259 OID 33014)
-- Name: sources_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_token_index ON _analytics.sources USING btree (token);


--
-- TOC entry 5821 (class 1259 OID 33023)
-- Name: sources_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX sources_user_id_index ON _analytics.sources USING btree (user_id);


--
-- TOC entry 5824 (class 1259 OID 33043)
-- Name: system_metrics_node_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX system_metrics_node_index ON _analytics.system_metrics USING btree (node);


--
-- TOC entry 5829 (class 1259 OID 33062)
-- Name: team_users_provider_uid_team_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX team_users_provider_uid_team_id_index ON _analytics.team_users USING btree (provider_uid, team_id);


--
-- TOC entry 5830 (class 1259 OID 33063)
-- Name: team_users_team_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX team_users_team_id_index ON _analytics.team_users USING btree (team_id);


--
-- TOC entry 5833 (class 1259 OID 33060)
-- Name: teams_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX teams_token_index ON _analytics.teams USING btree (token);


--
-- TOC entry 5834 (class 1259 OID 33061)
-- Name: teams_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX teams_user_id_index ON _analytics.teams USING btree (user_id);


--
-- TOC entry 5835 (class 1259 OID 32974)
-- Name: users_api_key_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX users_api_key_index ON _analytics.users USING btree (api_key);


--
-- TOC entry 5836 (class 1259 OID 32999)
-- Name: users_lower_email_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX users_lower_email_index ON _analytics.users USING btree (lower((email)::text));


--
-- TOC entry 5843 (class 1259 OID 32973)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 5910 (class 1259 OID 32958)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5911 (class 1259 OID 32960)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5912 (class 1259 OID 32959)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5864 (class 1259 OID 33141)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 5844 (class 1259 OID 33186)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 5849 (class 1259 OID 33117)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 8014 (class 0 OID 0)
-- Dependencies: 5849
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 5854 (class 1259 OID 33135)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 5847 (class 1259 OID 33197)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 5848 (class 1259 OID 33198)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 5861 (class 1259 OID 33166)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 5869 (class 1259 OID 33160)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 5870 (class 1259 OID 33164)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 5874 (class 1259 OID 33204)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 5875 (class 1259 OID 33205)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 5876 (class 1259 OID 33206)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 5913 (class 1259 OID 32961)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5914 (class 1259 OID 32962)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 5877 (class 1259 OID 32967)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 5878 (class 1259 OID 32968)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 5879 (class 1259 OID 32969)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 5882 (class 1259 OID 32972)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 5885 (class 1259 OID 32991)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 5890 (class 1259 OID 33178)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 5891 (class 1259 OID 33180)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 5892 (class 1259 OID 33185)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 5895 (class 1259 OID 33187)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 5898 (class 1259 OID 33120)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 5901 (class 1259 OID 33136)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 5903 (class 1259 OID 33176)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 5906 (class 1259 OID 33177)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 5909 (class 1259 OID 33181)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 5871 (class 1259 OID 33165)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 5902 (class 1259 OID 33137)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 5915 (class 1259 OID 32963)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 8015 (class 0 OID 0)
-- Dependencies: 5915
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 5916 (class 1259 OID 32964)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 5917 (class 1259 OID 32965)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 5918 (class 1259 OID 32966)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 5957 (class 1259 OID 33214)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX flyway_schema_history_s_idx ON rtls_config.flyway_schema_history USING btree (success);


--
-- TOC entry 5945 (class 1259 OID 33225)
-- Name: idx_area_geom; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_area_geom ON rtls_config.area USING gist (geom);


--
-- TOC entry 5946 (class 1259 OID 33226)
-- Name: idx_area_hierarchy_path_gin; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_area_hierarchy_path_gin ON rtls_config.area USING gin (hierarchy_path);


--
-- TOC entry 5947 (class 1259 OID 33203)
-- Name: idx_area_parent; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_area_parent ON rtls_config.area USING btree (parent_area_id);


--
-- TOC entry 5952 (class 1259 OID 33190)
-- Name: idx_asset_id_asset_type; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_asset_id_asset_type ON rtls_config.asset USING btree (id_asset_type);


--
-- TOC entry 5964 (class 1259 OID 33195)
-- Name: idx_cfg_pos_gps_gist; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_cfg_pos_gps_gist ON rtls_config.uwb_device USING gist (cfg_pos_gps);


--
-- TOC entry 5965 (class 1259 OID 33213)
-- Name: idx_cfg_pos_xyz_gist; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_cfg_pos_xyz_gist ON rtls_config.uwb_device USING gist (cfg_pos_xyz);


--
-- TOC entry 5966 (class 1259 OID 33196)
-- Name: idx_uwb_device_config_gin; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_uwb_device_config_gin ON rtls_config.uwb_device USING gin (config);


--
-- TOC entry 5967 (class 1259 OID 33201)
-- Name: idx_uwb_device_device_created_at; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_uwb_device_device_created_at ON rtls_config.uwb_device USING btree (uwb_device_id, created_at DESC);


--
-- TOC entry 5968 (class 1259 OID 33202)
-- Name: idx_uwb_device_id_asset; Type: INDEX; Schema: rtls_config; Owner: supabase_admin
--

CREATE INDEX idx_uwb_device_id_asset ON rtls_config.uwb_device USING btree (id_asset);


--
-- TOC entry 6029 (class 1259 OID 33250)
-- Name: idx_gateway_info_info; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX idx_gateway_info_info ON ONLY rtls_timeseries.gateway_info USING gin (info jsonb_path_ops);


--
-- TOC entry 6030 (class 1259 OID 33373)
-- Name: gateway_info_2026_01_19_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_01_19_info_idx ON rtls_timeseries.gateway_info_2026_01_19 USING gin (info jsonb_path_ops);


--
-- TOC entry 6033 (class 1259 OID 33424)
-- Name: gateway_info_2026_01_26_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_01_26_info_idx ON rtls_timeseries.gateway_info_2026_01_26 USING gin (info jsonb_path_ops);


--
-- TOC entry 6036 (class 1259 OID 33289)
-- Name: gateway_info_2026_02_02_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_02_02_info_idx ON rtls_timeseries.gateway_info_2026_02_02 USING gin (info jsonb_path_ops);


--
-- TOC entry 6039 (class 1259 OID 33305)
-- Name: gateway_info_2026_02_09_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_02_09_info_idx ON rtls_timeseries.gateway_info_2026_02_09 USING gin (info jsonb_path_ops);


--
-- TOC entry 6042 (class 1259 OID 33322)
-- Name: gateway_info_2026_02_16_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_02_16_info_idx ON rtls_timeseries.gateway_info_2026_02_16 USING gin (info jsonb_path_ops);


--
-- TOC entry 6045 (class 1259 OID 33337)
-- Name: gateway_info_2026_02_23_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_02_23_info_idx ON rtls_timeseries.gateway_info_2026_02_23 USING gin (info jsonb_path_ops);


--
-- TOC entry 6048 (class 1259 OID 33357)
-- Name: gateway_info_2026_03_02_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_03_02_info_idx ON rtls_timeseries.gateway_info_2026_03_02 USING gin (info jsonb_path_ops);


--
-- TOC entry 6051 (class 1259 OID 33389)
-- Name: gateway_info_2026_03_09_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_03_09_info_idx ON rtls_timeseries.gateway_info_2026_03_09 USING gin (info jsonb_path_ops);


--
-- TOC entry 6054 (class 1259 OID 33406)
-- Name: gateway_info_2026_03_16_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_03_16_info_idx ON rtls_timeseries.gateway_info_2026_03_16 USING gin (info jsonb_path_ops);


--
-- TOC entry 6057 (class 1259 OID 33440)
-- Name: gateway_info_2026_03_23_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_03_23_info_idx ON rtls_timeseries.gateway_info_2026_03_23 USING gin (info jsonb_path_ops);


--
-- TOC entry 6060 (class 1259 OID 33457)
-- Name: gateway_info_2026_03_30_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_03_30_info_idx ON rtls_timeseries.gateway_info_2026_03_30 USING gin (info jsonb_path_ops);


--
-- TOC entry 6063 (class 1259 OID 33474)
-- Name: gateway_info_2026_04_06_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_04_06_info_idx ON rtls_timeseries.gateway_info_2026_04_06 USING gin (info jsonb_path_ops);


--
-- TOC entry 6066 (class 1259 OID 33491)
-- Name: gateway_info_2026_04_13_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_04_13_info_idx ON rtls_timeseries.gateway_info_2026_04_13 USING gin (info jsonb_path_ops);


--
-- TOC entry 6069 (class 1259 OID 33508)
-- Name: gateway_info_2026_04_20_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_04_20_info_idx ON rtls_timeseries.gateway_info_2026_04_20 USING gin (info jsonb_path_ops);


--
-- TOC entry 6072 (class 1259 OID 33525)
-- Name: gateway_info_2026_04_27_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_04_27_info_idx ON rtls_timeseries.gateway_info_2026_04_27 USING gin (info jsonb_path_ops);


--
-- TOC entry 6320 (class 1259 OID 36127)
-- Name: gateway_info_2026_05_04_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_05_04_info_idx ON rtls_timeseries.gateway_info_2026_05_04 USING gin (info jsonb_path_ops);


--
-- TOC entry 6337 (class 1259 OID 36637)
-- Name: gateway_info_2026_05_11_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_05_11_info_idx ON rtls_timeseries.gateway_info_2026_05_11 USING gin (info jsonb_path_ops);


--
-- TOC entry 6354 (class 1259 OID 37104)
-- Name: gateway_info_2026_05_18_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_05_18_info_idx ON rtls_timeseries.gateway_info_2026_05_18 USING gin (info jsonb_path_ops);


--
-- TOC entry 6371 (class 1259 OID 37763)
-- Name: gateway_info_2026_05_25_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_05_25_info_idx ON rtls_timeseries.gateway_info_2026_05_25 USING gin (info jsonb_path_ops);


--
-- TOC entry 6388 (class 1259 OID 38227)
-- Name: gateway_info_2026_06_01_info_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX gateway_info_2026_06_01_info_idx ON rtls_timeseries.gateway_info_2026_06_01 USING gin (info jsonb_path_ops);


--
-- TOC entry 6075 (class 1259 OID 33229)
-- Name: idx_position_latest_per_device; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX idx_position_latest_per_device ON ONLY rtls_timeseries."position" USING btree (id_device, "time" DESC);


--
-- TOC entry 8016 (class 0 OID 0)
-- Dependencies: 6075
-- Name: INDEX idx_position_latest_per_device; Type: COMMENT; Schema: rtls_timeseries; Owner: supabase_admin
--

COMMENT ON INDEX rtls_timeseries.idx_position_latest_per_device IS 'This index allows PostgreSQL to instantly jump to the latest postion for each device (no full scan, no sort).';


--
-- TOC entry 6076 (class 1259 OID 33230)
-- Name: idx_position_point_gps; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX idx_position_point_gps ON ONLY rtls_timeseries."position" USING gist (point_gps);


--
-- TOC entry 6077 (class 1259 OID 33231)
-- Name: idx_position_point_xyz; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX idx_position_point_xyz ON ONLY rtls_timeseries."position" USING gist (point_xyz);


--
-- TOC entry 6078 (class 1259 OID 33232)
-- Name: idx_position_probably_moved_true; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX idx_position_probably_moved_true ON ONLY rtls_timeseries."position" USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6081 (class 1259 OID 33371)
-- Name: position_2026_01_19_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_19_id_device_time_idx ON rtls_timeseries.position_2026_01_19 USING btree (id_device, "time" DESC);


--
-- TOC entry 6084 (class 1259 OID 33372)
-- Name: position_2026_01_19_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_19_point_gps_idx ON rtls_timeseries.position_2026_01_19 USING gist (point_gps);


--
-- TOC entry 6085 (class 1259 OID 33374)
-- Name: position_2026_01_19_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_19_point_xyz_idx ON rtls_timeseries.position_2026_01_19 USING gist (point_xyz);


--
-- TOC entry 6086 (class 1259 OID 33375)
-- Name: position_2026_01_19_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_19_time_id_device_idx ON rtls_timeseries.position_2026_01_19 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6087 (class 1259 OID 33421)
-- Name: position_2026_01_26_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_26_id_device_time_idx ON rtls_timeseries.position_2026_01_26 USING btree (id_device, "time" DESC);


--
-- TOC entry 6090 (class 1259 OID 33423)
-- Name: position_2026_01_26_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_26_point_gps_idx ON rtls_timeseries.position_2026_01_26 USING gist (point_gps);


--
-- TOC entry 6091 (class 1259 OID 33425)
-- Name: position_2026_01_26_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_26_point_xyz_idx ON rtls_timeseries.position_2026_01_26 USING gist (point_xyz);


--
-- TOC entry 6092 (class 1259 OID 33426)
-- Name: position_2026_01_26_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_01_26_time_id_device_idx ON rtls_timeseries.position_2026_01_26 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6093 (class 1259 OID 33287)
-- Name: position_2026_02_02_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_02_id_device_time_idx ON rtls_timeseries.position_2026_02_02 USING btree (id_device, "time" DESC);


--
-- TOC entry 6096 (class 1259 OID 33288)
-- Name: position_2026_02_02_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_02_point_gps_idx ON rtls_timeseries.position_2026_02_02 USING gist (point_gps);


--
-- TOC entry 6097 (class 1259 OID 33247)
-- Name: position_2026_02_02_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_02_point_xyz_idx ON rtls_timeseries.position_2026_02_02 USING gist (point_xyz);


--
-- TOC entry 6098 (class 1259 OID 33290)
-- Name: position_2026_02_02_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_02_time_id_device_idx ON rtls_timeseries.position_2026_02_02 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6099 (class 1259 OID 33303)
-- Name: position_2026_02_09_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_09_id_device_time_idx ON rtls_timeseries.position_2026_02_09 USING btree (id_device, "time" DESC);


--
-- TOC entry 6102 (class 1259 OID 33304)
-- Name: position_2026_02_09_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_09_point_gps_idx ON rtls_timeseries.position_2026_02_09 USING gist (point_gps);


--
-- TOC entry 6103 (class 1259 OID 33306)
-- Name: position_2026_02_09_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_09_point_xyz_idx ON rtls_timeseries.position_2026_02_09 USING gist (point_xyz);


--
-- TOC entry 6104 (class 1259 OID 33307)
-- Name: position_2026_02_09_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_09_time_id_device_idx ON rtls_timeseries.position_2026_02_09 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6105 (class 1259 OID 33320)
-- Name: position_2026_02_16_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_16_id_device_time_idx ON rtls_timeseries.position_2026_02_16 USING btree (id_device, "time" DESC);


--
-- TOC entry 6108 (class 1259 OID 33321)
-- Name: position_2026_02_16_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_16_point_gps_idx ON rtls_timeseries.position_2026_02_16 USING gist (point_gps);


--
-- TOC entry 6109 (class 1259 OID 33323)
-- Name: position_2026_02_16_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_16_point_xyz_idx ON rtls_timeseries.position_2026_02_16 USING gist (point_xyz);


--
-- TOC entry 6110 (class 1259 OID 33324)
-- Name: position_2026_02_16_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_16_time_id_device_idx ON rtls_timeseries.position_2026_02_16 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6111 (class 1259 OID 33339)
-- Name: position_2026_02_23_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_23_id_device_time_idx ON rtls_timeseries.position_2026_02_23 USING btree (id_device, "time" DESC);


--
-- TOC entry 6114 (class 1259 OID 33338)
-- Name: position_2026_02_23_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_23_point_gps_idx ON rtls_timeseries.position_2026_02_23 USING gist (point_gps);


--
-- TOC entry 6115 (class 1259 OID 33340)
-- Name: position_2026_02_23_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_23_point_xyz_idx ON rtls_timeseries.position_2026_02_23 USING gist (point_xyz);


--
-- TOC entry 6116 (class 1259 OID 33354)
-- Name: position_2026_02_23_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_02_23_time_id_device_idx ON rtls_timeseries.position_2026_02_23 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6117 (class 1259 OID 33349)
-- Name: position_2026_03_02_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_02_id_device_time_idx ON rtls_timeseries.position_2026_03_02 USING btree (id_device, "time" DESC);


--
-- TOC entry 6120 (class 1259 OID 33362)
-- Name: position_2026_03_02_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_02_point_gps_idx ON rtls_timeseries.position_2026_03_02 USING gist (point_gps);


--
-- TOC entry 6121 (class 1259 OID 33363)
-- Name: position_2026_03_02_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_02_point_xyz_idx ON rtls_timeseries.position_2026_03_02 USING gist (point_xyz);


--
-- TOC entry 6122 (class 1259 OID 33364)
-- Name: position_2026_03_02_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_02_time_id_device_idx ON rtls_timeseries.position_2026_03_02 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6123 (class 1259 OID 33388)
-- Name: position_2026_03_09_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_09_id_device_time_idx ON rtls_timeseries.position_2026_03_09 USING btree (id_device, "time" DESC);


--
-- TOC entry 6126 (class 1259 OID 33390)
-- Name: position_2026_03_09_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_09_point_gps_idx ON rtls_timeseries.position_2026_03_09 USING gist (point_gps);


--
-- TOC entry 6127 (class 1259 OID 33391)
-- Name: position_2026_03_09_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_09_point_xyz_idx ON rtls_timeseries.position_2026_03_09 USING gist (point_xyz);


--
-- TOC entry 6128 (class 1259 OID 33392)
-- Name: position_2026_03_09_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_09_time_id_device_idx ON rtls_timeseries.position_2026_03_09 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6129 (class 1259 OID 33405)
-- Name: position_2026_03_16_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_16_id_device_time_idx ON rtls_timeseries.position_2026_03_16 USING btree (id_device, "time" DESC);


--
-- TOC entry 6132 (class 1259 OID 33407)
-- Name: position_2026_03_16_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_16_point_gps_idx ON rtls_timeseries.position_2026_03_16 USING gist (point_gps);


--
-- TOC entry 6133 (class 1259 OID 33408)
-- Name: position_2026_03_16_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_16_point_xyz_idx ON rtls_timeseries.position_2026_03_16 USING gist (point_xyz);


--
-- TOC entry 6134 (class 1259 OID 33409)
-- Name: position_2026_03_16_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_16_time_id_device_idx ON rtls_timeseries.position_2026_03_16 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6135 (class 1259 OID 33439)
-- Name: position_2026_03_23_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_23_id_device_time_idx ON rtls_timeseries.position_2026_03_23 USING btree (id_device, "time" DESC);


--
-- TOC entry 6138 (class 1259 OID 33441)
-- Name: position_2026_03_23_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_23_point_gps_idx ON rtls_timeseries.position_2026_03_23 USING gist (point_gps);


--
-- TOC entry 6139 (class 1259 OID 33442)
-- Name: position_2026_03_23_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_23_point_xyz_idx ON rtls_timeseries.position_2026_03_23 USING gist (point_xyz);


--
-- TOC entry 6140 (class 1259 OID 33443)
-- Name: position_2026_03_23_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_23_time_id_device_idx ON rtls_timeseries.position_2026_03_23 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6141 (class 1259 OID 33456)
-- Name: position_2026_03_30_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_30_id_device_time_idx ON rtls_timeseries.position_2026_03_30 USING btree (id_device, "time" DESC);


--
-- TOC entry 6144 (class 1259 OID 33458)
-- Name: position_2026_03_30_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_30_point_gps_idx ON rtls_timeseries.position_2026_03_30 USING gist (point_gps);


--
-- TOC entry 6145 (class 1259 OID 33459)
-- Name: position_2026_03_30_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_30_point_xyz_idx ON rtls_timeseries.position_2026_03_30 USING gist (point_xyz);


--
-- TOC entry 6146 (class 1259 OID 33460)
-- Name: position_2026_03_30_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_03_30_time_id_device_idx ON rtls_timeseries.position_2026_03_30 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6147 (class 1259 OID 33473)
-- Name: position_2026_04_06_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_06_id_device_time_idx ON rtls_timeseries.position_2026_04_06 USING btree (id_device, "time" DESC);


--
-- TOC entry 6150 (class 1259 OID 33475)
-- Name: position_2026_04_06_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_06_point_gps_idx ON rtls_timeseries.position_2026_04_06 USING gist (point_gps);


--
-- TOC entry 6151 (class 1259 OID 33476)
-- Name: position_2026_04_06_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_06_point_xyz_idx ON rtls_timeseries.position_2026_04_06 USING gist (point_xyz);


--
-- TOC entry 6152 (class 1259 OID 33477)
-- Name: position_2026_04_06_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_06_time_id_device_idx ON rtls_timeseries.position_2026_04_06 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6153 (class 1259 OID 33490)
-- Name: position_2026_04_13_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_13_id_device_time_idx ON rtls_timeseries.position_2026_04_13 USING btree (id_device, "time" DESC);


--
-- TOC entry 6156 (class 1259 OID 33492)
-- Name: position_2026_04_13_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_13_point_gps_idx ON rtls_timeseries.position_2026_04_13 USING gist (point_gps);


--
-- TOC entry 6157 (class 1259 OID 33493)
-- Name: position_2026_04_13_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_13_point_xyz_idx ON rtls_timeseries.position_2026_04_13 USING gist (point_xyz);


--
-- TOC entry 6158 (class 1259 OID 33494)
-- Name: position_2026_04_13_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_13_time_id_device_idx ON rtls_timeseries.position_2026_04_13 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6159 (class 1259 OID 33507)
-- Name: position_2026_04_20_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_20_id_device_time_idx ON rtls_timeseries.position_2026_04_20 USING btree (id_device, "time" DESC);


--
-- TOC entry 6162 (class 1259 OID 33509)
-- Name: position_2026_04_20_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_20_point_gps_idx ON rtls_timeseries.position_2026_04_20 USING gist (point_gps);


--
-- TOC entry 6163 (class 1259 OID 33510)
-- Name: position_2026_04_20_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_20_point_xyz_idx ON rtls_timeseries.position_2026_04_20 USING gist (point_xyz);


--
-- TOC entry 6164 (class 1259 OID 33511)
-- Name: position_2026_04_20_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_20_time_id_device_idx ON rtls_timeseries.position_2026_04_20 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6165 (class 1259 OID 33524)
-- Name: position_2026_04_27_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_27_id_device_time_idx ON rtls_timeseries.position_2026_04_27 USING btree (id_device, "time" DESC);


--
-- TOC entry 6168 (class 1259 OID 33526)
-- Name: position_2026_04_27_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_27_point_gps_idx ON rtls_timeseries.position_2026_04_27 USING gist (point_gps);


--
-- TOC entry 6169 (class 1259 OID 33527)
-- Name: position_2026_04_27_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_27_point_xyz_idx ON rtls_timeseries.position_2026_04_27 USING gist (point_xyz);


--
-- TOC entry 6170 (class 1259 OID 33531)
-- Name: position_2026_04_27_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_04_27_time_id_device_idx ON rtls_timeseries.position_2026_04_27 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6312 (class 1259 OID 36097)
-- Name: position_2026_05_04_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_04_id_device_time_idx ON rtls_timeseries.position_2026_05_04 USING btree (id_device, "time" DESC);


--
-- TOC entry 6315 (class 1259 OID 36098)
-- Name: position_2026_05_04_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_04_point_gps_idx ON rtls_timeseries.position_2026_05_04 USING gist (point_gps);


--
-- TOC entry 6316 (class 1259 OID 36099)
-- Name: position_2026_05_04_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_04_point_xyz_idx ON rtls_timeseries.position_2026_05_04 USING gist (point_xyz);


--
-- TOC entry 6317 (class 1259 OID 36100)
-- Name: position_2026_05_04_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_04_time_id_device_idx ON rtls_timeseries.position_2026_05_04 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6329 (class 1259 OID 36607)
-- Name: position_2026_05_11_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_11_id_device_time_idx ON rtls_timeseries.position_2026_05_11 USING btree (id_device, "time" DESC);


--
-- TOC entry 6332 (class 1259 OID 36608)
-- Name: position_2026_05_11_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_11_point_gps_idx ON rtls_timeseries.position_2026_05_11 USING gist (point_gps);


--
-- TOC entry 6333 (class 1259 OID 36609)
-- Name: position_2026_05_11_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_11_point_xyz_idx ON rtls_timeseries.position_2026_05_11 USING gist (point_xyz);


--
-- TOC entry 6334 (class 1259 OID 36610)
-- Name: position_2026_05_11_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_11_time_id_device_idx ON rtls_timeseries.position_2026_05_11 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6346 (class 1259 OID 37074)
-- Name: position_2026_05_18_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_18_id_device_time_idx ON rtls_timeseries.position_2026_05_18 USING btree (id_device, "time" DESC);


--
-- TOC entry 6349 (class 1259 OID 37075)
-- Name: position_2026_05_18_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_18_point_gps_idx ON rtls_timeseries.position_2026_05_18 USING gist (point_gps);


--
-- TOC entry 6350 (class 1259 OID 37076)
-- Name: position_2026_05_18_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_18_point_xyz_idx ON rtls_timeseries.position_2026_05_18 USING gist (point_xyz);


--
-- TOC entry 6351 (class 1259 OID 37077)
-- Name: position_2026_05_18_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_18_time_id_device_idx ON rtls_timeseries.position_2026_05_18 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6363 (class 1259 OID 37733)
-- Name: position_2026_05_25_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_25_id_device_time_idx ON rtls_timeseries.position_2026_05_25 USING btree (id_device, "time" DESC);


--
-- TOC entry 6366 (class 1259 OID 37734)
-- Name: position_2026_05_25_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_25_point_gps_idx ON rtls_timeseries.position_2026_05_25 USING gist (point_gps);


--
-- TOC entry 6367 (class 1259 OID 37735)
-- Name: position_2026_05_25_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_25_point_xyz_idx ON rtls_timeseries.position_2026_05_25 USING gist (point_xyz);


--
-- TOC entry 6368 (class 1259 OID 37736)
-- Name: position_2026_05_25_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_05_25_time_id_device_idx ON rtls_timeseries.position_2026_05_25 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6380 (class 1259 OID 38197)
-- Name: position_2026_06_01_id_device_time_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_06_01_id_device_time_idx ON rtls_timeseries.position_2026_06_01 USING btree (id_device, "time" DESC);


--
-- TOC entry 6383 (class 1259 OID 38198)
-- Name: position_2026_06_01_point_gps_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_06_01_point_gps_idx ON rtls_timeseries.position_2026_06_01 USING gist (point_gps);


--
-- TOC entry 6384 (class 1259 OID 38199)
-- Name: position_2026_06_01_point_xyz_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_06_01_point_xyz_idx ON rtls_timeseries.position_2026_06_01 USING gist (point_xyz);


--
-- TOC entry 6385 (class 1259 OID 38200)
-- Name: position_2026_06_01_time_id_device_idx; Type: INDEX; Schema: rtls_timeseries; Owner: supabase_admin
--

CREATE INDEX position_2026_06_01_time_id_device_idx ON rtls_timeseries.position_2026_06_01 USING btree ("time", id_device) WHERE (probably_moved = true);


--
-- TOC entry 6267 (class 1259 OID 32981)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 6282 (class 1259 OID 32982)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 6274 (class 1259 OID 33161)
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (bucket_id, name);


--
-- TOC entry 6277 (class 1259 OID 33167)
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (namespace_id, name);


--
-- TOC entry 6293 (class 1259 OID 33143)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 6283 (class 1259 OID 32992)
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- TOC entry 6284 (class 1259 OID 32993)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 6285 (class 1259 OID 32994)
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- TOC entry 6290 (class 1259 OID 33151)
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- TOC entry 6286 (class 1259 OID 32995)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 6287 (class 1259 OID 32996)
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- TOC entry 6300 (class 1259 OID 33015)
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- TOC entry 6301 (class 1259 OID 33016)
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- TOC entry 6391 (class 0 OID 0)
-- Name: device_status_2026_01_19_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_01_19_pkey;


--
-- TOC entry 6392 (class 0 OID 0)
-- Name: device_status_2026_01_26_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_01_26_pkey;


--
-- TOC entry 6393 (class 0 OID 0)
-- Name: device_status_2026_02_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_02_02_pkey;


--
-- TOC entry 6394 (class 0 OID 0)
-- Name: device_status_2026_02_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_02_09_pkey;


--
-- TOC entry 6395 (class 0 OID 0)
-- Name: device_status_2026_02_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_02_16_pkey;


--
-- TOC entry 6396 (class 0 OID 0)
-- Name: device_status_2026_02_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_02_23_pkey;


--
-- TOC entry 6397 (class 0 OID 0)
-- Name: device_status_2026_03_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_03_02_pkey;


--
-- TOC entry 6398 (class 0 OID 0)
-- Name: device_status_2026_03_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_03_09_pkey;


--
-- TOC entry 6399 (class 0 OID 0)
-- Name: device_status_2026_03_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_03_16_pkey;


--
-- TOC entry 6400 (class 0 OID 0)
-- Name: device_status_2026_03_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_03_23_pkey;


--
-- TOC entry 6401 (class 0 OID 0)
-- Name: device_status_2026_03_30_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_03_30_pkey;


--
-- TOC entry 6402 (class 0 OID 0)
-- Name: device_status_2026_04_06_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_04_06_pkey;


--
-- TOC entry 6403 (class 0 OID 0)
-- Name: device_status_2026_04_13_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_04_13_pkey;


--
-- TOC entry 6404 (class 0 OID 0)
-- Name: device_status_2026_04_20_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_04_20_pkey;


--
-- TOC entry 6405 (class 0 OID 0)
-- Name: device_status_2026_04_27_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_04_27_pkey;


--
-- TOC entry 6558 (class 0 OID 0)
-- Name: device_status_2026_05_04_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_05_04_pkey;


--
-- TOC entry 6569 (class 0 OID 0)
-- Name: device_status_2026_05_11_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_05_11_pkey;


--
-- TOC entry 6580 (class 0 OID 0)
-- Name: device_status_2026_05_18_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_05_18_pkey;


--
-- TOC entry 6591 (class 0 OID 0)
-- Name: device_status_2026_05_25_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_05_25_pkey;


--
-- TOC entry 6602 (class 0 OID 0)
-- Name: device_status_2026_06_01_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.device_status_pkey ATTACH PARTITION rtls_timeseries.device_status_2026_06_01_pkey;


--
-- TOC entry 6406 (class 0 OID 0)
-- Name: gateway_info_2026_01_19_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_01_19_info_idx;


--
-- TOC entry 6407 (class 0 OID 0)
-- Name: gateway_info_2026_01_19_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_01_19_pkey;


--
-- TOC entry 6408 (class 0 OID 0)
-- Name: gateway_info_2026_01_26_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_01_26_info_idx;


--
-- TOC entry 6409 (class 0 OID 0)
-- Name: gateway_info_2026_01_26_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_01_26_pkey;


--
-- TOC entry 6410 (class 0 OID 0)
-- Name: gateway_info_2026_02_02_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_02_info_idx;


--
-- TOC entry 6411 (class 0 OID 0)
-- Name: gateway_info_2026_02_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_02_pkey;


--
-- TOC entry 6412 (class 0 OID 0)
-- Name: gateway_info_2026_02_09_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_09_info_idx;


--
-- TOC entry 6413 (class 0 OID 0)
-- Name: gateway_info_2026_02_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_09_pkey;


--
-- TOC entry 6414 (class 0 OID 0)
-- Name: gateway_info_2026_02_16_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_16_info_idx;


--
-- TOC entry 6415 (class 0 OID 0)
-- Name: gateway_info_2026_02_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_16_pkey;


--
-- TOC entry 6416 (class 0 OID 0)
-- Name: gateway_info_2026_02_23_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_23_info_idx;


--
-- TOC entry 6417 (class 0 OID 0)
-- Name: gateway_info_2026_02_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_02_23_pkey;


--
-- TOC entry 6418 (class 0 OID 0)
-- Name: gateway_info_2026_03_02_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_02_info_idx;


--
-- TOC entry 6419 (class 0 OID 0)
-- Name: gateway_info_2026_03_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_02_pkey;


--
-- TOC entry 6420 (class 0 OID 0)
-- Name: gateway_info_2026_03_09_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_09_info_idx;


--
-- TOC entry 6421 (class 0 OID 0)
-- Name: gateway_info_2026_03_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_09_pkey;


--
-- TOC entry 6422 (class 0 OID 0)
-- Name: gateway_info_2026_03_16_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_16_info_idx;


--
-- TOC entry 6423 (class 0 OID 0)
-- Name: gateway_info_2026_03_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_16_pkey;


--
-- TOC entry 6424 (class 0 OID 0)
-- Name: gateway_info_2026_03_23_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_23_info_idx;


--
-- TOC entry 6425 (class 0 OID 0)
-- Name: gateway_info_2026_03_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_23_pkey;


--
-- TOC entry 6426 (class 0 OID 0)
-- Name: gateway_info_2026_03_30_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_30_info_idx;


--
-- TOC entry 6427 (class 0 OID 0)
-- Name: gateway_info_2026_03_30_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_03_30_pkey;


--
-- TOC entry 6428 (class 0 OID 0)
-- Name: gateway_info_2026_04_06_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_06_info_idx;


--
-- TOC entry 6429 (class 0 OID 0)
-- Name: gateway_info_2026_04_06_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_06_pkey;


--
-- TOC entry 6430 (class 0 OID 0)
-- Name: gateway_info_2026_04_13_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_13_info_idx;


--
-- TOC entry 6431 (class 0 OID 0)
-- Name: gateway_info_2026_04_13_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_13_pkey;


--
-- TOC entry 6432 (class 0 OID 0)
-- Name: gateway_info_2026_04_20_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_20_info_idx;


--
-- TOC entry 6433 (class 0 OID 0)
-- Name: gateway_info_2026_04_20_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_20_pkey;


--
-- TOC entry 6434 (class 0 OID 0)
-- Name: gateway_info_2026_04_27_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_27_info_idx;


--
-- TOC entry 6435 (class 0 OID 0)
-- Name: gateway_info_2026_04_27_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_04_27_pkey;


--
-- TOC entry 6565 (class 0 OID 0)
-- Name: gateway_info_2026_05_04_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_04_info_idx;


--
-- TOC entry 6566 (class 0 OID 0)
-- Name: gateway_info_2026_05_04_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_04_pkey;


--
-- TOC entry 6576 (class 0 OID 0)
-- Name: gateway_info_2026_05_11_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_11_info_idx;


--
-- TOC entry 6577 (class 0 OID 0)
-- Name: gateway_info_2026_05_11_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_11_pkey;


--
-- TOC entry 6587 (class 0 OID 0)
-- Name: gateway_info_2026_05_18_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_18_info_idx;


--
-- TOC entry 6588 (class 0 OID 0)
-- Name: gateway_info_2026_05_18_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_18_pkey;


--
-- TOC entry 6598 (class 0 OID 0)
-- Name: gateway_info_2026_05_25_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_25_info_idx;


--
-- TOC entry 6599 (class 0 OID 0)
-- Name: gateway_info_2026_05_25_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_05_25_pkey;


--
-- TOC entry 6609 (class 0 OID 0)
-- Name: gateway_info_2026_06_01_info_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_gateway_info_info ATTACH PARTITION rtls_timeseries.gateway_info_2026_06_01_info_idx;


--
-- TOC entry 6610 (class 0 OID 0)
-- Name: gateway_info_2026_06_01_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.gateway_info_pkey ATTACH PARTITION rtls_timeseries.gateway_info_2026_06_01_pkey;


--
-- TOC entry 6436 (class 0 OID 0)
-- Name: position_2026_01_19_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_01_19_id_device_time_idx;


--
-- TOC entry 6437 (class 0 OID 0)
-- Name: position_2026_01_19_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_01_19_pkey;


--
-- TOC entry 6438 (class 0 OID 0)
-- Name: position_2026_01_19_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_01_19_point_gps_idx;


--
-- TOC entry 6439 (class 0 OID 0)
-- Name: position_2026_01_19_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_01_19_point_xyz_idx;


--
-- TOC entry 6440 (class 0 OID 0)
-- Name: position_2026_01_19_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_01_19_time_id_device_idx;


--
-- TOC entry 6441 (class 0 OID 0)
-- Name: position_2026_01_26_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_01_26_id_device_time_idx;


--
-- TOC entry 6442 (class 0 OID 0)
-- Name: position_2026_01_26_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_01_26_pkey;


--
-- TOC entry 6443 (class 0 OID 0)
-- Name: position_2026_01_26_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_01_26_point_gps_idx;


--
-- TOC entry 6444 (class 0 OID 0)
-- Name: position_2026_01_26_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_01_26_point_xyz_idx;


--
-- TOC entry 6445 (class 0 OID 0)
-- Name: position_2026_01_26_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_01_26_time_id_device_idx;


--
-- TOC entry 6446 (class 0 OID 0)
-- Name: position_2026_02_02_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_02_02_id_device_time_idx;


--
-- TOC entry 6447 (class 0 OID 0)
-- Name: position_2026_02_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_02_02_pkey;


--
-- TOC entry 6448 (class 0 OID 0)
-- Name: position_2026_02_02_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_02_02_point_gps_idx;


--
-- TOC entry 6449 (class 0 OID 0)
-- Name: position_2026_02_02_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_02_02_point_xyz_idx;


--
-- TOC entry 6450 (class 0 OID 0)
-- Name: position_2026_02_02_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_02_02_time_id_device_idx;


--
-- TOC entry 6451 (class 0 OID 0)
-- Name: position_2026_02_09_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_02_09_id_device_time_idx;


--
-- TOC entry 6452 (class 0 OID 0)
-- Name: position_2026_02_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_02_09_pkey;


--
-- TOC entry 6453 (class 0 OID 0)
-- Name: position_2026_02_09_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_02_09_point_gps_idx;


--
-- TOC entry 6454 (class 0 OID 0)
-- Name: position_2026_02_09_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_02_09_point_xyz_idx;


--
-- TOC entry 6455 (class 0 OID 0)
-- Name: position_2026_02_09_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_02_09_time_id_device_idx;


--
-- TOC entry 6456 (class 0 OID 0)
-- Name: position_2026_02_16_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_02_16_id_device_time_idx;


--
-- TOC entry 6457 (class 0 OID 0)
-- Name: position_2026_02_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_02_16_pkey;


--
-- TOC entry 6458 (class 0 OID 0)
-- Name: position_2026_02_16_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_02_16_point_gps_idx;


--
-- TOC entry 6459 (class 0 OID 0)
-- Name: position_2026_02_16_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_02_16_point_xyz_idx;


--
-- TOC entry 6460 (class 0 OID 0)
-- Name: position_2026_02_16_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_02_16_time_id_device_idx;


--
-- TOC entry 6461 (class 0 OID 0)
-- Name: position_2026_02_23_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_02_23_id_device_time_idx;


--
-- TOC entry 6462 (class 0 OID 0)
-- Name: position_2026_02_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_02_23_pkey;


--
-- TOC entry 6463 (class 0 OID 0)
-- Name: position_2026_02_23_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_02_23_point_gps_idx;


--
-- TOC entry 6464 (class 0 OID 0)
-- Name: position_2026_02_23_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_02_23_point_xyz_idx;


--
-- TOC entry 6465 (class 0 OID 0)
-- Name: position_2026_02_23_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_02_23_time_id_device_idx;


--
-- TOC entry 6466 (class 0 OID 0)
-- Name: position_2026_03_02_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_03_02_id_device_time_idx;


--
-- TOC entry 6467 (class 0 OID 0)
-- Name: position_2026_03_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_03_02_pkey;


--
-- TOC entry 6468 (class 0 OID 0)
-- Name: position_2026_03_02_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_03_02_point_gps_idx;


--
-- TOC entry 6469 (class 0 OID 0)
-- Name: position_2026_03_02_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_03_02_point_xyz_idx;


--
-- TOC entry 6470 (class 0 OID 0)
-- Name: position_2026_03_02_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_03_02_time_id_device_idx;


--
-- TOC entry 6471 (class 0 OID 0)
-- Name: position_2026_03_09_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_03_09_id_device_time_idx;


--
-- TOC entry 6472 (class 0 OID 0)
-- Name: position_2026_03_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_03_09_pkey;


--
-- TOC entry 6473 (class 0 OID 0)
-- Name: position_2026_03_09_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_03_09_point_gps_idx;


--
-- TOC entry 6474 (class 0 OID 0)
-- Name: position_2026_03_09_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_03_09_point_xyz_idx;


--
-- TOC entry 6475 (class 0 OID 0)
-- Name: position_2026_03_09_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_03_09_time_id_device_idx;


--
-- TOC entry 6476 (class 0 OID 0)
-- Name: position_2026_03_16_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_03_16_id_device_time_idx;


--
-- TOC entry 6477 (class 0 OID 0)
-- Name: position_2026_03_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_03_16_pkey;


--
-- TOC entry 6478 (class 0 OID 0)
-- Name: position_2026_03_16_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_03_16_point_gps_idx;


--
-- TOC entry 6479 (class 0 OID 0)
-- Name: position_2026_03_16_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_03_16_point_xyz_idx;


--
-- TOC entry 6480 (class 0 OID 0)
-- Name: position_2026_03_16_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_03_16_time_id_device_idx;


--
-- TOC entry 6481 (class 0 OID 0)
-- Name: position_2026_03_23_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_03_23_id_device_time_idx;


--
-- TOC entry 6482 (class 0 OID 0)
-- Name: position_2026_03_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_03_23_pkey;


--
-- TOC entry 6483 (class 0 OID 0)
-- Name: position_2026_03_23_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_03_23_point_gps_idx;


--
-- TOC entry 6484 (class 0 OID 0)
-- Name: position_2026_03_23_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_03_23_point_xyz_idx;


--
-- TOC entry 6485 (class 0 OID 0)
-- Name: position_2026_03_23_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_03_23_time_id_device_idx;


--
-- TOC entry 6486 (class 0 OID 0)
-- Name: position_2026_03_30_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_03_30_id_device_time_idx;


--
-- TOC entry 6487 (class 0 OID 0)
-- Name: position_2026_03_30_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_03_30_pkey;


--
-- TOC entry 6488 (class 0 OID 0)
-- Name: position_2026_03_30_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_03_30_point_gps_idx;


--
-- TOC entry 6489 (class 0 OID 0)
-- Name: position_2026_03_30_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_03_30_point_xyz_idx;


--
-- TOC entry 6490 (class 0 OID 0)
-- Name: position_2026_03_30_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_03_30_time_id_device_idx;


--
-- TOC entry 6491 (class 0 OID 0)
-- Name: position_2026_04_06_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_04_06_id_device_time_idx;


--
-- TOC entry 6492 (class 0 OID 0)
-- Name: position_2026_04_06_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_04_06_pkey;


--
-- TOC entry 6493 (class 0 OID 0)
-- Name: position_2026_04_06_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_04_06_point_gps_idx;


--
-- TOC entry 6494 (class 0 OID 0)
-- Name: position_2026_04_06_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_04_06_point_xyz_idx;


--
-- TOC entry 6495 (class 0 OID 0)
-- Name: position_2026_04_06_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_04_06_time_id_device_idx;


--
-- TOC entry 6496 (class 0 OID 0)
-- Name: position_2026_04_13_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_04_13_id_device_time_idx;


--
-- TOC entry 6497 (class 0 OID 0)
-- Name: position_2026_04_13_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_04_13_pkey;


--
-- TOC entry 6498 (class 0 OID 0)
-- Name: position_2026_04_13_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_04_13_point_gps_idx;


--
-- TOC entry 6499 (class 0 OID 0)
-- Name: position_2026_04_13_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_04_13_point_xyz_idx;


--
-- TOC entry 6500 (class 0 OID 0)
-- Name: position_2026_04_13_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_04_13_time_id_device_idx;


--
-- TOC entry 6501 (class 0 OID 0)
-- Name: position_2026_04_20_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_04_20_id_device_time_idx;


--
-- TOC entry 6502 (class 0 OID 0)
-- Name: position_2026_04_20_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_04_20_pkey;


--
-- TOC entry 6503 (class 0 OID 0)
-- Name: position_2026_04_20_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_04_20_point_gps_idx;


--
-- TOC entry 6504 (class 0 OID 0)
-- Name: position_2026_04_20_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_04_20_point_xyz_idx;


--
-- TOC entry 6505 (class 0 OID 0)
-- Name: position_2026_04_20_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_04_20_time_id_device_idx;


--
-- TOC entry 6506 (class 0 OID 0)
-- Name: position_2026_04_27_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_04_27_id_device_time_idx;


--
-- TOC entry 6507 (class 0 OID 0)
-- Name: position_2026_04_27_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_04_27_pkey;


--
-- TOC entry 6508 (class 0 OID 0)
-- Name: position_2026_04_27_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_04_27_point_gps_idx;


--
-- TOC entry 6509 (class 0 OID 0)
-- Name: position_2026_04_27_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_04_27_point_xyz_idx;


--
-- TOC entry 6510 (class 0 OID 0)
-- Name: position_2026_04_27_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_04_27_time_id_device_idx;


--
-- TOC entry 6559 (class 0 OID 0)
-- Name: position_2026_05_04_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_05_04_id_device_time_idx;


--
-- TOC entry 6560 (class 0 OID 0)
-- Name: position_2026_05_04_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_05_04_pkey;


--
-- TOC entry 6561 (class 0 OID 0)
-- Name: position_2026_05_04_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_05_04_point_gps_idx;


--
-- TOC entry 6562 (class 0 OID 0)
-- Name: position_2026_05_04_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_05_04_point_xyz_idx;


--
-- TOC entry 6563 (class 0 OID 0)
-- Name: position_2026_05_04_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_05_04_time_id_device_idx;


--
-- TOC entry 6570 (class 0 OID 0)
-- Name: position_2026_05_11_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_05_11_id_device_time_idx;


--
-- TOC entry 6571 (class 0 OID 0)
-- Name: position_2026_05_11_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_05_11_pkey;


--
-- TOC entry 6572 (class 0 OID 0)
-- Name: position_2026_05_11_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_05_11_point_gps_idx;


--
-- TOC entry 6573 (class 0 OID 0)
-- Name: position_2026_05_11_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_05_11_point_xyz_idx;


--
-- TOC entry 6574 (class 0 OID 0)
-- Name: position_2026_05_11_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_05_11_time_id_device_idx;


--
-- TOC entry 6581 (class 0 OID 0)
-- Name: position_2026_05_18_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_05_18_id_device_time_idx;


--
-- TOC entry 6582 (class 0 OID 0)
-- Name: position_2026_05_18_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_05_18_pkey;


--
-- TOC entry 6583 (class 0 OID 0)
-- Name: position_2026_05_18_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_05_18_point_gps_idx;


--
-- TOC entry 6584 (class 0 OID 0)
-- Name: position_2026_05_18_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_05_18_point_xyz_idx;


--
-- TOC entry 6585 (class 0 OID 0)
-- Name: position_2026_05_18_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_05_18_time_id_device_idx;


--
-- TOC entry 6592 (class 0 OID 0)
-- Name: position_2026_05_25_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_05_25_id_device_time_idx;


--
-- TOC entry 6593 (class 0 OID 0)
-- Name: position_2026_05_25_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_05_25_pkey;


--
-- TOC entry 6594 (class 0 OID 0)
-- Name: position_2026_05_25_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_05_25_point_gps_idx;


--
-- TOC entry 6595 (class 0 OID 0)
-- Name: position_2026_05_25_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_05_25_point_xyz_idx;


--
-- TOC entry 6596 (class 0 OID 0)
-- Name: position_2026_05_25_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_05_25_time_id_device_idx;


--
-- TOC entry 6603 (class 0 OID 0)
-- Name: position_2026_06_01_id_device_time_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_latest_per_device ATTACH PARTITION rtls_timeseries.position_2026_06_01_id_device_time_idx;


--
-- TOC entry 6604 (class 0 OID 0)
-- Name: position_2026_06_01_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_pkey ATTACH PARTITION rtls_timeseries.position_2026_06_01_pkey;


--
-- TOC entry 6605 (class 0 OID 0)
-- Name: position_2026_06_01_point_gps_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_gps ATTACH PARTITION rtls_timeseries.position_2026_06_01_point_gps_idx;


--
-- TOC entry 6606 (class 0 OID 0)
-- Name: position_2026_06_01_point_xyz_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_point_xyz ATTACH PARTITION rtls_timeseries.position_2026_06_01_point_xyz_idx;


--
-- TOC entry 6607 (class 0 OID 0)
-- Name: position_2026_06_01_time_id_device_idx; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.idx_position_probably_moved_true ATTACH PARTITION rtls_timeseries.position_2026_06_01_time_id_device_idx;


--
-- TOC entry 6511 (class 0 OID 0)
-- Name: position_area_2026_01_19_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_01_19_pkey;


--
-- TOC entry 6512 (class 0 OID 0)
-- Name: position_area_2026_01_26_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_01_26_pkey;


--
-- TOC entry 6513 (class 0 OID 0)
-- Name: position_area_2026_02_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_02_02_pkey;


--
-- TOC entry 6514 (class 0 OID 0)
-- Name: position_area_2026_02_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_02_09_pkey;


--
-- TOC entry 6515 (class 0 OID 0)
-- Name: position_area_2026_02_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_02_16_pkey;


--
-- TOC entry 6516 (class 0 OID 0)
-- Name: position_area_2026_02_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_02_23_pkey;


--
-- TOC entry 6517 (class 0 OID 0)
-- Name: position_area_2026_03_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_03_02_pkey;


--
-- TOC entry 6518 (class 0 OID 0)
-- Name: position_area_2026_03_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_03_09_pkey;


--
-- TOC entry 6519 (class 0 OID 0)
-- Name: position_area_2026_03_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_03_16_pkey;


--
-- TOC entry 6520 (class 0 OID 0)
-- Name: position_area_2026_03_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_03_23_pkey;


--
-- TOC entry 6521 (class 0 OID 0)
-- Name: position_area_2026_03_30_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_03_30_pkey;


--
-- TOC entry 6522 (class 0 OID 0)
-- Name: position_area_2026_04_06_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_04_06_pkey;


--
-- TOC entry 6523 (class 0 OID 0)
-- Name: position_area_2026_04_13_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_04_13_pkey;


--
-- TOC entry 6524 (class 0 OID 0)
-- Name: position_area_2026_04_20_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_04_20_pkey;


--
-- TOC entry 6525 (class 0 OID 0)
-- Name: position_area_2026_04_27_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_04_27_pkey;


--
-- TOC entry 6564 (class 0 OID 0)
-- Name: position_area_2026_05_04_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_05_04_pkey;


--
-- TOC entry 6575 (class 0 OID 0)
-- Name: position_area_2026_05_11_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_05_11_pkey;


--
-- TOC entry 6586 (class 0 OID 0)
-- Name: position_area_2026_05_18_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_05_18_pkey;


--
-- TOC entry 6597 (class 0 OID 0)
-- Name: position_area_2026_05_25_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_05_25_pkey;


--
-- TOC entry 6608 (class 0 OID 0)
-- Name: position_area_2026_06_01_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.position_area_pkey ATTACH PARTITION rtls_timeseries.position_area_2026_06_01_pkey;


--
-- TOC entry 6526 (class 0 OID 0)
-- Name: ranging_2026_01_19_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_01_19_pkey;


--
-- TOC entry 6527 (class 0 OID 0)
-- Name: ranging_2026_01_26_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_01_26_pkey;


--
-- TOC entry 6528 (class 0 OID 0)
-- Name: ranging_2026_02_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_02_02_pkey;


--
-- TOC entry 6529 (class 0 OID 0)
-- Name: ranging_2026_02_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_02_09_pkey;


--
-- TOC entry 6530 (class 0 OID 0)
-- Name: ranging_2026_02_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_02_16_pkey;


--
-- TOC entry 6531 (class 0 OID 0)
-- Name: ranging_2026_02_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_02_23_pkey;


--
-- TOC entry 6532 (class 0 OID 0)
-- Name: ranging_2026_03_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_03_02_pkey;


--
-- TOC entry 6533 (class 0 OID 0)
-- Name: ranging_2026_03_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_03_09_pkey;


--
-- TOC entry 6534 (class 0 OID 0)
-- Name: ranging_2026_03_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_03_16_pkey;


--
-- TOC entry 6535 (class 0 OID 0)
-- Name: ranging_2026_03_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_03_23_pkey;


--
-- TOC entry 6536 (class 0 OID 0)
-- Name: ranging_2026_03_30_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_03_30_pkey;


--
-- TOC entry 6537 (class 0 OID 0)
-- Name: ranging_2026_04_06_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_04_06_pkey;


--
-- TOC entry 6538 (class 0 OID 0)
-- Name: ranging_2026_04_13_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_04_13_pkey;


--
-- TOC entry 6539 (class 0 OID 0)
-- Name: ranging_2026_04_20_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_04_20_pkey;


--
-- TOC entry 6540 (class 0 OID 0)
-- Name: ranging_2026_04_27_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_04_27_pkey;


--
-- TOC entry 6556 (class 0 OID 0)
-- Name: ranging_2026_05_04_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_05_04_pkey;


--
-- TOC entry 6567 (class 0 OID 0)
-- Name: ranging_2026_05_11_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_05_11_pkey;


--
-- TOC entry 6578 (class 0 OID 0)
-- Name: ranging_2026_05_18_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_05_18_pkey;


--
-- TOC entry 6589 (class 0 OID 0)
-- Name: ranging_2026_05_25_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_05_25_pkey;


--
-- TOC entry 6600 (class 0 OID 0)
-- Name: ranging_2026_06_01_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_pkey ATTACH PARTITION rtls_timeseries.ranging_2026_06_01_pkey;


--
-- TOC entry 6541 (class 0 OID 0)
-- Name: ranging_item_2026_01_19_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_01_19_pkey;


--
-- TOC entry 6542 (class 0 OID 0)
-- Name: ranging_item_2026_01_26_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_01_26_pkey;


--
-- TOC entry 6543 (class 0 OID 0)
-- Name: ranging_item_2026_02_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_02_pkey;


--
-- TOC entry 6544 (class 0 OID 0)
-- Name: ranging_item_2026_02_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_09_pkey;


--
-- TOC entry 6545 (class 0 OID 0)
-- Name: ranging_item_2026_02_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_16_pkey;


--
-- TOC entry 6546 (class 0 OID 0)
-- Name: ranging_item_2026_02_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_02_23_pkey;


--
-- TOC entry 6547 (class 0 OID 0)
-- Name: ranging_item_2026_03_02_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_02_pkey;


--
-- TOC entry 6548 (class 0 OID 0)
-- Name: ranging_item_2026_03_09_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_09_pkey;


--
-- TOC entry 6549 (class 0 OID 0)
-- Name: ranging_item_2026_03_16_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_16_pkey;


--
-- TOC entry 6550 (class 0 OID 0)
-- Name: ranging_item_2026_03_23_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_23_pkey;


--
-- TOC entry 6551 (class 0 OID 0)
-- Name: ranging_item_2026_03_30_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_03_30_pkey;


--
-- TOC entry 6552 (class 0 OID 0)
-- Name: ranging_item_2026_04_06_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_06_pkey;


--
-- TOC entry 6553 (class 0 OID 0)
-- Name: ranging_item_2026_04_13_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_13_pkey;


--
-- TOC entry 6554 (class 0 OID 0)
-- Name: ranging_item_2026_04_20_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_20_pkey;


--
-- TOC entry 6555 (class 0 OID 0)
-- Name: ranging_item_2026_04_27_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_04_27_pkey;


--
-- TOC entry 6557 (class 0 OID 0)
-- Name: ranging_item_2026_05_04_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_04_pkey;


--
-- TOC entry 6568 (class 0 OID 0)
-- Name: ranging_item_2026_05_11_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_11_pkey;


--
-- TOC entry 6579 (class 0 OID 0)
-- Name: ranging_item_2026_05_18_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_18_pkey;


--
-- TOC entry 6590 (class 0 OID 0)
-- Name: ranging_item_2026_05_25_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_05_25_pkey;


--
-- TOC entry 6601 (class 0 OID 0)
-- Name: ranging_item_2026_06_01_pkey; Type: INDEX ATTACH; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER INDEX rtls_timeseries.ranging_item_pkey ATTACH PARTITION rtls_timeseries.ranging_item_2026_06_01_pkey;


--
-- TOC entry 6694 (class 2620 OID 33877)
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION private.handle_new_user();


--
-- TOC entry 6695 (class 2620 OID 33888)
-- Name: users trg_handle_new_user_roles; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER trg_handle_new_user_roles AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION private.handle_new_user_roles();


--
-- TOC entry 6696 (class 2620 OID 34377)
-- Name: profiles on_create_profile; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER on_create_profile BEFORE INSERT ON public.profiles FOR EACH ROW EXECUTE FUNCTION private.force_user_defaults();


--
-- TOC entry 6697 (class 2620 OID 34379)
-- Name: profiles on_profile_deleted; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER on_profile_deleted AFTER DELETE ON public.profiles FOR EACH ROW EXECUTE FUNCTION private.handle_profile_deletion();


--
-- TOC entry 6698 (class 2620 OID 33583)
-- Name: profiles on_profile_email_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER on_profile_email_updated AFTER UPDATE OF email ON public.profiles FOR EACH ROW EXECUTE FUNCTION private.sync_profile_email();


--
-- TOC entry 6699 (class 2620 OID 33958)
-- Name: profiles set_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION private.set_updated_at();


--
-- TOC entry 6700 (class 2620 OID 34316)
-- Name: roles set_roles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_roles_updated_at BEFORE UPDATE ON public.roles FOR EACH ROW EXECUTE FUNCTION private.set_updated_at();


--
-- TOC entry 6701 (class 2620 OID 34378)
-- Name: area trigger_update_area_hierarchy_path; Type: TRIGGER; Schema: rtls_config; Owner: supabase_admin
--

CREATE TRIGGER trigger_update_area_hierarchy_path BEFORE INSERT OR UPDATE ON rtls_config.area FOR EACH ROW EXECUTE FUNCTION rtls_config.update_area_hierarchy_path();


--
-- TOC entry 6702 (class 2620 OID 34241)
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- TOC entry 6703 (class 2620 OID 33560)
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 6704 (class 2620 OID 33571)
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- TOC entry 6705 (class 2620 OID 34257)
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- TOC entry 6707 (class 2620 OID 33584)
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- TOC entry 6708 (class 2620 OID 33595)
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 6706 (class 2620 OID 33582)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 6611 (class 2606 OID 34201)
-- Name: alert_queries alert_queries_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries
    ADD CONSTRAINT alert_queries_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6612 (class 2606 OID 33550)
-- Name: backends backends_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.backends
    ADD CONSTRAINT backends_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id);


--
-- TOC entry 6613 (class 2606 OID 33805)
-- Name: billing_accounts billing_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_accounts
    ADD CONSTRAINT billing_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6614 (class 2606 OID 33817)
-- Name: billing_counts billing_counts_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_counts
    ADD CONSTRAINT billing_counts_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6615 (class 2606 OID 33969)
-- Name: endpoint_queries endpoint_queries_sandbox_query_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_sandbox_query_id_fkey FOREIGN KEY (sandbox_query_id) REFERENCES _analytics.endpoint_queries(id);


--
-- TOC entry 6616 (class 2606 OID 33585)
-- Name: endpoint_queries endpoint_queries_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6617 (class 2606 OID 34211)
-- Name: oauth_access_grants oauth_access_grants_application_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_application_id_fkey FOREIGN KEY (application_id) REFERENCES _analytics.oauth_applications(id);


--
-- TOC entry 6618 (class 2606 OID 33894)
-- Name: oauth_access_tokens oauth_access_tokens_application_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_application_id_fkey FOREIGN KEY (application_id) REFERENCES _analytics.oauth_applications(id);


--
-- TOC entry 6619 (class 2606 OID 33964)
-- Name: partner_users partner_users_partner_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users
    ADD CONSTRAINT partner_users_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES _analytics.partners(id);


--
-- TOC entry 6620 (class 2606 OID 34301)
-- Name: partner_users partner_users_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users
    ADD CONSTRAINT partner_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6621 (class 2606 OID 33632)
-- Name: payment_methods payment_methods_customer_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.payment_methods
    ADD CONSTRAINT payment_methods_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES _analytics.billing_accounts(stripe_customer) ON DELETE CASCADE;


--
-- TOC entry 6622 (class 2606 OID 33712)
-- Name: rules rules_backend_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_backend_id_fkey FOREIGN KEY (backend_id) REFERENCES _analytics.backends(id) ON DELETE CASCADE;


--
-- TOC entry 6623 (class 2606 OID 34276)
-- Name: rules rules_sink_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_sink_fkey FOREIGN KEY (sink) REFERENCES _analytics.sources(token) ON DELETE CASCADE;


--
-- TOC entry 6624 (class 2606 OID 34296)
-- Name: rules rules_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id) ON DELETE CASCADE;


--
-- TOC entry 6625 (class 2606 OID 33540)
-- Name: saved_search_counters saved_search_counters_saved_search_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_search_counters
    ADD CONSTRAINT saved_search_counters_saved_search_id_fkey FOREIGN KEY (saved_search_id) REFERENCES _analytics.saved_searches(id) ON DELETE CASCADE;


--
-- TOC entry 6626 (class 2606 OID 33535)
-- Name: saved_searches saved_searches_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_searches
    ADD CONSTRAINT saved_searches_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id) ON DELETE CASCADE;


--
-- TOC entry 6627 (class 2606 OID 34283)
-- Name: source_backends source_backends_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_backends
    ADD CONSTRAINT source_backends_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id);


--
-- TOC entry 6628 (class 2606 OID 33545)
-- Name: source_schemas source_schemas_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_schemas
    ADD CONSTRAINT source_schemas_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id) ON DELETE CASCADE;


--
-- TOC entry 6630 (class 2606 OID 33727)
-- Name: sources_backends sources_backends_backend_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends
    ADD CONSTRAINT sources_backends_backend_id_fkey FOREIGN KEY (backend_id) REFERENCES _analytics.backends(id);


--
-- TOC entry 6631 (class 2606 OID 33642)
-- Name: sources_backends sources_backends_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends
    ADD CONSTRAINT sources_backends_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id);


--
-- TOC entry 6629 (class 2606 OID 33577)
-- Name: sources sources_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources
    ADD CONSTRAINT sources_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6632 (class 2606 OID 33752)
-- Name: team_users team_users_team_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.team_users
    ADD CONSTRAINT team_users_team_id_fkey FOREIGN KEY (team_id) REFERENCES _analytics.teams(id) ON DELETE CASCADE;


--
-- TOC entry 6633 (class 2606 OID 33717)
-- Name: teams teams_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.teams
    ADD CONSTRAINT teams_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6634 (class 2606 OID 33606)
-- Name: users users_partner_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.users
    ADD CONSTRAINT users_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES _analytics.partners(id);


--
-- TOC entry 6635 (class 2606 OID 33637)
-- Name: vercel_auths vercel_auths_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.vercel_auths
    ADD CONSTRAINT vercel_auths_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- TOC entry 6636 (class 2606 OID 33596)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 6637 (class 2606 OID 33742)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 6638 (class 2606 OID 33737)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 6639 (class 2606 OID 33611)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 6640 (class 2606 OID 34264)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 6641 (class 2606 OID 33959)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 6642 (class 2606 OID 34252)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 6643 (class 2606 OID 33974)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 6644 (class 2606 OID 34288)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 6645 (class 2606 OID 34306)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 6646 (class 2606 OID 34231)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 6647 (class 2606 OID 33572)
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 6655 (class 2606 OID 34270)
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 6656 (class 2606 OID 33601)
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 6657 (class 2606 OID 33616)
-- Name: alarm_events alarm_events_id_asset_fkey; Type: FK CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.alarm_events
    ADD CONSTRAINT alarm_events_id_asset_fkey FOREIGN KEY (id_asset) REFERENCES rtls_config.asset(id_asset);


--
-- TOC entry 6658 (class 2606 OID 33647)
-- Name: area area_parent_area_id_fkey; Type: FK CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.area
    ADD CONSTRAINT area_parent_area_id_fkey FOREIGN KEY (parent_area_id) REFERENCES rtls_config.area(id_area);


--
-- TOC entry 6659 (class 2606 OID 34129)
-- Name: area_permission area_permission_id_area_fkey; Type: FK CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.area_permission
    ADD CONSTRAINT area_permission_id_area_fkey FOREIGN KEY (id_area) REFERENCES rtls_config.area(id_area) ON DELETE CASCADE;


--
-- TOC entry 6660 (class 2606 OID 33747)
-- Name: area_permission area_permission_id_asset_fkey; Type: FK CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.area_permission
    ADD CONSTRAINT area_permission_id_asset_fkey FOREIGN KEY (id_asset) REFERENCES rtls_config.asset(id_asset);


--
-- TOC entry 6661 (class 2606 OID 34029)
-- Name: asset asset_id_asset_type_fkey; Type: FK CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.asset
    ADD CONSTRAINT asset_id_asset_type_fkey FOREIGN KEY (id_asset_type) REFERENCES rtls_config.asset_type(id_asset_type);


--
-- TOC entry 6662 (class 2606 OID 33889)
-- Name: uwb_device uwb_device_id_asset_fkey; Type: FK CONSTRAINT; Schema: rtls_config; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_config.uwb_device
    ADD CONSTRAINT uwb_device_id_asset_fkey FOREIGN KEY (id_asset) REFERENCES rtls_config.asset(id_asset);


--
-- TOC entry 6650 (class 2606 OID 34147)
-- Name: reference_point_measurement fk_device; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement
    ADD CONSTRAINT fk_device FOREIGN KEY (id_device) REFERENCES rtls_measurement.device(id_device) ON DELETE CASCADE;


--
-- TOC entry 6651 (class 2606 OID 33722)
-- Name: reference_point_measurement fk_reference_id_reference_point_01; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement
    ADD CONSTRAINT fk_reference_id_reference_point_01 FOREIGN KEY (id_reference_point) REFERENCES rtls_measurement.reference_point(id_reference_point) ON DELETE SET NULL;


--
-- TOC entry 6652 (class 2606 OID 34192)
-- Name: reference_point_measurement fk_reference_id_reference_point_02; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement
    ADD CONSTRAINT fk_reference_id_reference_point_02 FOREIGN KEY (id_reference_point) REFERENCES rtls_measurement.reference_point(id_reference_point) ON DELETE SET NULL;


--
-- TOC entry 6653 (class 2606 OID 34202)
-- Name: reference_point_measurement fk_reference_point; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement
    ADD CONSTRAINT fk_reference_point FOREIGN KEY (id_reference_point) REFERENCES rtls_measurement.reference_point(id_reference_point) ON DELETE CASCADE;


--
-- TOC entry 6648 (class 2606 OID 34242)
-- Name: device fk_reference_setup; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.device
    ADD CONSTRAINT fk_reference_setup FOREIGN KEY (id_setup) REFERENCES rtls_measurement.setup(id_setup) ON DELETE SET NULL;


--
-- TOC entry 6654 (class 2606 OID 34367)
-- Name: reference_point_measurement fk_setup; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point_measurement
    ADD CONSTRAINT fk_setup FOREIGN KEY (id_setup) REFERENCES rtls_measurement.setup(id_setup) ON DELETE CASCADE;


--
-- TOC entry 6649 (class 2606 OID 33707)
-- Name: reference_point reference_point_setup_id_fkey; Type: FK CONSTRAINT; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement.reference_point
    ADD CONSTRAINT reference_point_setup_id_fkey FOREIGN KEY (setup_id) REFERENCES rtls_measurement.setup(id_setup) ON DELETE CASCADE;


--
-- TOC entry 6664 (class 2606 OID 34372)
-- Name: position fk_device; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_2."position"
    ADD CONSTRAINT fk_device FOREIGN KEY (id_device) REFERENCES rtls_measurement_2.device(id_device) ON DELETE CASCADE;


--
-- TOC entry 6665 (class 2606 OID 33627)
-- Name: reference_point_measurement fk_device; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point_measurement
    ADD CONSTRAINT fk_device FOREIGN KEY (id_device) REFERENCES rtls_measurement_2.device(id_device) ON DELETE CASCADE;


--
-- TOC entry 6666 (class 2606 OID 33883)
-- Name: reference_point_measurement fk_reference_id_reference_point_01; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point_measurement
    ADD CONSTRAINT fk_reference_id_reference_point_01 FOREIGN KEY (id_reference_point_01) REFERENCES rtls_measurement_2.reference_point(id_reference_point) ON DELETE SET NULL;


--
-- TOC entry 6667 (class 2606 OID 34311)
-- Name: reference_point_measurement fk_reference_id_reference_point_02; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point_measurement
    ADD CONSTRAINT fk_reference_id_reference_point_02 FOREIGN KEY (id_reference_point_02) REFERENCES rtls_measurement_2.reference_point(id_reference_point) ON DELETE SET NULL;


--
-- TOC entry 6668 (class 2606 OID 33953)
-- Name: reference_point_measurement fk_reference_point; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point_measurement
    ADD CONSTRAINT fk_reference_point FOREIGN KEY (id_reference_point) REFERENCES rtls_measurement_2.reference_point(id_reference_point) ON DELETE CASCADE;


--
-- TOC entry 6670 (class 2606 OID 33621)
-- Name: setup_reference_point fk_reference_point; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_2.setup_reference_point
    ADD CONSTRAINT fk_reference_point FOREIGN KEY (id_reference_point) REFERENCES rtls_measurement_2.reference_point(id_reference_point) ON DELETE CASCADE;


--
-- TOC entry 6663 (class 2606 OID 33812)
-- Name: device fk_reference_setup; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.device
    ADD CONSTRAINT fk_reference_setup FOREIGN KEY (id_setup) REFERENCES rtls_measurement_2.setup(id_setup) ON DELETE SET NULL;


--
-- TOC entry 6669 (class 2606 OID 34247)
-- Name: reference_point_measurement fk_setup; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE ONLY rtls_measurement_2.reference_point_measurement
    ADD CONSTRAINT fk_setup FOREIGN KEY (id_setup) REFERENCES rtls_measurement_2.setup(id_setup) ON DELETE CASCADE;


--
-- TOC entry 6671 (class 2606 OID 34216)
-- Name: setup_reference_point fk_setup; Type: FK CONSTRAINT; Schema: rtls_measurement_2; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_2.setup_reference_point
    ADD CONSTRAINT fk_setup FOREIGN KEY (id_setup) REFERENCES rtls_measurement_2.setup(id_setup) ON DELETE CASCADE;


--
-- TOC entry 6673 (class 2606 OID 33555)
-- Name: batch_job_execution_context job_exec_ctx_fk; Type: FK CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_execution_context
    ADD CONSTRAINT job_exec_ctx_fk FOREIGN KEY (job_execution_id) REFERENCES rtls_measurement_etl.batch_job_execution(job_execution_id);


--
-- TOC entry 6674 (class 2606 OID 34236)
-- Name: batch_job_execution_params job_exec_params_fk; Type: FK CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_execution_params
    ADD CONSTRAINT job_exec_params_fk FOREIGN KEY (job_execution_id) REFERENCES rtls_measurement_etl.batch_job_execution(job_execution_id);


--
-- TOC entry 6675 (class 2606 OID 34191)
-- Name: batch_step_execution job_exec_step_fk; Type: FK CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_step_execution
    ADD CONSTRAINT job_exec_step_fk FOREIGN KEY (job_execution_id) REFERENCES rtls_measurement_etl.batch_job_execution(job_execution_id);


--
-- TOC entry 6672 (class 2606 OID 34221)
-- Name: batch_job_execution job_inst_exec_fk; Type: FK CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_job_execution
    ADD CONSTRAINT job_inst_exec_fk FOREIGN KEY (job_instance_id) REFERENCES rtls_measurement_etl.batch_job_instance(job_instance_id);


--
-- TOC entry 6676 (class 2606 OID 33872)
-- Name: batch_step_execution_context step_exec_ctx_fk; Type: FK CONSTRAINT; Schema: rtls_measurement_etl; Owner: supabase_admin
--

ALTER TABLE ONLY rtls_measurement_etl.batch_step_execution_context
    ADD CONSTRAINT step_exec_ctx_fk FOREIGN KEY (step_execution_id) REFERENCES rtls_measurement_etl.batch_step_execution(step_execution_id);


--
-- TOC entry 6677 (class 2606 OID 33652)
-- Name: device_status device_status_id_device_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.device_status
    ADD CONSTRAINT device_status_id_device_fkey FOREIGN KEY (id_device) REFERENCES rtls_config.uwb_device(id_device);


--
-- TOC entry 6680 (class 2606 OID 34381)
-- Name: position_area fk_ranging_item_position; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.position_area
    ADD CONSTRAINT fk_ranging_item_position FOREIGN KEY ("time", id_device) REFERENCES rtls_timeseries."position"("time", id_device);


--
-- TOC entry 6683 (class 2606 OID 34034)
-- Name: ranging_item fk_ranging_item_ranging; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.ranging_item
    ADD CONSTRAINT fk_ranging_item_ranging FOREIGN KEY ("time", id_device) REFERENCES rtls_timeseries.ranging("time", id_device);


--
-- TOC entry 6678 (class 2606 OID 33902)
-- Name: gateway_info gateway_info_id_gateway_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.gateway_info
    ADD CONSTRAINT gateway_info_id_gateway_fkey FOREIGN KEY (id_gateway) REFERENCES rtls_config.gateway(id_gateway);


--
-- TOC entry 6681 (class 2606 OID 33979)
-- Name: position_area position_area_id_area_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.position_area
    ADD CONSTRAINT position_area_id_area_fkey FOREIGN KEY (id_area) REFERENCES rtls_config.area(id_area);


--
-- TOC entry 6679 (class 2606 OID 34317)
-- Name: position position_id_device_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries."position"
    ADD CONSTRAINT position_id_device_fkey FOREIGN KEY (id_device) REFERENCES rtls_config.uwb_device(id_device);


--
-- TOC entry 6682 (class 2606 OID 33757)
-- Name: ranging ranging_id_device_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.ranging
    ADD CONSTRAINT ranging_id_device_fkey FOREIGN KEY (id_device) REFERENCES rtls_config.uwb_device(id_device);


--
-- TOC entry 6684 (class 2606 OID 33822)
-- Name: ranging_item ranging_item_id_device_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.ranging_item
    ADD CONSTRAINT ranging_item_id_device_fkey FOREIGN KEY (id_device) REFERENCES rtls_config.uwb_device(id_device);


--
-- TOC entry 6685 (class 2606 OID 34134)
-- Name: ranging_item ranging_item_opposite_id_device_fkey; Type: FK CONSTRAINT; Schema: rtls_timeseries; Owner: supabase_admin
--

ALTER TABLE rtls_timeseries.ranging_item
    ADD CONSTRAINT ranging_item_opposite_id_device_fkey FOREIGN KEY (opposite_id_device) REFERENCES rtls_config.uwb_device(id_device);


--
-- TOC entry 6686 (class 2606 OID 33561)
-- Name: iceberg_namespaces iceberg_namespaces_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- TOC entry 6687 (class 2606 OID 33566)
-- Name: iceberg_tables iceberg_tables_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- TOC entry 6688 (class 2606 OID 34226)
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- TOC entry 6689 (class 2606 OID 33702)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 6690 (class 2606 OID 33732)
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 6691 (class 2606 OID 33590)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 6692 (class 2606 OID 33878)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 6693 (class 2606 OID 34259)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 6872 (class 0 OID 32079)
-- Dependencies: 329
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6873 (class 0 OID 32088)
-- Dependencies: 330
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6874 (class 0 OID 32099)
-- Dependencies: 331
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6875 (class 0 OID 32106)
-- Dependencies: 332
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6876 (class 0 OID 32111)
-- Dependencies: 333
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6877 (class 0 OID 32116)
-- Dependencies: 334
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6878 (class 0 OID 32121)
-- Dependencies: 335
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6879 (class 0 OID 32126)
-- Dependencies: 336
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6880 (class 0 OID 32134)
-- Dependencies: 337
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6881 (class 0 OID 32140)
-- Dependencies: 339
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6882 (class 0 OID 32148)
-- Dependencies: 340
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6883 (class 0 OID 32154)
-- Dependencies: 341
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6884 (class 0 OID 32157)
-- Dependencies: 342
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6885 (class 0 OID 32162)
-- Dependencies: 343
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6886 (class 0 OID 32168)
-- Dependencies: 344
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6887 (class 0 OID 32174)
-- Dependencies: 345
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6917 (class 3256 OID 34293)
-- Name: user_roles Allow adding roles with ordering restrictions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow adding roles with ordering restrictions" ON public.user_roles FOR INSERT WITH CHECK ((private.authorize('profiles.update'::text) AND (EXISTS ( SELECT 1
   FROM public.roles r
  WHERE ((r.id = user_roles.role_id) AND (r.ordering >= private.get_user_min_role_ordering(auth.uid())))))));


--
-- TOC entry 8017 (class 0 OID 0)
-- Dependencies: 6917
-- Name: POLICY "Allow adding roles with ordering restrictions" ON user_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON POLICY "Allow adding roles with ordering restrictions" ON public.user_roles IS 'Users can only assign roles with higher ordering numbers (less privilege) than their own most privileged role';


--
-- TOC entry 6905 (class 3256 OID 34268)
-- Name: profiles Allow admin to create new profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to create new profiles" ON public.profiles FOR INSERT WITH CHECK (private.authorize('profiles.create'::text));


--
-- TOC entry 6909 (class 3256 OID 34282)
-- Name: roles Allow admin to create roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to create roles" ON public.roles FOR INSERT WITH CHECK (private.authorize('roles.create'::text));


--
-- TOC entry 6906 (class 3256 OID 34258)
-- Name: profiles Allow admin to delete all profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to delete all profiles" ON public.profiles FOR DELETE USING (private.authorize('profiles.delete'::text));


--
-- TOC entry 6912 (class 3256 OID 33901)
-- Name: roles Allow admin to delete roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to delete roles" ON public.roles FOR DELETE USING (private.authorize('roles.delete'::text));


--
-- TOC entry 6911 (class 3256 OID 33952)
-- Name: roles Allow admin to update roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to update roles" ON public.roles FOR UPDATE USING (private.authorize('roles.update'::text));


--
-- TOC entry 6902 (class 3256 OID 34477)
-- Name: profiles Allow admin to view all profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to view all profiles" ON public.profiles FOR SELECT USING (private.authorize('profiles.read'::text));


--
-- TOC entry 6910 (class 3256 OID 34166)
-- Name: roles Allow admin to view all roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to view all roles" ON public.roles FOR SELECT USING (private.authorize('roles.read'::text));


--
-- TOC entry 6916 (class 3256 OID 34295)
-- Name: user_roles Allow admin to view roles for any user; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow admin to view roles for any user" ON public.user_roles FOR SELECT USING (private.authorize('profiles.read'::text));


--
-- TOC entry 6914 (class 3256 OID 34487)
-- Name: user_roles Allow auth admin to read user roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow auth admin to read user roles" ON public.user_roles FOR SELECT TO supabase_auth_admin USING (true);


--
-- TOC entry 6915 (class 3256 OID 34483)
-- Name: user_roles Allow deleting roles with ordering restrictions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow deleting roles with ordering restrictions" ON public.user_roles FOR DELETE USING ((private.authorize('profiles.delete'::text) AND (EXISTS ( SELECT 1
   FROM public.roles r
  WHERE ((r.id = user_roles.role_id) AND (r.ordering >= private.get_user_min_role_ordering(auth.uid())))))));


--
-- TOC entry 8018 (class 0 OID 0)
-- Dependencies: 6915
-- Name: POLICY "Allow deleting roles with ordering restrictions" ON user_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON POLICY "Allow deleting roles with ordering restrictions" ON public.user_roles IS 'Users can only remove roles with higher ordering numbers (less privilege) than their own most privileged role';


--
-- TOC entry 6904 (class 3256 OID 34275)
-- Name: profiles Allow logged-in users to update their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow logged-in users to update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 6903 (class 3256 OID 34281)
-- Name: profiles Allow logged-in users to view their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow logged-in users to view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- TOC entry 6919 (class 3256 OID 34190)
-- Name: user_roles Allow service role to bypass ordering restrictions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow service role to bypass ordering restrictions" ON public.user_roles FOR INSERT TO supabase_auth_admin WITH CHECK (true);


--
-- TOC entry 8019 (class 0 OID 0)
-- Dependencies: 6919
-- Name: POLICY "Allow service role to bypass ordering restrictions" ON user_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON POLICY "Allow service role to bypass ordering restrictions" ON public.user_roles IS 'Service role can bypass all role ordering restrictions so user creation is possible.';


--
-- TOC entry 6907 (class 3256 OID 33900)
-- Name: profiles Allow updating profiles with ordering restrictions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow updating profiles with ordering restrictions" ON public.profiles FOR UPDATE USING ((private.authorize('profiles.update'::text) AND (private.get_user_min_role_ordering(auth.uid()) < private.get_user_min_role_ordering(id))));


--
-- TOC entry 8020 (class 0 OID 0)
-- Dependencies: 6907
-- Name: POLICY "Allow updating profiles with ordering restrictions" ON profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON POLICY "Allow updating profiles with ordering restrictions" ON public.profiles IS 'Users can only update profiles of users with higher role ordering numbers (less privilege) than their own most privileged role';


--
-- TOC entry 6908 (class 3256 OID 34480)
-- Name: roles Allow users to view their own role data; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow users to view their own role data" ON public.roles FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.user_roles
  WHERE ((user_roles.user_id = auth.uid()) AND (user_roles.role_id = roles.id)))));


--
-- TOC entry 6918 (class 3256 OID 34478)
-- Name: user_roles Allow users to view their own roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow users to view their own roles" ON public.user_roles FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 6888 (class 0 OID 32189)
-- Dependencies: 346
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6889 (class 0 OID 32198)
-- Dependencies: 347
-- Name: roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6891 (class 0 OID 32264)
-- Dependencies: 358
-- Name: user_roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6913 (class 3256 OID 34482)
-- Name: reference_point Allow users with reference_points.read permission to select; Type: POLICY; Schema: rtls_measurement; Owner: supabase_admin
--

CREATE POLICY "Allow users with reference_points.read permission to select" ON rtls_measurement.reference_point FOR SELECT USING (private.authorize('reference_points.read'::text));


--
-- TOC entry 6890 (class 0 OID 32229)
-- Dependencies: 352
-- Name: reference_point; Type: ROW SECURITY; Schema: rtls_measurement; Owner: supabase_admin
--

ALTER TABLE rtls_measurement.reference_point ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6920 (class 3256 OID 34481)
-- Name: reference_point Allow users with reference_points.read permission to select; Type: POLICY; Schema: rtls_measurement_2; Owner: postgres
--

CREATE POLICY "Allow users with reference_points.read permission to select" ON rtls_measurement_2.reference_point FOR SELECT USING (private.authorize('reference_points.read'::text));


--
-- TOC entry 6892 (class 0 OID 32369)
-- Dependencies: 384
-- Name: reference_point; Type: ROW SECURITY; Schema: rtls_measurement_2; Owner: postgres
--

ALTER TABLE rtls_measurement_2.reference_point ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6923 (class 3256 OID 33899)
-- Name: objects Avatar images are publicly accessible; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Avatar images are publicly accessible" ON storage.objects FOR SELECT TO authenticated, anon USING ((bucket_id = 'avatars'::text));


--
-- TOC entry 6922 (class 3256 OID 34294)
-- Name: objects Deny delete operations on avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Deny delete operations on avatars" ON storage.objects FOR DELETE TO authenticated, anon USING (((bucket_id = 'avatars'::text) AND false));


--
-- TOC entry 6921 (class 3256 OID 34380)
-- Name: objects Deny insert operations on avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Deny insert operations on avatars" ON storage.objects FOR INSERT TO authenticated, anon WITH CHECK (((bucket_id = 'avatars'::text) AND false));


--
-- TOC entry 6924 (class 3256 OID 33626)
-- Name: objects Deny update operations on avatars; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Deny update operations on avatars" ON storage.objects FOR UPDATE TO authenticated, anon USING (((bucket_id = 'avatars'::text) AND false));


--
-- TOC entry 6893 (class 0 OID 32832)
-- Dependencies: 496
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6894 (class 0 OID 32842)
-- Dependencies: 497
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6895 (class 0 OID 32851)
-- Dependencies: 498
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6896 (class 0 OID 32859)
-- Dependencies: 499
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6897 (class 0 OID 32867)
-- Dependencies: 500
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6898 (class 0 OID 32871)
-- Dependencies: 501
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6899 (class 0 OID 32881)
-- Dependencies: 502
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6900 (class 0 OID 32889)
-- Dependencies: 503
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6901 (class 0 OID 32896)
-- Dependencies: 504
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 6925 (class 6104 OID 34479)
-- Name: logflare_pub; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION logflare_pub WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION logflare_pub OWNER TO supabase_admin;

--
-- TOC entry 6926 (class 6104 OID 34476)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 6936 (class 6106 OID 34494)
-- Name: logflare_pub backends; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.backends;


--
-- TOC entry 6932 (class 6106 OID 34490)
-- Name: logflare_pub billing_accounts; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.billing_accounts;


--
-- TOC entry 6938 (class 6106 OID 34496)
-- Name: logflare_pub oauth_access_tokens; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.oauth_access_tokens;


--
-- TOC entry 6934 (class 6106 OID 34492)
-- Name: logflare_pub plans; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.plans;


--
-- TOC entry 6931 (class 6106 OID 34489)
-- Name: logflare_pub rules; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.rules;


--
-- TOC entry 6928 (class 6106 OID 34485)
-- Name: logflare_pub source_schemas; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.source_schemas;


--
-- TOC entry 6929 (class 6106 OID 34486)
-- Name: logflare_pub sources; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.sources;


--
-- TOC entry 6937 (class 6106 OID 34495)
-- Name: logflare_pub team_users; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.team_users;


--
-- TOC entry 6935 (class 6106 OID 34493)
-- Name: logflare_pub users; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.users;


--
-- TOC entry 6927 (class 6106 OID 34484)
-- Name: supabase_realtime profiles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.profiles;


--
-- TOC entry 6930 (class 6106 OID 34488)
-- Name: supabase_realtime roles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.roles;


--
-- TOC entry 6933 (class 6106 OID 34491)
-- Name: supabase_realtime user_roles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.user_roles;


--
-- TOC entry 6944 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 6945 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 6947 (class 0 OID 0)
-- Dependencies: 24
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- TOC entry 6948 (class 0 OID 0)
-- Dependencies: 25
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;
GRANT USAGE ON SCHEMA public TO supabase_auth_admin;


--
-- TOC entry 6949 (class 0 OID 0)
-- Dependencies: 26
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;


--
-- TOC entry 6950 (class 0 OID 0)
-- Dependencies: 27
-- Name: SCHEMA rtls_config; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA rtls_config TO anon;
GRANT USAGE ON SCHEMA rtls_config TO authenticated;
GRANT USAGE ON SCHEMA rtls_config TO service_role;


--
-- TOC entry 6951 (class 0 OID 0)
-- Dependencies: 28
-- Name: SCHEMA rtls_measurement; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA rtls_measurement TO anon;
GRANT USAGE ON SCHEMA rtls_measurement TO authenticated;
GRANT USAGE ON SCHEMA rtls_measurement TO service_role;


--
-- TOC entry 6952 (class 0 OID 0)
-- Dependencies: 37
-- Name: SCHEMA rtls_measurement_2; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA rtls_measurement_2 TO anon;
GRANT USAGE ON SCHEMA rtls_measurement_2 TO authenticated;


--
-- TOC entry 6953 (class 0 OID 0)
-- Dependencies: 38
-- Name: SCHEMA rtls_timeseries; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA rtls_timeseries TO authenticated;


--
-- TOC entry 6954 (class 0 OID 0)
-- Dependencies: 29
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 6955 (class 0 OID 0)
-- Dependencies: 30
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- TOC entry 6956 (class 0 OID 0)
-- Dependencies: 39
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 6964 (class 0 OID 0)
-- Dependencies: 617
-- Name: FUNCTION box2d_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6965 (class 0 OID 0)
-- Dependencies: 1108
-- Name: FUNCTION box2d_out(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d_out(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6966 (class 0 OID 0)
-- Dependencies: 1392
-- Name: FUNCTION box2df_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2df_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6967 (class 0 OID 0)
-- Dependencies: 1265
-- Name: FUNCTION box2df_out(extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2df_out(extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6968 (class 0 OID 0)
-- Dependencies: 549
-- Name: FUNCTION box3d_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6969 (class 0 OID 0)
-- Dependencies: 842
-- Name: FUNCTION box3d_out(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d_out(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6970 (class 0 OID 0)
-- Dependencies: 1183
-- Name: FUNCTION geography_analyze(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_analyze(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6971 (class 0 OID 0)
-- Dependencies: 1267
-- Name: FUNCTION geography_in(cstring, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_in(cstring, oid, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6972 (class 0 OID 0)
-- Dependencies: 1198
-- Name: FUNCTION geography_out(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_out(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6973 (class 0 OID 0)
-- Dependencies: 882
-- Name: FUNCTION geography_recv(internal, oid, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_recv(internal, oid, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6974 (class 0 OID 0)
-- Dependencies: 908
-- Name: FUNCTION geography_send(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_send(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6975 (class 0 OID 0)
-- Dependencies: 546
-- Name: FUNCTION geography_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6976 (class 0 OID 0)
-- Dependencies: 547
-- Name: FUNCTION geography_typmod_out(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_typmod_out(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6977 (class 0 OID 0)
-- Dependencies: 1412
-- Name: FUNCTION geometry_analyze(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_analyze(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6978 (class 0 OID 0)
-- Dependencies: 1324
-- Name: FUNCTION geometry_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6979 (class 0 OID 0)
-- Dependencies: 659
-- Name: FUNCTION geometry_out(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_out(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6980 (class 0 OID 0)
-- Dependencies: 1120
-- Name: FUNCTION geometry_recv(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_recv(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6981 (class 0 OID 0)
-- Dependencies: 1129
-- Name: FUNCTION geometry_send(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_send(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6982 (class 0 OID 0)
-- Dependencies: 919
-- Name: FUNCTION geometry_typmod_in(cstring[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_typmod_in(cstring[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6983 (class 0 OID 0)
-- Dependencies: 947
-- Name: FUNCTION geometry_typmod_out(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_typmod_out(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6984 (class 0 OID 0)
-- Dependencies: 1031
-- Name: FUNCTION gidx_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gidx_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6985 (class 0 OID 0)
-- Dependencies: 630
-- Name: FUNCTION gidx_out(extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gidx_out(extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6986 (class 0 OID 0)
-- Dependencies: 1309
-- Name: FUNCTION spheroid_in(cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.spheroid_in(cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6987 (class 0 OID 0)
-- Dependencies: 949
-- Name: FUNCTION spheroid_out(extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.spheroid_out(extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6988 (class 0 OID 0)
-- Dependencies: 1027
-- Name: FUNCTION box3d(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6989 (class 0 OID 0)
-- Dependencies: 877
-- Name: FUNCTION geometry(extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6990 (class 0 OID 0)
-- Dependencies: 747
-- Name: FUNCTION box(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6991 (class 0 OID 0)
-- Dependencies: 809
-- Name: FUNCTION box2d(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6992 (class 0 OID 0)
-- Dependencies: 1347
-- Name: FUNCTION geometry(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6993 (class 0 OID 0)
-- Dependencies: 673
-- Name: FUNCTION geography(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6994 (class 0 OID 0)
-- Dependencies: 663
-- Name: FUNCTION geometry(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6995 (class 0 OID 0)
-- Dependencies: 1011
-- Name: FUNCTION bytea(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.bytea(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6996 (class 0 OID 0)
-- Dependencies: 692
-- Name: FUNCTION geography(extensions.geography, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(extensions.geography, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6997 (class 0 OID 0)
-- Dependencies: 1157
-- Name: FUNCTION geometry(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6998 (class 0 OID 0)
-- Dependencies: 541
-- Name: FUNCTION box(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 6999 (class 0 OID 0)
-- Dependencies: 917
-- Name: FUNCTION box2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7000 (class 0 OID 0)
-- Dependencies: 1001
-- Name: FUNCTION box3d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7001 (class 0 OID 0)
-- Dependencies: 760
-- Name: FUNCTION bytea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.bytea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7002 (class 0 OID 0)
-- Dependencies: 1272
-- Name: FUNCTION geography(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7003 (class 0 OID 0)
-- Dependencies: 1135
-- Name: FUNCTION geometry(extensions.geometry, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(extensions.geometry, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7004 (class 0 OID 0)
-- Dependencies: 724
-- Name: FUNCTION "json"(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions."json"(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7005 (class 0 OID 0)
-- Dependencies: 1086
-- Name: FUNCTION jsonb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.jsonb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7006 (class 0 OID 0)
-- Dependencies: 1229
-- Name: FUNCTION path(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.path(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7007 (class 0 OID 0)
-- Dependencies: 571
-- Name: FUNCTION point(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.point(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7008 (class 0 OID 0)
-- Dependencies: 1266
-- Name: FUNCTION polygon(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.polygon(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7009 (class 0 OID 0)
-- Dependencies: 1245
-- Name: FUNCTION text(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.text(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7010 (class 0 OID 0)
-- Dependencies: 1061
-- Name: FUNCTION geometry(path); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(path) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7011 (class 0 OID 0)
-- Dependencies: 720
-- Name: FUNCTION geometry(point); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(point) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7012 (class 0 OID 0)
-- Dependencies: 592
-- Name: FUNCTION geometry(polygon); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(polygon) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7013 (class 0 OID 0)
-- Dependencies: 679
-- Name: FUNCTION geometry(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7015 (class 0 OID 0)
-- Dependencies: 1390
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 7016 (class 0 OID 0)
-- Dependencies: 1228
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 7018 (class 0 OID 0)
-- Dependencies: 750
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 7020 (class 0 OID 0)
-- Dependencies: 1073
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 7021 (class 0 OID 0)
-- Dependencies: 1178
-- Name: FUNCTION _postgis_deprecate(oldname text, newname text, version text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_deprecate(oldname text, newname text, version text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7022 (class 0 OID 0)
-- Dependencies: 718
-- Name: FUNCTION _postgis_index_extent(tbl regclass, col text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_index_extent(tbl regclass, col text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7023 (class 0 OID 0)
-- Dependencies: 942
-- Name: FUNCTION _postgis_join_selectivity(regclass, text, regclass, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_join_selectivity(regclass, text, regclass, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7024 (class 0 OID 0)
-- Dependencies: 814
-- Name: FUNCTION _postgis_pgsql_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_pgsql_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7025 (class 0 OID 0)
-- Dependencies: 614
-- Name: FUNCTION _postgis_scripts_pgsql_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_scripts_pgsql_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7026 (class 0 OID 0)
-- Dependencies: 722
-- Name: FUNCTION _postgis_selectivity(tbl regclass, att_name text, geom extensions.geometry, mode text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_selectivity(tbl regclass, att_name text, geom extensions.geometry, mode text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7027 (class 0 OID 0)
-- Dependencies: 806
-- Name: FUNCTION _postgis_stats(tbl regclass, att_name text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._postgis_stats(tbl regclass, att_name text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7028 (class 0 OID 0)
-- Dependencies: 1330
-- Name: FUNCTION _st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7029 (class 0 OID 0)
-- Dependencies: 1243
-- Name: FUNCTION _st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7030 (class 0 OID 0)
-- Dependencies: 1420
-- Name: FUNCTION _st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7031 (class 0 OID 0)
-- Dependencies: 1227
-- Name: FUNCTION _st_asgml(integer, extensions.geometry, integer, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_asgml(integer, extensions.geometry, integer, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7032 (class 0 OID 0)
-- Dependencies: 1308
-- Name: FUNCTION _st_asx3d(integer, extensions.geometry, integer, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_asx3d(integer, extensions.geometry, integer, integer, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7033 (class 0 OID 0)
-- Dependencies: 767
-- Name: FUNCTION _st_bestsrid(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_bestsrid(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7034 (class 0 OID 0)
-- Dependencies: 652
-- Name: FUNCTION _st_bestsrid(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_bestsrid(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7035 (class 0 OID 0)
-- Dependencies: 1037
-- Name: FUNCTION _st_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7036 (class 0 OID 0)
-- Dependencies: 1078
-- Name: FUNCTION _st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7037 (class 0 OID 0)
-- Dependencies: 957
-- Name: FUNCTION _st_coveredby(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_coveredby(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7038 (class 0 OID 0)
-- Dependencies: 575
-- Name: FUNCTION _st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7039 (class 0 OID 0)
-- Dependencies: 1121
-- Name: FUNCTION _st_covers(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_covers(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7040 (class 0 OID 0)
-- Dependencies: 856
-- Name: FUNCTION _st_covers(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_covers(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7041 (class 0 OID 0)
-- Dependencies: 1114
-- Name: FUNCTION _st_crosses(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_crosses(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7042 (class 0 OID 0)
-- Dependencies: 944
-- Name: FUNCTION _st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7043 (class 0 OID 0)
-- Dependencies: 637
-- Name: FUNCTION _st_distancetree(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distancetree(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7044 (class 0 OID 0)
-- Dependencies: 840
-- Name: FUNCTION _st_distancetree(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distancetree(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7045 (class 0 OID 0)
-- Dependencies: 1017
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7046 (class 0 OID 0)
-- Dependencies: 748
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7047 (class 0 OID 0)
-- Dependencies: 1009
-- Name: FUNCTION _st_distanceuncached(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_distanceuncached(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7048 (class 0 OID 0)
-- Dependencies: 1327
-- Name: FUNCTION _st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7049 (class 0 OID 0)
-- Dependencies: 779
-- Name: FUNCTION _st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7050 (class 0 OID 0)
-- Dependencies: 753
-- Name: FUNCTION _st_dwithinuncached(extensions.geography, extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithinuncached(extensions.geography, extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7051 (class 0 OID 0)
-- Dependencies: 1119
-- Name: FUNCTION _st_dwithinuncached(extensions.geography, extensions.geography, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_dwithinuncached(extensions.geography, extensions.geography, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7052 (class 0 OID 0)
-- Dependencies: 1380
-- Name: FUNCTION _st_equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7053 (class 0 OID 0)
-- Dependencies: 1385
-- Name: FUNCTION _st_expand(extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_expand(extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7054 (class 0 OID 0)
-- Dependencies: 1376
-- Name: FUNCTION _st_geomfromgml(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_geomfromgml(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7055 (class 0 OID 0)
-- Dependencies: 1321
-- Name: FUNCTION _st_intersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_intersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7056 (class 0 OID 0)
-- Dependencies: 912
-- Name: FUNCTION _st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7057 (class 0 OID 0)
-- Dependencies: 795
-- Name: FUNCTION _st_longestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_longestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7058 (class 0 OID 0)
-- Dependencies: 1118
-- Name: FUNCTION _st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7059 (class 0 OID 0)
-- Dependencies: 745
-- Name: FUNCTION _st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7060 (class 0 OID 0)
-- Dependencies: 570
-- Name: FUNCTION _st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7061 (class 0 OID 0)
-- Dependencies: 1201
-- Name: FUNCTION _st_pointoutside(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_pointoutside(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7062 (class 0 OID 0)
-- Dependencies: 1015
-- Name: FUNCTION _st_sortablehash(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_sortablehash(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7063 (class 0 OID 0)
-- Dependencies: 1382
-- Name: FUNCTION _st_touches(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_touches(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7064 (class 0 OID 0)
-- Dependencies: 811
-- Name: FUNCTION _st_voronoi(g1 extensions.geometry, clip extensions.geometry, tolerance double precision, return_polygons boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_voronoi(g1 extensions.geometry, clip extensions.geometry, tolerance double precision, return_polygons boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7065 (class 0 OID 0)
-- Dependencies: 1055
-- Name: FUNCTION _st_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions._st_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7066 (class 0 OID 0)
-- Dependencies: 1433
-- Name: FUNCTION addauth(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addauth(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7067 (class 0 OID 0)
-- Dependencies: 967
-- Name: FUNCTION addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7068 (class 0 OID 0)
-- Dependencies: 916
-- Name: FUNCTION addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying, new_srid integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7069 (class 0 OID 0)
-- Dependencies: 539
-- Name: FUNCTION addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.addgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer, new_type character varying, new_dim integer, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7070 (class 0 OID 0)
-- Dependencies: 1413
-- Name: FUNCTION airtable_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.airtable_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7071 (class 0 OID 0)
-- Dependencies: 670
-- Name: FUNCTION airtable_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.airtable_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7072 (class 0 OID 0)
-- Dependencies: 864
-- Name: FUNCTION airtable_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.airtable_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7073 (class 0 OID 0)
-- Dependencies: 680
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7074 (class 0 OID 0)
-- Dependencies: 1185
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7075 (class 0 OID 0)
-- Dependencies: 979
-- Name: FUNCTION auth0_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.auth0_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7076 (class 0 OID 0)
-- Dependencies: 1100
-- Name: FUNCTION auth0_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.auth0_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7077 (class 0 OID 0)
-- Dependencies: 1275
-- Name: FUNCTION auth0_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.auth0_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7078 (class 0 OID 0)
-- Dependencies: 628
-- Name: FUNCTION big_query_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.big_query_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7079 (class 0 OID 0)
-- Dependencies: 552
-- Name: FUNCTION big_query_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.big_query_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7080 (class 0 OID 0)
-- Dependencies: 803
-- Name: FUNCTION big_query_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.big_query_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7081 (class 0 OID 0)
-- Dependencies: 1315
-- Name: FUNCTION box3dtobox(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.box3dtobox(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7082 (class 0 OID 0)
-- Dependencies: 1060
-- Name: FUNCTION checkauth(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauth(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7083 (class 0 OID 0)
-- Dependencies: 785
-- Name: FUNCTION checkauth(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauth(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7084 (class 0 OID 0)
-- Dependencies: 1065
-- Name: FUNCTION checkauthtrigger(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.checkauthtrigger() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7085 (class 0 OID 0)
-- Dependencies: 988
-- Name: FUNCTION click_house_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.click_house_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7086 (class 0 OID 0)
-- Dependencies: 763
-- Name: FUNCTION click_house_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.click_house_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7087 (class 0 OID 0)
-- Dependencies: 1109
-- Name: FUNCTION click_house_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.click_house_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7088 (class 0 OID 0)
-- Dependencies: 962
-- Name: FUNCTION cognito_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cognito_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7089 (class 0 OID 0)
-- Dependencies: 937
-- Name: FUNCTION cognito_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cognito_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7090 (class 0 OID 0)
-- Dependencies: 905
-- Name: FUNCTION cognito_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.cognito_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7091 (class 0 OID 0)
-- Dependencies: 781
-- Name: FUNCTION contains_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7092 (class 0 OID 0)
-- Dependencies: 734
-- Name: FUNCTION contains_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7093 (class 0 OID 0)
-- Dependencies: 1190
-- Name: FUNCTION contains_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.contains_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7094 (class 0 OID 0)
-- Dependencies: 1184
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7095 (class 0 OID 0)
-- Dependencies: 625
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7096 (class 0 OID 0)
-- Dependencies: 1113
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7097 (class 0 OID 0)
-- Dependencies: 1211
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7098 (class 0 OID 0)
-- Dependencies: 1268
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7099 (class 0 OID 0)
-- Dependencies: 857
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7100 (class 0 OID 0)
-- Dependencies: 1143
-- Name: FUNCTION disablelongtransactions(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.disablelongtransactions() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7101 (class 0 OID 0)
-- Dependencies: 959
-- Name: FUNCTION dropgeometrycolumn(table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7102 (class 0 OID 0)
-- Dependencies: 1034
-- Name: FUNCTION dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(schema_name character varying, table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7103 (class 0 OID 0)
-- Dependencies: 1395
-- Name: FUNCTION dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrycolumn(catalog_name character varying, schema_name character varying, table_name character varying, column_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7104 (class 0 OID 0)
-- Dependencies: 1248
-- Name: FUNCTION dropgeometrytable(table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(table_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7105 (class 0 OID 0)
-- Dependencies: 580
-- Name: FUNCTION dropgeometrytable(schema_name character varying, table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(schema_name character varying, table_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7106 (class 0 OID 0)
-- Dependencies: 786
-- Name: FUNCTION dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dropgeometrytable(catalog_name character varying, schema_name character varying, table_name character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7107 (class 0 OID 0)
-- Dependencies: 1014
-- Name: FUNCTION duckdb_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.duckdb_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7108 (class 0 OID 0)
-- Dependencies: 1223
-- Name: FUNCTION duckdb_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.duckdb_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7109 (class 0 OID 0)
-- Dependencies: 778
-- Name: FUNCTION duckdb_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.duckdb_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7110 (class 0 OID 0)
-- Dependencies: 1401
-- Name: FUNCTION enablelongtransactions(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.enablelongtransactions() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7111 (class 0 OID 0)
-- Dependencies: 1231
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7112 (class 0 OID 0)
-- Dependencies: 834
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7113 (class 0 OID 0)
-- Dependencies: 1220
-- Name: FUNCTION equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7114 (class 0 OID 0)
-- Dependencies: 1124
-- Name: FUNCTION find_srid(character varying, character varying, character varying); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.find_srid(character varying, character varying, character varying) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7115 (class 0 OID 0)
-- Dependencies: 827
-- Name: FUNCTION firebase_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.firebase_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7116 (class 0 OID 0)
-- Dependencies: 704
-- Name: FUNCTION firebase_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.firebase_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7117 (class 0 OID 0)
-- Dependencies: 1077
-- Name: FUNCTION firebase_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.firebase_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7118 (class 0 OID 0)
-- Dependencies: 1067
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7119 (class 0 OID 0)
-- Dependencies: 1313
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7120 (class 0 OID 0)
-- Dependencies: 780
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7121 (class 0 OID 0)
-- Dependencies: 1169
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7122 (class 0 OID 0)
-- Dependencies: 1294
-- Name: FUNCTION geog_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geog_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7123 (class 0 OID 0)
-- Dependencies: 823
-- Name: FUNCTION geography_cmp(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_cmp(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7124 (class 0 OID 0)
-- Dependencies: 1344
-- Name: FUNCTION geography_distance_knn(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_distance_knn(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7125 (class 0 OID 0)
-- Dependencies: 762
-- Name: FUNCTION geography_eq(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_eq(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7126 (class 0 OID 0)
-- Dependencies: 561
-- Name: FUNCTION geography_ge(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_ge(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7127 (class 0 OID 0)
-- Dependencies: 706
-- Name: FUNCTION geography_gist_compress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_compress(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7128 (class 0 OID 0)
-- Dependencies: 1351
-- Name: FUNCTION geography_gist_consistent(internal, extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_consistent(internal, extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7129 (class 0 OID 0)
-- Dependencies: 992
-- Name: FUNCTION geography_gist_decompress(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_decompress(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7130 (class 0 OID 0)
-- Dependencies: 721
-- Name: FUNCTION geography_gist_distance(internal, extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_distance(internal, extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7131 (class 0 OID 0)
-- Dependencies: 769
-- Name: FUNCTION geography_gist_penalty(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_penalty(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7132 (class 0 OID 0)
-- Dependencies: 915
-- Name: FUNCTION geography_gist_picksplit(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_picksplit(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7133 (class 0 OID 0)
-- Dependencies: 801
-- Name: FUNCTION geography_gist_same(extensions.box2d, extensions.box2d, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_same(extensions.box2d, extensions.box2d, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7134 (class 0 OID 0)
-- Dependencies: 698
-- Name: FUNCTION geography_gist_union(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gist_union(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7135 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION geography_gt(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_gt(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7136 (class 0 OID 0)
-- Dependencies: 1010
-- Name: FUNCTION geography_le(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_le(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7137 (class 0 OID 0)
-- Dependencies: 1008
-- Name: FUNCTION geography_lt(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_lt(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7138 (class 0 OID 0)
-- Dependencies: 1241
-- Name: FUNCTION geography_overlaps(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_overlaps(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7139 (class 0 OID 0)
-- Dependencies: 727
-- Name: FUNCTION geography_spgist_choose_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_choose_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7140 (class 0 OID 0)
-- Dependencies: 636
-- Name: FUNCTION geography_spgist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7141 (class 0 OID 0)
-- Dependencies: 590
-- Name: FUNCTION geography_spgist_config_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_config_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7142 (class 0 OID 0)
-- Dependencies: 1080
-- Name: FUNCTION geography_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_inner_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7143 (class 0 OID 0)
-- Dependencies: 584
-- Name: FUNCTION geography_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_leaf_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7144 (class 0 OID 0)
-- Dependencies: 611
-- Name: FUNCTION geography_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geography_spgist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7145 (class 0 OID 0)
-- Dependencies: 1255
-- Name: FUNCTION geom2d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom2d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7146 (class 0 OID 0)
-- Dependencies: 687
-- Name: FUNCTION geom3d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom3d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7147 (class 0 OID 0)
-- Dependencies: 598
-- Name: FUNCTION geom4d_brin_inclusion_add_value(internal, internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geom4d_brin_inclusion_add_value(internal, internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7148 (class 0 OID 0)
-- Dependencies: 953
-- Name: FUNCTION geometry_above(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_above(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7149 (class 0 OID 0)
-- Dependencies: 1378
-- Name: FUNCTION geometry_below(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_below(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7150 (class 0 OID 0)
-- Dependencies: 835
-- Name: FUNCTION geometry_cmp(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_cmp(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7151 (class 0 OID 0)
-- Dependencies: 1342
-- Name: FUNCTION geometry_contained_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contained_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7152 (class 0 OID 0)
-- Dependencies: 1257
-- Name: FUNCTION geometry_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7153 (class 0 OID 0)
-- Dependencies: 671
-- Name: FUNCTION geometry_contains_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7154 (class 0 OID 0)
-- Dependencies: 838
-- Name: FUNCTION geometry_contains_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_contains_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7155 (class 0 OID 0)
-- Dependencies: 697
-- Name: FUNCTION geometry_distance_box(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_box(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7156 (class 0 OID 0)
-- Dependencies: 1131
-- Name: FUNCTION geometry_distance_centroid(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_centroid(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7157 (class 0 OID 0)
-- Dependencies: 1071
-- Name: FUNCTION geometry_distance_centroid_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_centroid_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7158 (class 0 OID 0)
-- Dependencies: 1305
-- Name: FUNCTION geometry_distance_cpa(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_distance_cpa(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7159 (class 0 OID 0)
-- Dependencies: 1407
-- Name: FUNCTION geometry_eq(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_eq(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7160 (class 0 OID 0)
-- Dependencies: 1146
-- Name: FUNCTION geometry_ge(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_ge(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7161 (class 0 OID 0)
-- Dependencies: 554
-- Name: FUNCTION geometry_gist_compress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_compress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7162 (class 0 OID 0)
-- Dependencies: 1367
-- Name: FUNCTION geometry_gist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7163 (class 0 OID 0)
-- Dependencies: 1259
-- Name: FUNCTION geometry_gist_consistent_2d(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_consistent_2d(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7164 (class 0 OID 0)
-- Dependencies: 685
-- Name: FUNCTION geometry_gist_consistent_nd(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_consistent_nd(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7165 (class 0 OID 0)
-- Dependencies: 940
-- Name: FUNCTION geometry_gist_decompress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_decompress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7166 (class 0 OID 0)
-- Dependencies: 1138
-- Name: FUNCTION geometry_gist_decompress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_decompress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7167 (class 0 OID 0)
-- Dependencies: 1286
-- Name: FUNCTION geometry_gist_distance_2d(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_distance_2d(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7168 (class 0 OID 0)
-- Dependencies: 1318
-- Name: FUNCTION geometry_gist_distance_nd(internal, extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_distance_nd(internal, extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7169 (class 0 OID 0)
-- Dependencies: 1439
-- Name: FUNCTION geometry_gist_penalty_2d(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_penalty_2d(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7170 (class 0 OID 0)
-- Dependencies: 1099
-- Name: FUNCTION geometry_gist_penalty_nd(internal, internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_penalty_nd(internal, internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7171 (class 0 OID 0)
-- Dependencies: 619
-- Name: FUNCTION geometry_gist_picksplit_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_picksplit_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7172 (class 0 OID 0)
-- Dependencies: 954
-- Name: FUNCTION geometry_gist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7173 (class 0 OID 0)
-- Dependencies: 996
-- Name: FUNCTION geometry_gist_same_2d(geom1 extensions.geometry, geom2 extensions.geometry, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_same_2d(geom1 extensions.geometry, geom2 extensions.geometry, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7174 (class 0 OID 0)
-- Dependencies: 1165
-- Name: FUNCTION geometry_gist_same_nd(extensions.geometry, extensions.geometry, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_same_nd(extensions.geometry, extensions.geometry, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7175 (class 0 OID 0)
-- Dependencies: 622
-- Name: FUNCTION geometry_gist_sortsupport_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_sortsupport_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7176 (class 0 OID 0)
-- Dependencies: 1285
-- Name: FUNCTION geometry_gist_union_2d(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_union_2d(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7177 (class 0 OID 0)
-- Dependencies: 1333
-- Name: FUNCTION geometry_gist_union_nd(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gist_union_nd(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7178 (class 0 OID 0)
-- Dependencies: 1408
-- Name: FUNCTION geometry_gt(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_gt(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7179 (class 0 OID 0)
-- Dependencies: 788
-- Name: FUNCTION geometry_hash(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_hash(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7180 (class 0 OID 0)
-- Dependencies: 1057
-- Name: FUNCTION geometry_le(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_le(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7181 (class 0 OID 0)
-- Dependencies: 699
-- Name: FUNCTION geometry_left(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_left(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7182 (class 0 OID 0)
-- Dependencies: 597
-- Name: FUNCTION geometry_lt(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_lt(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7183 (class 0 OID 0)
-- Dependencies: 641
-- Name: FUNCTION geometry_overabove(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overabove(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7184 (class 0 OID 0)
-- Dependencies: 1331
-- Name: FUNCTION geometry_overbelow(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overbelow(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7185 (class 0 OID 0)
-- Dependencies: 1429
-- Name: FUNCTION geometry_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7186 (class 0 OID 0)
-- Dependencies: 866
-- Name: FUNCTION geometry_overlaps_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7187 (class 0 OID 0)
-- Dependencies: 1434
-- Name: FUNCTION geometry_overlaps_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overlaps_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7188 (class 0 OID 0)
-- Dependencies: 607
-- Name: FUNCTION geometry_overleft(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overleft(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7189 (class 0 OID 0)
-- Dependencies: 1174
-- Name: FUNCTION geometry_overright(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_overright(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7190 (class 0 OID 0)
-- Dependencies: 702
-- Name: FUNCTION geometry_right(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_right(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7191 (class 0 OID 0)
-- Dependencies: 1293
-- Name: FUNCTION geometry_same(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7192 (class 0 OID 0)
-- Dependencies: 1212
-- Name: FUNCTION geometry_same_3d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same_3d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7193 (class 0 OID 0)
-- Dependencies: 1033
-- Name: FUNCTION geometry_same_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_same_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7194 (class 0 OID 0)
-- Dependencies: 1046
-- Name: FUNCTION geometry_sortsupport(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_sortsupport(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7195 (class 0 OID 0)
-- Dependencies: 932
-- Name: FUNCTION geometry_spgist_choose_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7196 (class 0 OID 0)
-- Dependencies: 695
-- Name: FUNCTION geometry_spgist_choose_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7197 (class 0 OID 0)
-- Dependencies: 1262
-- Name: FUNCTION geometry_spgist_choose_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_choose_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7198 (class 0 OID 0)
-- Dependencies: 1106
-- Name: FUNCTION geometry_spgist_compress_2d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_2d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7199 (class 0 OID 0)
-- Dependencies: 1340
-- Name: FUNCTION geometry_spgist_compress_3d(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_3d(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7200 (class 0 OID 0)
-- Dependencies: 869
-- Name: FUNCTION geometry_spgist_compress_nd(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_compress_nd(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7201 (class 0 OID 0)
-- Dependencies: 742
-- Name: FUNCTION geometry_spgist_config_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7202 (class 0 OID 0)
-- Dependencies: 1402
-- Name: FUNCTION geometry_spgist_config_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7203 (class 0 OID 0)
-- Dependencies: 705
-- Name: FUNCTION geometry_spgist_config_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_config_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7204 (class 0 OID 0)
-- Dependencies: 1193
-- Name: FUNCTION geometry_spgist_inner_consistent_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7205 (class 0 OID 0)
-- Dependencies: 1221
-- Name: FUNCTION geometry_spgist_inner_consistent_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7206 (class 0 OID 0)
-- Dependencies: 551
-- Name: FUNCTION geometry_spgist_inner_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_inner_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7207 (class 0 OID 0)
-- Dependencies: 672
-- Name: FUNCTION geometry_spgist_leaf_consistent_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7208 (class 0 OID 0)
-- Dependencies: 1240
-- Name: FUNCTION geometry_spgist_leaf_consistent_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7209 (class 0 OID 0)
-- Dependencies: 1023
-- Name: FUNCTION geometry_spgist_leaf_consistent_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_leaf_consistent_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7210 (class 0 OID 0)
-- Dependencies: 1278
-- Name: FUNCTION geometry_spgist_picksplit_2d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_2d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7211 (class 0 OID 0)
-- Dependencies: 1361
-- Name: FUNCTION geometry_spgist_picksplit_3d(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_3d(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7212 (class 0 OID 0)
-- Dependencies: 816
-- Name: FUNCTION geometry_spgist_picksplit_nd(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_spgist_picksplit_nd(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7213 (class 0 OID 0)
-- Dependencies: 993
-- Name: FUNCTION geometry_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7214 (class 0 OID 0)
-- Dependencies: 1050
-- Name: FUNCTION geometry_within_nd(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometry_within_nd(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7215 (class 0 OID 0)
-- Dependencies: 1302
-- Name: FUNCTION geometrytype(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometrytype(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7216 (class 0 OID 0)
-- Dependencies: 569
-- Name: FUNCTION geometrytype(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geometrytype(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7217 (class 0 OID 0)
-- Dependencies: 883
-- Name: FUNCTION geomfromewkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geomfromewkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7218 (class 0 OID 0)
-- Dependencies: 644
-- Name: FUNCTION geomfromewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.geomfromewkt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7219 (class 0 OID 0)
-- Dependencies: 966
-- Name: FUNCTION get_proj4_from_srid(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.get_proj4_from_srid(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7220 (class 0 OID 0)
-- Dependencies: 1328
-- Name: FUNCTION gettransactionid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gettransactionid() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7222 (class 0 OID 0)
-- Dependencies: 1345
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 7224 (class 0 OID 0)
-- Dependencies: 768
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7226 (class 0 OID 0)
-- Dependencies: 609
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 7227 (class 0 OID 0)
-- Dependencies: 1175
-- Name: FUNCTION gserialized_gist_joinsel_2d(internal, oid, internal, smallint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_joinsel_2d(internal, oid, internal, smallint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7228 (class 0 OID 0)
-- Dependencies: 824
-- Name: FUNCTION gserialized_gist_joinsel_nd(internal, oid, internal, smallint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_joinsel_nd(internal, oid, internal, smallint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7229 (class 0 OID 0)
-- Dependencies: 914
-- Name: FUNCTION gserialized_gist_sel_2d(internal, oid, internal, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_sel_2d(internal, oid, internal, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7230 (class 0 OID 0)
-- Dependencies: 558
-- Name: FUNCTION gserialized_gist_sel_nd(internal, oid, internal, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gserialized_gist_sel_nd(internal, oid, internal, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7231 (class 0 OID 0)
-- Dependencies: 1040
-- Name: FUNCTION hello_world_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hello_world_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7232 (class 0 OID 0)
-- Dependencies: 1276
-- Name: FUNCTION hello_world_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hello_world_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7233 (class 0 OID 0)
-- Dependencies: 820
-- Name: FUNCTION hello_world_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hello_world_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7234 (class 0 OID 0)
-- Dependencies: 889
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7235 (class 0 OID 0)
-- Dependencies: 693
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7236 (class 0 OID 0)
-- Dependencies: 1343
-- Name: FUNCTION iceberg_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.iceberg_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7237 (class 0 OID 0)
-- Dependencies: 651
-- Name: FUNCTION iceberg_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.iceberg_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7238 (class 0 OID 0)
-- Dependencies: 911
-- Name: FUNCTION iceberg_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.iceberg_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7239 (class 0 OID 0)
-- Dependencies: 1393
-- Name: FUNCTION is_contained_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7240 (class 0 OID 0)
-- Dependencies: 594
-- Name: FUNCTION is_contained_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7241 (class 0 OID 0)
-- Dependencies: 1117
-- Name: FUNCTION is_contained_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.is_contained_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7242 (class 0 OID 0)
-- Dependencies: 926
-- Name: FUNCTION lockrow(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7243 (class 0 OID 0)
-- Dependencies: 1068
-- Name: FUNCTION lockrow(text, text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7244 (class 0 OID 0)
-- Dependencies: 936
-- Name: FUNCTION lockrow(text, text, text, timestamp without time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, timestamp without time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7245 (class 0 OID 0)
-- Dependencies: 1424
-- Name: FUNCTION lockrow(text, text, text, text, timestamp without time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.lockrow(text, text, text, text, timestamp without time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7246 (class 0 OID 0)
-- Dependencies: 574
-- Name: FUNCTION logflare_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.logflare_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7247 (class 0 OID 0)
-- Dependencies: 894
-- Name: FUNCTION logflare_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.logflare_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7248 (class 0 OID 0)
-- Dependencies: 613
-- Name: FUNCTION logflare_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.logflare_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7249 (class 0 OID 0)
-- Dependencies: 1280
-- Name: FUNCTION longtransactionsenabled(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.longtransactionsenabled() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7250 (class 0 OID 0)
-- Dependencies: 848
-- Name: FUNCTION mssql_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.mssql_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7251 (class 0 OID 0)
-- Dependencies: 1161
-- Name: FUNCTION mssql_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.mssql_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7252 (class 0 OID 0)
-- Dependencies: 1283
-- Name: FUNCTION mssql_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.mssql_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7253 (class 0 OID 0)
-- Dependencies: 832
-- Name: FUNCTION overlaps_2d(extensions.box2df, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.box2df, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7254 (class 0 OID 0)
-- Dependencies: 1209
-- Name: FUNCTION overlaps_2d(extensions.box2df, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.box2df, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7255 (class 0 OID 0)
-- Dependencies: 1292
-- Name: FUNCTION overlaps_2d(extensions.geometry, extensions.box2df); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_2d(extensions.geometry, extensions.box2df) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7256 (class 0 OID 0)
-- Dependencies: 922
-- Name: FUNCTION overlaps_geog(extensions.geography, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.geography, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7257 (class 0 OID 0)
-- Dependencies: 573
-- Name: FUNCTION overlaps_geog(extensions.gidx, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.gidx, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7258 (class 0 OID 0)
-- Dependencies: 616
-- Name: FUNCTION overlaps_geog(extensions.gidx, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_geog(extensions.gidx, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7259 (class 0 OID 0)
-- Dependencies: 714
-- Name: FUNCTION overlaps_nd(extensions.geometry, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.geometry, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7260 (class 0 OID 0)
-- Dependencies: 825
-- Name: FUNCTION overlaps_nd(extensions.gidx, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.gidx, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7261 (class 0 OID 0)
-- Dependencies: 790
-- Name: FUNCTION overlaps_nd(extensions.gidx, extensions.gidx); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.overlaps_nd(extensions.gidx, extensions.gidx) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7262 (class 0 OID 0)
-- Dependencies: 1180
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7263 (class 0 OID 0)
-- Dependencies: 990
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7264 (class 0 OID 0)
-- Dependencies: 972
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7265 (class 0 OID 0)
-- Dependencies: 648
-- Name: FUNCTION pgis_asflatgeobuf_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7266 (class 0 OID 0)
-- Dependencies: 1051
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7267 (class 0 OID 0)
-- Dependencies: 833
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7268 (class 0 OID 0)
-- Dependencies: 1372
-- Name: FUNCTION pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asflatgeobuf_transfn(internal, anyelement, boolean, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7269 (class 0 OID 0)
-- Dependencies: 730
-- Name: FUNCTION pgis_asgeobuf_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7270 (class 0 OID 0)
-- Dependencies: 1319
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7271 (class 0 OID 0)
-- Dependencies: 1059
-- Name: FUNCTION pgis_asgeobuf_transfn(internal, anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asgeobuf_transfn(internal, anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7272 (class 0 OID 0)
-- Dependencies: 1400
-- Name: FUNCTION pgis_asmvt_combinefn(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_combinefn(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7273 (class 0 OID 0)
-- Dependencies: 1186
-- Name: FUNCTION pgis_asmvt_deserialfn(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_deserialfn(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7274 (class 0 OID 0)
-- Dependencies: 1284
-- Name: FUNCTION pgis_asmvt_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7275 (class 0 OID 0)
-- Dependencies: 1123
-- Name: FUNCTION pgis_asmvt_serialfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_serialfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7276 (class 0 OID 0)
-- Dependencies: 1326
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7277 (class 0 OID 0)
-- Dependencies: 983
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7278 (class 0 OID 0)
-- Dependencies: 1216
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7279 (class 0 OID 0)
-- Dependencies: 1217
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7280 (class 0 OID 0)
-- Dependencies: 1142
-- Name: FUNCTION pgis_asmvt_transfn(internal, anyelement, text, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_asmvt_transfn(internal, anyelement, text, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7281 (class 0 OID 0)
-- Dependencies: 1070
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7282 (class 0 OID 0)
-- Dependencies: 1053
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7283 (class 0 OID 0)
-- Dependencies: 1151
-- Name: FUNCTION pgis_geometry_accum_transfn(internal, extensions.geometry, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_accum_transfn(internal, extensions.geometry, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7284 (class 0 OID 0)
-- Dependencies: 1072
-- Name: FUNCTION pgis_geometry_clusterintersecting_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_clusterintersecting_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7285 (class 0 OID 0)
-- Dependencies: 981
-- Name: FUNCTION pgis_geometry_clusterwithin_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_clusterwithin_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7286 (class 0 OID 0)
-- Dependencies: 950
-- Name: FUNCTION pgis_geometry_collect_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_collect_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7287 (class 0 OID 0)
-- Dependencies: 728
-- Name: FUNCTION pgis_geometry_makeline_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_makeline_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7288 (class 0 OID 0)
-- Dependencies: 850
-- Name: FUNCTION pgis_geometry_polygonize_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_polygonize_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7289 (class 0 OID 0)
-- Dependencies: 559
-- Name: FUNCTION pgis_geometry_union_parallel_combinefn(internal, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_combinefn(internal, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7290 (class 0 OID 0)
-- Dependencies: 880
-- Name: FUNCTION pgis_geometry_union_parallel_deserialfn(bytea, internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_deserialfn(bytea, internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7291 (class 0 OID 0)
-- Dependencies: 1048
-- Name: FUNCTION pgis_geometry_union_parallel_finalfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_finalfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7292 (class 0 OID 0)
-- Dependencies: 732
-- Name: FUNCTION pgis_geometry_union_parallel_serialfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_serialfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7293 (class 0 OID 0)
-- Dependencies: 618
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_transfn(internal, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7294 (class 0 OID 0)
-- Dependencies: 1230
-- Name: FUNCTION pgis_geometry_union_parallel_transfn(internal, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgis_geometry_union_parallel_transfn(internal, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7295 (class 0 OID 0)
-- Dependencies: 839
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7296 (class 0 OID 0)
-- Dependencies: 1299
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7297 (class 0 OID 0)
-- Dependencies: 643
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7298 (class 0 OID 0)
-- Dependencies: 1403
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7299 (class 0 OID 0)
-- Dependencies: 920
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7300 (class 0 OID 0)
-- Dependencies: 593
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7301 (class 0 OID 0)
-- Dependencies: 599
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7302 (class 0 OID 0)
-- Dependencies: 1203
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7303 (class 0 OID 0)
-- Dependencies: 772
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7304 (class 0 OID 0)
-- Dependencies: 749
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7305 (class 0 OID 0)
-- Dependencies: 1019
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7306 (class 0 OID 0)
-- Dependencies: 854
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7307 (class 0 OID 0)
-- Dependencies: 1224
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7308 (class 0 OID 0)
-- Dependencies: 991
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7309 (class 0 OID 0)
-- Dependencies: 963
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7310 (class 0 OID 0)
-- Dependencies: 600
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7311 (class 0 OID 0)
-- Dependencies: 568
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7312 (class 0 OID 0)
-- Dependencies: 560
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7313 (class 0 OID 0)
-- Dependencies: 1251
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7314 (class 0 OID 0)
-- Dependencies: 696
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7315 (class 0 OID 0)
-- Dependencies: 964
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7316 (class 0 OID 0)
-- Dependencies: 585
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7317 (class 0 OID 0)
-- Dependencies: 1312
-- Name: FUNCTION populate_geometry_columns(use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_geometry_columns(use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7318 (class 0 OID 0)
-- Dependencies: 1045
-- Name: FUNCTION populate_geometry_columns(tbl_oid oid, use_typmod boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.populate_geometry_columns(tbl_oid oid, use_typmod boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7319 (class 0 OID 0)
-- Dependencies: 1260
-- Name: FUNCTION postgis_addbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_addbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7320 (class 0 OID 0)
-- Dependencies: 771
-- Name: FUNCTION postgis_cache_bbox(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_cache_bbox() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7321 (class 0 OID 0)
-- Dependencies: 872
-- Name: FUNCTION postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_dims(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7322 (class 0 OID 0)
-- Dependencies: 970
-- Name: FUNCTION postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_srid(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7323 (class 0 OID 0)
-- Dependencies: 1083
-- Name: FUNCTION postgis_constraint_type(geomschema text, geomtable text, geomcolumn text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_constraint_type(geomschema text, geomtable text, geomcolumn text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7324 (class 0 OID 0)
-- Dependencies: 1005
-- Name: FUNCTION postgis_dropbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_dropbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7325 (class 0 OID 0)
-- Dependencies: 1298
-- Name: FUNCTION postgis_extensions_upgrade(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_extensions_upgrade() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7326 (class 0 OID 0)
-- Dependencies: 1189
-- Name: FUNCTION postgis_full_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_full_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7327 (class 0 OID 0)
-- Dependencies: 1170
-- Name: FUNCTION postgis_geos_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_geos_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7328 (class 0 OID 0)
-- Dependencies: 1105
-- Name: FUNCTION postgis_geos_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_geos_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7329 (class 0 OID 0)
-- Dependencies: 719
-- Name: FUNCTION postgis_getbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_getbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7330 (class 0 OID 0)
-- Dependencies: 1032
-- Name: FUNCTION postgis_hasbbox(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_hasbbox(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7331 (class 0 OID 0)
-- Dependencies: 1042
-- Name: FUNCTION postgis_index_supportfn(internal); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_index_supportfn(internal) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7332 (class 0 OID 0)
-- Dependencies: 1250
-- Name: FUNCTION postgis_lib_build_date(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_build_date() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7333 (class 0 OID 0)
-- Dependencies: 1012
-- Name: FUNCTION postgis_lib_revision(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_revision() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7334 (class 0 OID 0)
-- Dependencies: 1419
-- Name: FUNCTION postgis_lib_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_lib_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7335 (class 0 OID 0)
-- Dependencies: 578
-- Name: FUNCTION postgis_libjson_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libjson_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7336 (class 0 OID 0)
-- Dependencies: 999
-- Name: FUNCTION postgis_liblwgeom_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_liblwgeom_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7337 (class 0 OID 0)
-- Dependencies: 576
-- Name: FUNCTION postgis_libprotobuf_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libprotobuf_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7338 (class 0 OID 0)
-- Dependencies: 793
-- Name: FUNCTION postgis_libxml_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_libxml_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7339 (class 0 OID 0)
-- Dependencies: 691
-- Name: FUNCTION postgis_noop(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_noop(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7340 (class 0 OID 0)
-- Dependencies: 555
-- Name: FUNCTION postgis_proj_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_proj_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7341 (class 0 OID 0)
-- Dependencies: 1252
-- Name: FUNCTION postgis_scripts_build_date(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_build_date() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7342 (class 0 OID 0)
-- Dependencies: 757
-- Name: FUNCTION postgis_scripts_installed(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_installed() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7343 (class 0 OID 0)
-- Dependencies: 1182
-- Name: FUNCTION postgis_scripts_released(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_scripts_released() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7344 (class 0 OID 0)
-- Dependencies: 1140
-- Name: FUNCTION postgis_svn_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_svn_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7345 (class 0 OID 0)
-- Dependencies: 1235
-- Name: FUNCTION postgis_transform_geometry(geom extensions.geometry, text, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_transform_geometry(geom extensions.geometry, text, text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7346 (class 0 OID 0)
-- Dependencies: 1103
-- Name: FUNCTION postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_type_name(geomname character varying, coord_dimension integer, use_new_name boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7347 (class 0 OID 0)
-- Dependencies: 1425
-- Name: FUNCTION postgis_typmod_dims(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_dims(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7348 (class 0 OID 0)
-- Dependencies: 837
-- Name: FUNCTION postgis_typmod_srid(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_srid(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7349 (class 0 OID 0)
-- Dependencies: 855
-- Name: FUNCTION postgis_typmod_type(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_typmod_type(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7350 (class 0 OID 0)
-- Dependencies: 645
-- Name: FUNCTION postgis_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7351 (class 0 OID 0)
-- Dependencies: 787
-- Name: FUNCTION postgis_wagyu_version(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.postgis_wagyu_version() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7352 (class 0 OID 0)
-- Dependencies: 1088
-- Name: FUNCTION redis_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.redis_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7353 (class 0 OID 0)
-- Dependencies: 777
-- Name: FUNCTION redis_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.redis_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7354 (class 0 OID 0)
-- Dependencies: 876
-- Name: FUNCTION redis_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.redis_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7355 (class 0 OID 0)
-- Dependencies: 865
-- Name: FUNCTION s3_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.s3_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7356 (class 0 OID 0)
-- Dependencies: 1427
-- Name: FUNCTION s3_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.s3_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7357 (class 0 OID 0)
-- Dependencies: 1166
-- Name: FUNCTION s3_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.s3_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7359 (class 0 OID 0)
-- Dependencies: 587
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7360 (class 0 OID 0)
-- Dependencies: 737
-- Name: FUNCTION st_3dclosestpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dclosestpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7361 (class 0 OID 0)
-- Dependencies: 562
-- Name: FUNCTION st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7362 (class 0 OID 0)
-- Dependencies: 752
-- Name: FUNCTION st_3ddistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7363 (class 0 OID 0)
-- Dependencies: 878
-- Name: FUNCTION st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3ddwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7364 (class 0 OID 0)
-- Dependencies: 1134
-- Name: FUNCTION st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dintersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7365 (class 0 OID 0)
-- Dependencies: 1058
-- Name: FUNCTION st_3dlength(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlength(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7366 (class 0 OID 0)
-- Dependencies: 952
-- Name: FUNCTION st_3dlineinterpolatepoint(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlineinterpolatepoint(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7367 (class 0 OID 0)
-- Dependencies: 556
-- Name: FUNCTION st_3dlongestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dlongestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7368 (class 0 OID 0)
-- Dependencies: 621
-- Name: FUNCTION st_3dmakebox(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dmakebox(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7369 (class 0 OID 0)
-- Dependencies: 847
-- Name: FUNCTION st_3dmaxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dmaxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7370 (class 0 OID 0)
-- Dependencies: 1253
-- Name: FUNCTION st_3dperimeter(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dperimeter(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7371 (class 0 OID 0)
-- Dependencies: 939
-- Name: FUNCTION st_3dshortestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dshortestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7372 (class 0 OID 0)
-- Dependencies: 1430
-- Name: FUNCTION st_addmeasure(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addmeasure(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7373 (class 0 OID 0)
-- Dependencies: 700
-- Name: FUNCTION st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7374 (class 0 OID 0)
-- Dependencies: 1320
-- Name: FUNCTION st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_addpoint(geom1 extensions.geometry, geom2 extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7375 (class 0 OID 0)
-- Dependencies: 557
-- Name: FUNCTION st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7376 (class 0 OID 0)
-- Dependencies: 1226
-- Name: FUNCTION st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_affine(extensions.geometry, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7377 (class 0 OID 0)
-- Dependencies: 805
-- Name: FUNCTION st_angle(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_angle(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7378 (class 0 OID 0)
-- Dependencies: 1291
-- Name: FUNCTION st_angle(pt1 extensions.geometry, pt2 extensions.geometry, pt3 extensions.geometry, pt4 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_angle(pt1 extensions.geometry, pt2 extensions.geometry, pt3 extensions.geometry, pt4 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7379 (class 0 OID 0)
-- Dependencies: 1300
-- Name: FUNCTION st_area(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7380 (class 0 OID 0)
-- Dependencies: 725
-- Name: FUNCTION st_area(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7381 (class 0 OID 0)
-- Dependencies: 654
-- Name: FUNCTION st_area(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7382 (class 0 OID 0)
-- Dependencies: 1199
-- Name: FUNCTION st_area2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_area2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7383 (class 0 OID 0)
-- Dependencies: 761
-- Name: FUNCTION st_asbinary(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7384 (class 0 OID 0)
-- Dependencies: 1249
-- Name: FUNCTION st_asbinary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7385 (class 0 OID 0)
-- Dependencies: 1417
-- Name: FUNCTION st_asbinary(extensions.geography, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geography, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7386 (class 0 OID 0)
-- Dependencies: 775
-- Name: FUNCTION st_asbinary(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asbinary(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7387 (class 0 OID 0)
-- Dependencies: 887
-- Name: FUNCTION st_asencodedpolyline(geom extensions.geometry, nprecision integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asencodedpolyline(geom extensions.geometry, nprecision integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7388 (class 0 OID 0)
-- Dependencies: 743
-- Name: FUNCTION st_asewkb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7389 (class 0 OID 0)
-- Dependencies: 567
-- Name: FUNCTION st_asewkb(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkb(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7390 (class 0 OID 0)
-- Dependencies: 1295
-- Name: FUNCTION st_asewkt(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7391 (class 0 OID 0)
-- Dependencies: 910
-- Name: FUNCTION st_asewkt(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7392 (class 0 OID 0)
-- Dependencies: 867
-- Name: FUNCTION st_asewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7393 (class 0 OID 0)
-- Dependencies: 955
-- Name: FUNCTION st_asewkt(extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7394 (class 0 OID 0)
-- Dependencies: 1196
-- Name: FUNCTION st_asewkt(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asewkt(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7395 (class 0 OID 0)
-- Dependencies: 849
-- Name: FUNCTION st_asgeojson(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7396 (class 0 OID 0)
-- Dependencies: 1348
-- Name: FUNCTION st_asgeojson(geog extensions.geography, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(geog extensions.geography, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7397 (class 0 OID 0)
-- Dependencies: 998
-- Name: FUNCTION st_asgeojson(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7398 (class 0 OID 0)
-- Dependencies: 1002
-- Name: FUNCTION st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeojson(r record, geom_column text, maxdecimaldigits integer, pretty_bool boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7399 (class 0 OID 0)
-- Dependencies: 1000
-- Name: FUNCTION st_asgml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7400 (class 0 OID 0)
-- Dependencies: 895
-- Name: FUNCTION st_asgml(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7401 (class 0 OID 0)
-- Dependencies: 819
-- Name: FUNCTION st_asgml(geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7402 (class 0 OID 0)
-- Dependencies: 1410
-- Name: FUNCTION st_asgml(version integer, geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(version integer, geog extensions.geography, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7403 (class 0 OID 0)
-- Dependencies: 1329
-- Name: FUNCTION st_asgml(version integer, geom extensions.geometry, maxdecimaldigits integer, options integer, nprefix text, id text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgml(version integer, geom extensions.geometry, maxdecimaldigits integer, options integer, nprefix text, id text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7404 (class 0 OID 0)
-- Dependencies: 755
-- Name: FUNCTION st_ashexewkb(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ashexewkb(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7405 (class 0 OID 0)
-- Dependencies: 604
-- Name: FUNCTION st_ashexewkb(extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ashexewkb(extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7406 (class 0 OID 0)
-- Dependencies: 1325
-- Name: FUNCTION st_askml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7407 (class 0 OID 0)
-- Dependencies: 1370
-- Name: FUNCTION st_askml(geog extensions.geography, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(geog extensions.geography, maxdecimaldigits integer, nprefix text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7408 (class 0 OID 0)
-- Dependencies: 1418
-- Name: FUNCTION st_askml(geom extensions.geometry, maxdecimaldigits integer, nprefix text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_askml(geom extensions.geometry, maxdecimaldigits integer, nprefix text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7409 (class 0 OID 0)
-- Dependencies: 1192
-- Name: FUNCTION st_aslatlontext(geom extensions.geometry, tmpl text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_aslatlontext(geom extensions.geometry, tmpl text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7410 (class 0 OID 0)
-- Dependencies: 791
-- Name: FUNCTION st_asmarc21(geom extensions.geometry, format text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmarc21(geom extensions.geometry, format text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7411 (class 0 OID 0)
-- Dependencies: 631
-- Name: FUNCTION st_asmvtgeom(geom extensions.geometry, bounds extensions.box2d, extent integer, buffer integer, clip_geom boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvtgeom(geom extensions.geometry, bounds extensions.box2d, extent integer, buffer integer, clip_geom boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7412 (class 0 OID 0)
-- Dependencies: 907
-- Name: FUNCTION st_assvg(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7413 (class 0 OID 0)
-- Dependencies: 884
-- Name: FUNCTION st_assvg(geog extensions.geography, rel integer, maxdecimaldigits integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(geog extensions.geography, rel integer, maxdecimaldigits integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7414 (class 0 OID 0)
-- Dependencies: 1311
-- Name: FUNCTION st_assvg(geom extensions.geometry, rel integer, maxdecimaldigits integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_assvg(geom extensions.geometry, rel integer, maxdecimaldigits integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7415 (class 0 OID 0)
-- Dependencies: 764
-- Name: FUNCTION st_astext(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7416 (class 0 OID 0)
-- Dependencies: 715
-- Name: FUNCTION st_astext(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7417 (class 0 OID 0)
-- Dependencies: 1270
-- Name: FUNCTION st_astext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7418 (class 0 OID 0)
-- Dependencies: 881
-- Name: FUNCTION st_astext(extensions.geography, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geography, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7419 (class 0 OID 0)
-- Dependencies: 1076
-- Name: FUNCTION st_astext(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astext(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7420 (class 0 OID 0)
-- Dependencies: 906
-- Name: FUNCTION st_astwkb(geom extensions.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astwkb(geom extensions.geometry, prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7421 (class 0 OID 0)
-- Dependencies: 1041
-- Name: FUNCTION st_astwkb(geom extensions.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_astwkb(geom extensions.geometry[], ids bigint[], prec integer, prec_z integer, prec_m integer, with_sizes boolean, with_boxes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7422 (class 0 OID 0)
-- Dependencies: 841
-- Name: FUNCTION st_asx3d(geom extensions.geometry, maxdecimaldigits integer, options integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asx3d(geom extensions.geometry, maxdecimaldigits integer, options integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7423 (class 0 OID 0)
-- Dependencies: 997
-- Name: FUNCTION st_azimuth(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_azimuth(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7424 (class 0 OID 0)
-- Dependencies: 1355
-- Name: FUNCTION st_azimuth(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_azimuth(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7425 (class 0 OID 0)
-- Dependencies: 1205
-- Name: FUNCTION st_bdmpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_bdmpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7426 (class 0 OID 0)
-- Dependencies: 1379
-- Name: FUNCTION st_bdpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_bdpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7427 (class 0 OID 0)
-- Dependencies: 1164
-- Name: FUNCTION st_boundary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_boundary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7428 (class 0 OID 0)
-- Dependencies: 1405
-- Name: FUNCTION st_boundingdiagonal(geom extensions.geometry, fits boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_boundingdiagonal(geom extensions.geometry, fits boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7429 (class 0 OID 0)
-- Dependencies: 686
-- Name: FUNCTION st_box2dfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_box2dfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7430 (class 0 OID 0)
-- Dependencies: 958
-- Name: FUNCTION st_buffer(extensions.geography, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7431 (class 0 OID 0)
-- Dependencies: 1307
-- Name: FUNCTION st_buffer(text, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7432 (class 0 OID 0)
-- Dependencies: 1038
-- Name: FUNCTION st_buffer(extensions.geography, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7433 (class 0 OID 0)
-- Dependencies: 1187
-- Name: FUNCTION st_buffer(extensions.geography, double precision, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(extensions.geography, double precision, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7434 (class 0 OID 0)
-- Dependencies: 1287
-- Name: FUNCTION st_buffer(geom extensions.geometry, radius double precision, quadsegs integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(geom extensions.geometry, radius double precision, quadsegs integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7435 (class 0 OID 0)
-- Dependencies: 581
-- Name: FUNCTION st_buffer(geom extensions.geometry, radius double precision, options text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(geom extensions.geometry, radius double precision, options text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7436 (class 0 OID 0)
-- Dependencies: 1377
-- Name: FUNCTION st_buffer(text, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7437 (class 0 OID 0)
-- Dependencies: 662
-- Name: FUNCTION st_buffer(text, double precision, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buffer(text, double precision, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7438 (class 0 OID 0)
-- Dependencies: 1369
-- Name: FUNCTION st_buildarea(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_buildarea(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7439 (class 0 OID 0)
-- Dependencies: 1130
-- Name: FUNCTION st_centroid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7440 (class 0 OID 0)
-- Dependencies: 1296
-- Name: FUNCTION st_centroid(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7441 (class 0 OID 0)
-- Dependencies: 647
-- Name: FUNCTION st_centroid(extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_centroid(extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7442 (class 0 OID 0)
-- Dependencies: 681
-- Name: FUNCTION st_chaikinsmoothing(extensions.geometry, integer, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_chaikinsmoothing(extensions.geometry, integer, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7443 (class 0 OID 0)
-- Dependencies: 1160
-- Name: FUNCTION st_cleangeometry(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_cleangeometry(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7444 (class 0 OID 0)
-- Dependencies: 583
-- Name: FUNCTION st_clipbybox2d(geom extensions.geometry, box extensions.box2d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clipbybox2d(geom extensions.geometry, box extensions.box2d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7445 (class 0 OID 0)
-- Dependencies: 1152
-- Name: FUNCTION st_closestpoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_closestpoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7446 (class 0 OID 0)
-- Dependencies: 925
-- Name: FUNCTION st_closestpointofapproach(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_closestpointofapproach(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7447 (class 0 OID 0)
-- Dependencies: 1132
-- Name: FUNCTION st_clusterdbscan(extensions.geometry, eps double precision, minpoints integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterdbscan(extensions.geometry, eps double precision, minpoints integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7448 (class 0 OID 0)
-- Dependencies: 657
-- Name: FUNCTION st_clusterintersecting(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterintersecting(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7449 (class 0 OID 0)
-- Dependencies: 1236
-- Name: FUNCTION st_clusterkmeans(geom extensions.geometry, k integer, max_radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterkmeans(geom extensions.geometry, k integer, max_radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7450 (class 0 OID 0)
-- Dependencies: 1137
-- Name: FUNCTION st_clusterwithin(extensions.geometry[], double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterwithin(extensions.geometry[], double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7451 (class 0 OID 0)
-- Dependencies: 1092
-- Name: FUNCTION st_collect(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7452 (class 0 OID 0)
-- Dependencies: 1150
-- Name: FUNCTION st_collect(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7453 (class 0 OID 0)
-- Dependencies: 565
-- Name: FUNCTION st_collectionextract(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionextract(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7454 (class 0 OID 0)
-- Dependencies: 553
-- Name: FUNCTION st_collectionextract(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionextract(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7455 (class 0 OID 0)
-- Dependencies: 1177
-- Name: FUNCTION st_collectionhomogenize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collectionhomogenize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7456 (class 0 OID 0)
-- Dependencies: 1375
-- Name: FUNCTION st_combinebbox(extensions.box2d, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box2d, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7457 (class 0 OID 0)
-- Dependencies: 1167
-- Name: FUNCTION st_combinebbox(extensions.box3d, extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box3d, extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7458 (class 0 OID 0)
-- Dependencies: 1207
-- Name: FUNCTION st_combinebbox(extensions.box3d, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_combinebbox(extensions.box3d, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7459 (class 0 OID 0)
-- Dependencies: 1107
-- Name: FUNCTION st_concavehull(param_geom extensions.geometry, param_pctconvex double precision, param_allow_holes boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_concavehull(param_geom extensions.geometry, param_pctconvex double precision, param_allow_holes boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7460 (class 0 OID 0)
-- Dependencies: 656
-- Name: FUNCTION st_contains(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_contains(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7461 (class 0 OID 0)
-- Dependencies: 776
-- Name: FUNCTION st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_containsproperly(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7462 (class 0 OID 0)
-- Dependencies: 1422
-- Name: FUNCTION st_convexhull(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_convexhull(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7463 (class 0 OID 0)
-- Dependencies: 577
-- Name: FUNCTION st_coorddim(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coorddim(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7464 (class 0 OID 0)
-- Dependencies: 853
-- Name: FUNCTION st_coveredby(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7465 (class 0 OID 0)
-- Dependencies: 782
-- Name: FUNCTION st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7466 (class 0 OID 0)
-- Dependencies: 623
-- Name: FUNCTION st_coveredby(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_coveredby(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7467 (class 0 OID 0)
-- Dependencies: 807
-- Name: FUNCTION st_covers(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7468 (class 0 OID 0)
-- Dependencies: 863
-- Name: FUNCTION st_covers(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7469 (class 0 OID 0)
-- Dependencies: 1091
-- Name: FUNCTION st_covers(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_covers(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7470 (class 0 OID 0)
-- Dependencies: 1035
-- Name: FUNCTION st_cpawithin(extensions.geometry, extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_cpawithin(extensions.geometry, extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7471 (class 0 OID 0)
-- Dependencies: 980
-- Name: FUNCTION st_crosses(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_crosses(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7472 (class 0 OID 0)
-- Dependencies: 582
-- Name: FUNCTION st_curvetoline(geom extensions.geometry, tol double precision, toltype integer, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_curvetoline(geom extensions.geometry, tol double precision, toltype integer, flags integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7473 (class 0 OID 0)
-- Dependencies: 969
-- Name: FUNCTION st_delaunaytriangles(g1 extensions.geometry, tolerance double precision, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_delaunaytriangles(g1 extensions.geometry, tolerance double precision, flags integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7474 (class 0 OID 0)
-- Dependencies: 1399
-- Name: FUNCTION st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dfullywithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7475 (class 0 OID 0)
-- Dependencies: 1101
-- Name: FUNCTION st_difference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_difference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7476 (class 0 OID 0)
-- Dependencies: 817
-- Name: FUNCTION st_dimension(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dimension(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7477 (class 0 OID 0)
-- Dependencies: 928
-- Name: FUNCTION st_disjoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_disjoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7478 (class 0 OID 0)
-- Dependencies: 870
-- Name: FUNCTION st_distance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7479 (class 0 OID 0)
-- Dependencies: 1018
-- Name: FUNCTION st_distance(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7480 (class 0 OID 0)
-- Dependencies: 1279
-- Name: FUNCTION st_distance(geog1 extensions.geography, geog2 extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distance(geog1 extensions.geography, geog2 extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7481 (class 0 OID 0)
-- Dependencies: 658
-- Name: FUNCTION st_distancecpa(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancecpa(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7482 (class 0 OID 0)
-- Dependencies: 836
-- Name: FUNCTION st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7483 (class 0 OID 0)
-- Dependencies: 709
-- Name: FUNCTION st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry, radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancesphere(geom1 extensions.geometry, geom2 extensions.geometry, radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7484 (class 0 OID 0)
-- Dependencies: 1141
-- Name: FUNCTION st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7485 (class 0 OID 0)
-- Dependencies: 1122
-- Name: FUNCTION st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_distancespheroid(geom1 extensions.geometry, geom2 extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7486 (class 0 OID 0)
-- Dependencies: 1204
-- Name: FUNCTION st_dump(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dump(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7487 (class 0 OID 0)
-- Dependencies: 987
-- Name: FUNCTION st_dumppoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumppoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7488 (class 0 OID 0)
-- Dependencies: 941
-- Name: FUNCTION st_dumprings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumprings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7489 (class 0 OID 0)
-- Dependencies: 1036
-- Name: FUNCTION st_dumpsegments(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dumpsegments(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7490 (class 0 OID 0)
-- Dependencies: 601
-- Name: FUNCTION st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7491 (class 0 OID 0)
-- Dependencies: 726
-- Name: FUNCTION st_dwithin(text, text, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(text, text, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7492 (class 0 OID 0)
-- Dependencies: 1414
-- Name: FUNCTION st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_dwithin(geog1 extensions.geography, geog2 extensions.geography, tolerance double precision, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7493 (class 0 OID 0)
-- Dependencies: 1314
-- Name: FUNCTION st_endpoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_endpoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7494 (class 0 OID 0)
-- Dependencies: 1394
-- Name: FUNCTION st_envelope(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_envelope(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7495 (class 0 OID 0)
-- Dependencies: 677
-- Name: FUNCTION st_equals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_equals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7496 (class 0 OID 0)
-- Dependencies: 1128
-- Name: FUNCTION st_estimatedextent(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7497 (class 0 OID 0)
-- Dependencies: 1365
-- Name: FUNCTION st_estimatedextent(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7498 (class 0 OID 0)
-- Dependencies: 1397
-- Name: FUNCTION st_estimatedextent(text, text, text, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_estimatedextent(text, text, text, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7499 (class 0 OID 0)
-- Dependencies: 862
-- Name: FUNCTION st_expand(extensions.box2d, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.box2d, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7500 (class 0 OID 0)
-- Dependencies: 1277
-- Name: FUNCTION st_expand(extensions.box3d, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.box3d, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7501 (class 0 OID 0)
-- Dependencies: 1358
-- Name: FUNCTION st_expand(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7502 (class 0 OID 0)
-- Dependencies: 812
-- Name: FUNCTION st_expand(box extensions.box2d, dx double precision, dy double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(box extensions.box2d, dx double precision, dy double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7503 (class 0 OID 0)
-- Dependencies: 1304
-- Name: FUNCTION st_expand(box extensions.box3d, dx double precision, dy double precision, dz double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(box extensions.box3d, dx double precision, dy double precision, dz double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7504 (class 0 OID 0)
-- Dependencies: 655
-- Name: FUNCTION st_expand(geom extensions.geometry, dx double precision, dy double precision, dz double precision, dm double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_expand(geom extensions.geometry, dx double precision, dy double precision, dz double precision, dm double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7505 (class 0 OID 0)
-- Dependencies: 938
-- Name: FUNCTION st_exteriorring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_exteriorring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7506 (class 0 OID 0)
-- Dependencies: 1336
-- Name: FUNCTION st_filterbym(extensions.geometry, double precision, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_filterbym(extensions.geometry, double precision, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7507 (class 0 OID 0)
-- Dependencies: 1334
-- Name: FUNCTION st_findextent(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_findextent(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7508 (class 0 OID 0)
-- Dependencies: 1075
-- Name: FUNCTION st_findextent(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_findextent(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7509 (class 0 OID 0)
-- Dependencies: 1197
-- Name: FUNCTION st_flipcoordinates(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_flipcoordinates(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7510 (class 0 OID 0)
-- Dependencies: 1087
-- Name: FUNCTION st_force2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7511 (class 0 OID 0)
-- Dependencies: 668
-- Name: FUNCTION st_force3d(geom extensions.geometry, zvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3d(geom extensions.geometry, zvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7512 (class 0 OID 0)
-- Dependencies: 975
-- Name: FUNCTION st_force3dm(geom extensions.geometry, mvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3dm(geom extensions.geometry, mvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7513 (class 0 OID 0)
-- Dependencies: 1322
-- Name: FUNCTION st_force3dz(geom extensions.geometry, zvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force3dz(geom extensions.geometry, zvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7514 (class 0 OID 0)
-- Dependencies: 1428
-- Name: FUNCTION st_force4d(geom extensions.geometry, zvalue double precision, mvalue double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_force4d(geom extensions.geometry, zvalue double precision, mvalue double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7515 (class 0 OID 0)
-- Dependencies: 1316
-- Name: FUNCTION st_forcecollection(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcecollection(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7516 (class 0 OID 0)
-- Dependencies: 1244
-- Name: FUNCTION st_forcecurve(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcecurve(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7517 (class 0 OID 0)
-- Dependencies: 1214
-- Name: FUNCTION st_forcepolygonccw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcepolygonccw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7518 (class 0 OID 0)
-- Dependencies: 796
-- Name: FUNCTION st_forcepolygoncw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcepolygoncw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7519 (class 0 OID 0)
-- Dependencies: 1431
-- Name: FUNCTION st_forcerhr(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcerhr(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7520 (class 0 OID 0)
-- Dependencies: 1079
-- Name: FUNCTION st_forcesfs(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcesfs(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7521 (class 0 OID 0)
-- Dependencies: 605
-- Name: FUNCTION st_forcesfs(extensions.geometry, version text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_forcesfs(extensions.geometry, version text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7522 (class 0 OID 0)
-- Dependencies: 1404
-- Name: FUNCTION st_frechetdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_frechetdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7523 (class 0 OID 0)
-- Dependencies: 844
-- Name: FUNCTION st_fromflatgeobuf(anyelement, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_fromflatgeobuf(anyelement, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7524 (class 0 OID 0)
-- Dependencies: 746
-- Name: FUNCTION st_fromflatgeobuftotable(text, text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_fromflatgeobuftotable(text, text, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7525 (class 0 OID 0)
-- Dependencies: 800
-- Name: FUNCTION st_generatepoints(area extensions.geometry, npoints integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_generatepoints(area extensions.geometry, npoints integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7526 (class 0 OID 0)
-- Dependencies: 612
-- Name: FUNCTION st_generatepoints(area extensions.geometry, npoints integer, seed integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_generatepoints(area extensions.geometry, npoints integer, seed integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7527 (class 0 OID 0)
-- Dependencies: 1337
-- Name: FUNCTION st_geogfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geogfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7528 (class 0 OID 0)
-- Dependencies: 642
-- Name: FUNCTION st_geogfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geogfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7529 (class 0 OID 0)
-- Dependencies: 653
-- Name: FUNCTION st_geographyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geographyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7530 (class 0 OID 0)
-- Dependencies: 661
-- Name: FUNCTION st_geohash(geog extensions.geography, maxchars integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geohash(geog extensions.geography, maxchars integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7531 (class 0 OID 0)
-- Dependencies: 934
-- Name: FUNCTION st_geohash(geom extensions.geometry, maxchars integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geohash(geom extensions.geometry, maxchars integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7532 (class 0 OID 0)
-- Dependencies: 1052
-- Name: FUNCTION st_geomcollfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7533 (class 0 OID 0)
-- Dependencies: 633
-- Name: FUNCTION st_geomcollfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7534 (class 0 OID 0)
-- Dependencies: 810
-- Name: FUNCTION st_geomcollfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7535 (class 0 OID 0)
-- Dependencies: 1176
-- Name: FUNCTION st_geomcollfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomcollfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7536 (class 0 OID 0)
-- Dependencies: 1368
-- Name: FUNCTION st_geometricmedian(g extensions.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometricmedian(g extensions.geometry, tolerance double precision, max_iter integer, fail_if_not_converged boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7537 (class 0 OID 0)
-- Dependencies: 923
-- Name: FUNCTION st_geometryfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7538 (class 0 OID 0)
-- Dependencies: 683
-- Name: FUNCTION st_geometryfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7539 (class 0 OID 0)
-- Dependencies: 774
-- Name: FUNCTION st_geometryn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometryn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7540 (class 0 OID 0)
-- Dependencies: 927
-- Name: FUNCTION st_geometrytype(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geometrytype(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7541 (class 0 OID 0)
-- Dependencies: 589
-- Name: FUNCTION st_geomfromewkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromewkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7542 (class 0 OID 0)
-- Dependencies: 846
-- Name: FUNCTION st_geomfromewkt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromewkt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7543 (class 0 OID 0)
-- Dependencies: 792
-- Name: FUNCTION st_geomfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7544 (class 0 OID 0)
-- Dependencies: 1373
-- Name: FUNCTION st_geomfromgeojson(json); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(json) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7545 (class 0 OID 0)
-- Dependencies: 717
-- Name: FUNCTION st_geomfromgeojson(jsonb); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(jsonb) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7546 (class 0 OID 0)
-- Dependencies: 766
-- Name: FUNCTION st_geomfromgeojson(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgeojson(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7547 (class 0 OID 0)
-- Dependencies: 1179
-- Name: FUNCTION st_geomfromgml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7548 (class 0 OID 0)
-- Dependencies: 821
-- Name: FUNCTION st_geomfromgml(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromgml(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7549 (class 0 OID 0)
-- Dependencies: 845
-- Name: FUNCTION st_geomfromkml(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromkml(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7550 (class 0 OID 0)
-- Dependencies: 1025
-- Name: FUNCTION st_geomfrommarc21(marc21xml text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfrommarc21(marc21xml text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7551 (class 0 OID 0)
-- Dependencies: 1354
-- Name: FUNCTION st_geomfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7552 (class 0 OID 0)
-- Dependencies: 1386
-- Name: FUNCTION st_geomfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7553 (class 0 OID 0)
-- Dependencies: 965
-- Name: FUNCTION st_geomfromtwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromtwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7554 (class 0 OID 0)
-- Dependencies: 1206
-- Name: FUNCTION st_geomfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7555 (class 0 OID 0)
-- Dependencies: 1173
-- Name: FUNCTION st_geomfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_geomfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7556 (class 0 OID 0)
-- Dependencies: 1363
-- Name: FUNCTION st_gmltosql(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_gmltosql(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7557 (class 0 OID 0)
-- Dependencies: 985
-- Name: FUNCTION st_gmltosql(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_gmltosql(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7558 (class 0 OID 0)
-- Dependencies: 885
-- Name: FUNCTION st_hasarc(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hasarc(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7559 (class 0 OID 0)
-- Dependencies: 946
-- Name: FUNCTION st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7560 (class 0 OID 0)
-- Dependencies: 639
-- Name: FUNCTION st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hausdorffdistance(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7561 (class 0 OID 0)
-- Dependencies: 1136
-- Name: FUNCTION st_hexagon(size double precision, cell_i integer, cell_j integer, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hexagon(size double precision, cell_i integer, cell_j integer, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7562 (class 0 OID 0)
-- Dependencies: 716
-- Name: FUNCTION st_hexagongrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_hexagongrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7563 (class 0 OID 0)
-- Dependencies: 564
-- Name: FUNCTION st_interiorringn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_interiorringn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7564 (class 0 OID 0)
-- Dependencies: 808
-- Name: FUNCTION st_interpolatepoint(line extensions.geometry, point extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_interpolatepoint(line extensions.geometry, point extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7565 (class 0 OID 0)
-- Dependencies: 913
-- Name: FUNCTION st_intersection(extensions.geography, extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(extensions.geography, extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7566 (class 0 OID 0)
-- Dependencies: 851
-- Name: FUNCTION st_intersection(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7567 (class 0 OID 0)
-- Dependencies: 1188
-- Name: FUNCTION st_intersection(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersection(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7568 (class 0 OID 0)
-- Dependencies: 1006
-- Name: FUNCTION st_intersects(geog1 extensions.geography, geog2 extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(geog1 extensions.geography, geog2 extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7569 (class 0 OID 0)
-- Dependencies: 701
-- Name: FUNCTION st_intersects(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7570 (class 0 OID 0)
-- Dependencies: 603
-- Name: FUNCTION st_intersects(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_intersects(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7571 (class 0 OID 0)
-- Dependencies: 712
-- Name: FUNCTION st_isclosed(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isclosed(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7572 (class 0 OID 0)
-- Dependencies: 1353
-- Name: FUNCTION st_iscollection(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_iscollection(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7573 (class 0 OID 0)
-- Dependencies: 1364
-- Name: FUNCTION st_isempty(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isempty(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7574 (class 0 OID 0)
-- Dependencies: 879
-- Name: FUNCTION st_ispolygonccw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ispolygonccw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7575 (class 0 OID 0)
-- Dependencies: 1056
-- Name: FUNCTION st_ispolygoncw(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ispolygoncw(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7576 (class 0 OID 0)
-- Dependencies: 935
-- Name: FUNCTION st_isring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7577 (class 0 OID 0)
-- Dependencies: 572
-- Name: FUNCTION st_issimple(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_issimple(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7578 (class 0 OID 0)
-- Dependencies: 1271
-- Name: FUNCTION st_isvalid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7579 (class 0 OID 0)
-- Dependencies: 1426
-- Name: FUNCTION st_isvalid(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalid(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7580 (class 0 OID 0)
-- Dependencies: 1022
-- Name: FUNCTION st_isvaliddetail(geom extensions.geometry, flags integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvaliddetail(geom extensions.geometry, flags integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7581 (class 0 OID 0)
-- Dependencies: 873
-- Name: FUNCTION st_isvalidreason(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidreason(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7582 (class 0 OID 0)
-- Dependencies: 826
-- Name: FUNCTION st_isvalidreason(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidreason(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7583 (class 0 OID 0)
-- Dependencies: 615
-- Name: FUNCTION st_isvalidtrajectory(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_isvalidtrajectory(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7584 (class 0 OID 0)
-- Dependencies: 1062
-- Name: FUNCTION st_length(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7585 (class 0 OID 0)
-- Dependencies: 1256
-- Name: FUNCTION st_length(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7586 (class 0 OID 0)
-- Dependencies: 1389
-- Name: FUNCTION st_length(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7587 (class 0 OID 0)
-- Dependencies: 1247
-- Name: FUNCTION st_length2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7588 (class 0 OID 0)
-- Dependencies: 1156
-- Name: FUNCTION st_length2dspheroid(extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_length2dspheroid(extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7589 (class 0 OID 0)
-- Dependencies: 1371
-- Name: FUNCTION st_lengthspheroid(extensions.geometry, extensions.spheroid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lengthspheroid(extensions.geometry, extensions.spheroid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7590 (class 0 OID 0)
-- Dependencies: 684
-- Name: FUNCTION st_letters(letters text, font json); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_letters(letters text, font json) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7591 (class 0 OID 0)
-- Dependencies: 1115
-- Name: FUNCTION st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linecrossingdirection(line1 extensions.geometry, line2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7592 (class 0 OID 0)
-- Dependencies: 756
-- Name: FUNCTION st_linefromencodedpolyline(txtin text, nprecision integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromencodedpolyline(txtin text, nprecision integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7593 (class 0 OID 0)
-- Dependencies: 1162
-- Name: FUNCTION st_linefrommultipoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefrommultipoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7594 (class 0 OID 0)
-- Dependencies: 1094
-- Name: FUNCTION st_linefromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7595 (class 0 OID 0)
-- Dependencies: 660
-- Name: FUNCTION st_linefromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7596 (class 0 OID 0)
-- Dependencies: 1381
-- Name: FUNCTION st_linefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7597 (class 0 OID 0)
-- Dependencies: 948
-- Name: FUNCTION st_linefromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linefromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7598 (class 0 OID 0)
-- Dependencies: 1153
-- Name: FUNCTION st_lineinterpolatepoint(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lineinterpolatepoint(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7599 (class 0 OID 0)
-- Dependencies: 542
-- Name: FUNCTION st_lineinterpolatepoints(extensions.geometry, double precision, repeat boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_lineinterpolatepoints(extensions.geometry, double precision, repeat boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7600 (class 0 OID 0)
-- Dependencies: 1139
-- Name: FUNCTION st_linelocatepoint(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linelocatepoint(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7601 (class 0 OID 0)
-- Dependencies: 822
-- Name: FUNCTION st_linemerge(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linemerge(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7602 (class 0 OID 0)
-- Dependencies: 783
-- Name: FUNCTION st_linemerge(extensions.geometry, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linemerge(extensions.geometry, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7603 (class 0 OID 0)
-- Dependencies: 930
-- Name: FUNCTION st_linestringfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linestringfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7604 (class 0 OID 0)
-- Dependencies: 797
-- Name: FUNCTION st_linestringfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linestringfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7605 (class 0 OID 0)
-- Dependencies: 770
-- Name: FUNCTION st_linesubstring(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linesubstring(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7606 (class 0 OID 0)
-- Dependencies: 921
-- Name: FUNCTION st_linetocurve(geometry extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_linetocurve(geometry extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7607 (class 0 OID 0)
-- Dependencies: 579
-- Name: FUNCTION st_locatealong(geometry extensions.geometry, measure double precision, leftrightoffset double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatealong(geometry extensions.geometry, measure double precision, leftrightoffset double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7608 (class 0 OID 0)
-- Dependencies: 1232
-- Name: FUNCTION st_locatebetween(geometry extensions.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatebetween(geometry extensions.geometry, frommeasure double precision, tomeasure double precision, leftrightoffset double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7609 (class 0 OID 0)
-- Dependencies: 676
-- Name: FUNCTION st_locatebetweenelevations(geometry extensions.geometry, fromelevation double precision, toelevation double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_locatebetweenelevations(geometry extensions.geometry, fromelevation double precision, toelevation double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7610 (class 0 OID 0)
-- Dependencies: 831
-- Name: FUNCTION st_longestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_longestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7611 (class 0 OID 0)
-- Dependencies: 1233
-- Name: FUNCTION st_m(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_m(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7612 (class 0 OID 0)
-- Dependencies: 886
-- Name: FUNCTION st_makebox2d(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makebox2d(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7613 (class 0 OID 0)
-- Dependencies: 799
-- Name: FUNCTION st_makeenvelope(double precision, double precision, double precision, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeenvelope(double precision, double precision, double precision, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7614 (class 0 OID 0)
-- Dependencies: 1104
-- Name: FUNCTION st_makeline(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7615 (class 0 OID 0)
-- Dependencies: 929
-- Name: FUNCTION st_makeline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7616 (class 0 OID 0)
-- Dependencies: 902
-- Name: FUNCTION st_makepoint(double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7617 (class 0 OID 0)
-- Dependencies: 1202
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7618 (class 0 OID 0)
-- Dependencies: 1301
-- Name: FUNCTION st_makepoint(double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepoint(double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7619 (class 0 OID 0)
-- Dependencies: 638
-- Name: FUNCTION st_makepointm(double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepointm(double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7620 (class 0 OID 0)
-- Dependencies: 1391
-- Name: FUNCTION st_makepolygon(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepolygon(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7621 (class 0 OID 0)
-- Dependencies: 1049
-- Name: FUNCTION st_makepolygon(extensions.geometry, extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makepolygon(extensions.geometry, extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7622 (class 0 OID 0)
-- Dependencies: 1341
-- Name: FUNCTION st_makevalid(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makevalid(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7623 (class 0 OID 0)
-- Dependencies: 1415
-- Name: FUNCTION st_makevalid(geom extensions.geometry, params text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makevalid(geom extensions.geometry, params text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7624 (class 0 OID 0)
-- Dependencies: 563
-- Name: FUNCTION st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_maxdistance(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7625 (class 0 OID 0)
-- Dependencies: 566
-- Name: FUNCTION st_maximuminscribedcircle(extensions.geometry, OUT center extensions.geometry, OUT nearest extensions.geometry, OUT radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_maximuminscribedcircle(extensions.geometry, OUT center extensions.geometry, OUT nearest extensions.geometry, OUT radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7626 (class 0 OID 0)
-- Dependencies: 1116
-- Name: FUNCTION st_memsize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memsize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7627 (class 0 OID 0)
-- Dependencies: 690
-- Name: FUNCTION st_minimumboundingcircle(inputgeom extensions.geometry, segs_per_quarter integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumboundingcircle(inputgeom extensions.geometry, segs_per_quarter integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7628 (class 0 OID 0)
-- Dependencies: 744
-- Name: FUNCTION st_minimumboundingradius(extensions.geometry, OUT center extensions.geometry, OUT radius double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumboundingradius(extensions.geometry, OUT center extensions.geometry, OUT radius double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7629 (class 0 OID 0)
-- Dependencies: 540
-- Name: FUNCTION st_minimumclearance(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumclearance(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7630 (class 0 OID 0)
-- Dependencies: 1258
-- Name: FUNCTION st_minimumclearanceline(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_minimumclearanceline(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7631 (class 0 OID 0)
-- Dependencies: 1317
-- Name: FUNCTION st_mlinefromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7632 (class 0 OID 0)
-- Dependencies: 1215
-- Name: FUNCTION st_mlinefromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7633 (class 0 OID 0)
-- Dependencies: 1218
-- Name: FUNCTION st_mlinefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7634 (class 0 OID 0)
-- Dependencies: 678
-- Name: FUNCTION st_mlinefromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mlinefromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7635 (class 0 OID 0)
-- Dependencies: 1194
-- Name: FUNCTION st_mpointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7636 (class 0 OID 0)
-- Dependencies: 682
-- Name: FUNCTION st_mpointfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7637 (class 0 OID 0)
-- Dependencies: 545
-- Name: FUNCTION st_mpointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7638 (class 0 OID 0)
-- Dependencies: 1281
-- Name: FUNCTION st_mpointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7639 (class 0 OID 0)
-- Dependencies: 1306
-- Name: FUNCTION st_mpolyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7640 (class 0 OID 0)
-- Dependencies: 1127
-- Name: FUNCTION st_mpolyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7641 (class 0 OID 0)
-- Dependencies: 1346
-- Name: FUNCTION st_mpolyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7642 (class 0 OID 0)
-- Dependencies: 1085
-- Name: FUNCTION st_mpolyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_mpolyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7643 (class 0 OID 0)
-- Dependencies: 1039
-- Name: FUNCTION st_multi(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multi(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7644 (class 0 OID 0)
-- Dependencies: 1195
-- Name: FUNCTION st_multilinefromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinefromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7645 (class 0 OID 0)
-- Dependencies: 1338
-- Name: FUNCTION st_multilinestringfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinestringfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7646 (class 0 OID 0)
-- Dependencies: 1111
-- Name: FUNCTION st_multilinestringfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multilinestringfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7647 (class 0 OID 0)
-- Dependencies: 973
-- Name: FUNCTION st_multipointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7648 (class 0 OID 0)
-- Dependencies: 1421
-- Name: FUNCTION st_multipointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7649 (class 0 OID 0)
-- Dependencies: 1020
-- Name: FUNCTION st_multipointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7650 (class 0 OID 0)
-- Dependencies: 1154
-- Name: FUNCTION st_multipolyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7651 (class 0 OID 0)
-- Dependencies: 852
-- Name: FUNCTION st_multipolyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7652 (class 0 OID 0)
-- Dependencies: 610
-- Name: FUNCTION st_multipolygonfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolygonfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7653 (class 0 OID 0)
-- Dependencies: 669
-- Name: FUNCTION st_multipolygonfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_multipolygonfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7654 (class 0 OID 0)
-- Dependencies: 1387
-- Name: FUNCTION st_ndims(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ndims(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7655 (class 0 OID 0)
-- Dependencies: 1210
-- Name: FUNCTION st_node(g extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_node(g extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7656 (class 0 OID 0)
-- Dependencies: 931
-- Name: FUNCTION st_normalize(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_normalize(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7657 (class 0 OID 0)
-- Dependencies: 596
-- Name: FUNCTION st_npoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_npoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7658 (class 0 OID 0)
-- Dependencies: 1357
-- Name: FUNCTION st_nrings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_nrings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7659 (class 0 OID 0)
-- Dependencies: 1339
-- Name: FUNCTION st_numgeometries(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numgeometries(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7660 (class 0 OID 0)
-- Dependencies: 1163
-- Name: FUNCTION st_numinteriorring(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numinteriorring(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7661 (class 0 OID 0)
-- Dependencies: 903
-- Name: FUNCTION st_numinteriorrings(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numinteriorrings(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7662 (class 0 OID 0)
-- Dependencies: 899
-- Name: FUNCTION st_numpatches(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numpatches(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7663 (class 0 OID 0)
-- Dependencies: 1254
-- Name: FUNCTION st_numpoints(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_numpoints(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7664 (class 0 OID 0)
-- Dependencies: 1359
-- Name: FUNCTION st_offsetcurve(line extensions.geometry, distance double precision, params text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_offsetcurve(line extensions.geometry, distance double precision, params text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7665 (class 0 OID 0)
-- Dependencies: 798
-- Name: FUNCTION st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orderingequals(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7666 (class 0 OID 0)
-- Dependencies: 1239
-- Name: FUNCTION st_orientedenvelope(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_orientedenvelope(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7667 (class 0 OID 0)
-- Dependencies: 1191
-- Name: FUNCTION st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_overlaps(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7668 (class 0 OID 0)
-- Dependencies: 1144
-- Name: FUNCTION st_patchn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_patchn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7669 (class 0 OID 0)
-- Dependencies: 740
-- Name: FUNCTION st_perimeter(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7670 (class 0 OID 0)
-- Dependencies: 898
-- Name: FUNCTION st_perimeter(geog extensions.geography, use_spheroid boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter(geog extensions.geography, use_spheroid boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7671 (class 0 OID 0)
-- Dependencies: 1398
-- Name: FUNCTION st_perimeter2d(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_perimeter2d(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7672 (class 0 OID 0)
-- Dependencies: 729
-- Name: FUNCTION st_point(double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_point(double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7673 (class 0 OID 0)
-- Dependencies: 1362
-- Name: FUNCTION st_point(double precision, double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_point(double precision, double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7674 (class 0 OID 0)
-- Dependencies: 1423
-- Name: FUNCTION st_pointfromgeohash(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromgeohash(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7675 (class 0 OID 0)
-- Dependencies: 784
-- Name: FUNCTION st_pointfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7676 (class 0 OID 0)
-- Dependencies: 1090
-- Name: FUNCTION st_pointfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7677 (class 0 OID 0)
-- Dependencies: 978
-- Name: FUNCTION st_pointfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7678 (class 0 OID 0)
-- Dependencies: 624
-- Name: FUNCTION st_pointfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7679 (class 0 OID 0)
-- Dependencies: 897
-- Name: FUNCTION st_pointinsidecircle(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointinsidecircle(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7680 (class 0 OID 0)
-- Dependencies: 1159
-- Name: FUNCTION st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointm(xcoordinate double precision, ycoordinate double precision, mcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7681 (class 0 OID 0)
-- Dependencies: 1332
-- Name: FUNCTION st_pointn(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointn(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7682 (class 0 OID 0)
-- Dependencies: 888
-- Name: FUNCTION st_pointonsurface(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointonsurface(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7683 (class 0 OID 0)
-- Dependencies: 860
-- Name: FUNCTION st_points(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_points(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7684 (class 0 OID 0)
-- Dependencies: 1374
-- Name: FUNCTION st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointz(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7685 (class 0 OID 0)
-- Dependencies: 620
-- Name: FUNCTION st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_pointzm(xcoordinate double precision, ycoordinate double precision, zcoordinate double precision, mcoordinate double precision, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7686 (class 0 OID 0)
-- Dependencies: 904
-- Name: FUNCTION st_polyfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7687 (class 0 OID 0)
-- Dependencies: 1200
-- Name: FUNCTION st_polyfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7688 (class 0 OID 0)
-- Dependencies: 1069
-- Name: FUNCTION st_polyfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7689 (class 0 OID 0)
-- Dependencies: 723
-- Name: FUNCTION st_polyfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polyfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7690 (class 0 OID 0)
-- Dependencies: 1436
-- Name: FUNCTION st_polygon(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygon(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7691 (class 0 OID 0)
-- Dependencies: 1021
-- Name: FUNCTION st_polygonfromtext(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromtext(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7692 (class 0 OID 0)
-- Dependencies: 1110
-- Name: FUNCTION st_polygonfromtext(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromtext(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7693 (class 0 OID 0)
-- Dependencies: 1097
-- Name: FUNCTION st_polygonfromwkb(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromwkb(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7694 (class 0 OID 0)
-- Dependencies: 674
-- Name: FUNCTION st_polygonfromwkb(bytea, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonfromwkb(bytea, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7695 (class 0 OID 0)
-- Dependencies: 1016
-- Name: FUNCTION st_polygonize(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonize(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7696 (class 0 OID 0)
-- Dependencies: 984
-- Name: FUNCTION st_project(geog extensions.geography, distance double precision, azimuth double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_project(geog extensions.geography, distance double precision, azimuth double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7697 (class 0 OID 0)
-- Dependencies: 602
-- Name: FUNCTION st_quantizecoordinates(g extensions.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_quantizecoordinates(g extensions.geometry, prec_x integer, prec_y integer, prec_z integer, prec_m integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7698 (class 0 OID 0)
-- Dependencies: 859
-- Name: FUNCTION st_reduceprecision(geom extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_reduceprecision(geom extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7699 (class 0 OID 0)
-- Dependencies: 1155
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7700 (class 0 OID 0)
-- Dependencies: 1063
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7701 (class 0 OID 0)
-- Dependencies: 1352
-- Name: FUNCTION st_relate(geom1 extensions.geometry, geom2 extensions.geometry, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relate(geom1 extensions.geometry, geom2 extensions.geometry, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7702 (class 0 OID 0)
-- Dependencies: 1335
-- Name: FUNCTION st_relatematch(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_relatematch(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7703 (class 0 OID 0)
-- Dependencies: 1273
-- Name: FUNCTION st_removepoint(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_removepoint(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7704 (class 0 OID 0)
-- Dependencies: 804
-- Name: FUNCTION st_removerepeatedpoints(geom extensions.geometry, tolerance double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_removerepeatedpoints(geom extensions.geometry, tolerance double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7705 (class 0 OID 0)
-- Dependencies: 868
-- Name: FUNCTION st_reverse(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_reverse(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7706 (class 0 OID 0)
-- Dependencies: 875
-- Name: FUNCTION st_rotate(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7707 (class 0 OID 0)
-- Dependencies: 1349
-- Name: FUNCTION st_rotate(extensions.geometry, double precision, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7708 (class 0 OID 0)
-- Dependencies: 956
-- Name: FUNCTION st_rotate(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotate(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7709 (class 0 OID 0)
-- Dependencies: 918
-- Name: FUNCTION st_rotatex(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatex(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7710 (class 0 OID 0)
-- Dependencies: 548
-- Name: FUNCTION st_rotatey(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatey(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7711 (class 0 OID 0)
-- Dependencies: 1263
-- Name: FUNCTION st_rotatez(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_rotatez(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7712 (class 0 OID 0)
-- Dependencies: 1013
-- Name: FUNCTION st_scale(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7713 (class 0 OID 0)
-- Dependencies: 759
-- Name: FUNCTION st_scale(extensions.geometry, extensions.geometry, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, extensions.geometry, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7714 (class 0 OID 0)
-- Dependencies: 794
-- Name: FUNCTION st_scale(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7715 (class 0 OID 0)
-- Dependencies: 1396
-- Name: FUNCTION st_scale(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scale(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7716 (class 0 OID 0)
-- Dependencies: 606
-- Name: FUNCTION st_scroll(extensions.geometry, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_scroll(extensions.geometry, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7717 (class 0 OID 0)
-- Dependencies: 543
-- Name: FUNCTION st_segmentize(geog extensions.geography, max_segment_length double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_segmentize(geog extensions.geography, max_segment_length double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7718 (class 0 OID 0)
-- Dependencies: 629
-- Name: FUNCTION st_segmentize(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_segmentize(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7719 (class 0 OID 0)
-- Dependencies: 711
-- Name: FUNCTION st_seteffectivearea(extensions.geometry, double precision, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_seteffectivearea(extensions.geometry, double precision, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7720 (class 0 OID 0)
-- Dependencies: 731
-- Name: FUNCTION st_setpoint(extensions.geometry, integer, extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setpoint(extensions.geometry, integer, extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7721 (class 0 OID 0)
-- Dependencies: 1409
-- Name: FUNCTION st_setsrid(geog extensions.geography, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setsrid(geog extensions.geography, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7722 (class 0 OID 0)
-- Dependencies: 818
-- Name: FUNCTION st_setsrid(geom extensions.geometry, srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_setsrid(geom extensions.geometry, srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7723 (class 0 OID 0)
-- Dependencies: 1004
-- Name: FUNCTION st_sharedpaths(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_sharedpaths(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7724 (class 0 OID 0)
-- Dependencies: 968
-- Name: FUNCTION st_shiftlongitude(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_shiftlongitude(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7725 (class 0 OID 0)
-- Dependencies: 1269
-- Name: FUNCTION st_shortestline(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_shortestline(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7726 (class 0 OID 0)
-- Dependencies: 951
-- Name: FUNCTION st_simplify(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplify(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7727 (class 0 OID 0)
-- Dependencies: 1274
-- Name: FUNCTION st_simplify(extensions.geometry, double precision, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplify(extensions.geometry, double precision, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7728 (class 0 OID 0)
-- Dependencies: 1098
-- Name: FUNCTION st_simplifypolygonhull(geom extensions.geometry, vertex_fraction double precision, is_outer boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifypolygonhull(geom extensions.geometry, vertex_fraction double precision, is_outer boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7729 (class 0 OID 0)
-- Dependencies: 741
-- Name: FUNCTION st_simplifypreservetopology(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifypreservetopology(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7730 (class 0 OID 0)
-- Dependencies: 1024
-- Name: FUNCTION st_simplifyvw(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_simplifyvw(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7731 (class 0 OID 0)
-- Dependencies: 843
-- Name: FUNCTION st_snap(geom1 extensions.geometry, geom2 extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snap(geom1 extensions.geometry, geom2 extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7732 (class 0 OID 0)
-- Dependencies: 738
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7733 (class 0 OID 0)
-- Dependencies: 1406
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7734 (class 0 OID 0)
-- Dependencies: 664
-- Name: FUNCTION st_snaptogrid(extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7735 (class 0 OID 0)
-- Dependencies: 891
-- Name: FUNCTION st_snaptogrid(geom1 extensions.geometry, geom2 extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_snaptogrid(geom1 extensions.geometry, geom2 extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7736 (class 0 OID 0)
-- Dependencies: 1310
-- Name: FUNCTION st_split(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_split(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7737 (class 0 OID 0)
-- Dependencies: 1126
-- Name: FUNCTION st_square(size double precision, cell_i integer, cell_j integer, origin extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_square(size double precision, cell_i integer, cell_j integer, origin extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7738 (class 0 OID 0)
-- Dependencies: 945
-- Name: FUNCTION st_squaregrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_squaregrid(size double precision, bounds extensions.geometry, OUT geom extensions.geometry, OUT i integer, OUT j integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7739 (class 0 OID 0)
-- Dependencies: 646
-- Name: FUNCTION st_srid(geog extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_srid(geog extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7740 (class 0 OID 0)
-- Dependencies: 1043
-- Name: FUNCTION st_srid(geom extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_srid(geom extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7741 (class 0 OID 0)
-- Dependencies: 1030
-- Name: FUNCTION st_startpoint(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_startpoint(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7742 (class 0 OID 0)
-- Dependencies: 1125
-- Name: FUNCTION st_subdivide(geom extensions.geometry, maxvertices integer, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_subdivide(geom extensions.geometry, maxvertices integer, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7743 (class 0 OID 0)
-- Dependencies: 1219
-- Name: FUNCTION st_summary(extensions.geography); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_summary(extensions.geography) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7744 (class 0 OID 0)
-- Dependencies: 708
-- Name: FUNCTION st_summary(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_summary(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7745 (class 0 OID 0)
-- Dependencies: 874
-- Name: FUNCTION st_swapordinates(geom extensions.geometry, ords cstring); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_swapordinates(geom extensions.geometry, ords cstring) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7746 (class 0 OID 0)
-- Dependencies: 650
-- Name: FUNCTION st_symdifference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_symdifference(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7747 (class 0 OID 0)
-- Dependencies: 707
-- Name: FUNCTION st_symmetricdifference(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_symmetricdifference(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7748 (class 0 OID 0)
-- Dependencies: 1246
-- Name: FUNCTION st_tileenvelope(zoom integer, x integer, y integer, bounds extensions.geometry, margin double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_tileenvelope(zoom integer, x integer, y integer, bounds extensions.geometry, margin double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7749 (class 0 OID 0)
-- Dependencies: 1029
-- Name: FUNCTION st_touches(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_touches(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7750 (class 0 OID 0)
-- Dependencies: 1290
-- Name: FUNCTION st_transform(extensions.geometry, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(extensions.geometry, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7751 (class 0 OID 0)
-- Dependencies: 1289
-- Name: FUNCTION st_transform(geom extensions.geometry, to_proj text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, to_proj text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7752 (class 0 OID 0)
-- Dependencies: 739
-- Name: FUNCTION st_transform(geom extensions.geometry, from_proj text, to_srid integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, from_proj text, to_srid integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7753 (class 0 OID 0)
-- Dependencies: 635
-- Name: FUNCTION st_transform(geom extensions.geometry, from_proj text, to_proj text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transform(geom extensions.geometry, from_proj text, to_proj text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7754 (class 0 OID 0)
-- Dependencies: 1238
-- Name: FUNCTION st_translate(extensions.geometry, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_translate(extensions.geometry, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7755 (class 0 OID 0)
-- Dependencies: 1112
-- Name: FUNCTION st_translate(extensions.geometry, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_translate(extensions.geometry, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7756 (class 0 OID 0)
-- Dependencies: 1064
-- Name: FUNCTION st_transscale(extensions.geometry, double precision, double precision, double precision, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_transscale(extensions.geometry, double precision, double precision, double precision, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7757 (class 0 OID 0)
-- Dependencies: 858
-- Name: FUNCTION st_triangulatepolygon(g1 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_triangulatepolygon(g1 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7758 (class 0 OID 0)
-- Dependencies: 1145
-- Name: FUNCTION st_unaryunion(extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_unaryunion(extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7759 (class 0 OID 0)
-- Dependencies: 1213
-- Name: FUNCTION st_union(extensions.geometry[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7760 (class 0 OID 0)
-- Dependencies: 1149
-- Name: FUNCTION st_union(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7761 (class 0 OID 0)
-- Dependencies: 1102
-- Name: FUNCTION st_union(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(geom1 extensions.geometry, geom2 extensions.geometry, gridsize double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7762 (class 0 OID 0)
-- Dependencies: 703
-- Name: FUNCTION st_voronoilines(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_voronoilines(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7763 (class 0 OID 0)
-- Dependencies: 977
-- Name: FUNCTION st_voronoipolygons(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_voronoipolygons(g1 extensions.geometry, tolerance double precision, extend_to extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7764 (class 0 OID 0)
-- Dependencies: 1208
-- Name: FUNCTION st_within(geom1 extensions.geometry, geom2 extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_within(geom1 extensions.geometry, geom2 extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7765 (class 0 OID 0)
-- Dependencies: 1366
-- Name: FUNCTION st_wkbtosql(wkb bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wkbtosql(wkb bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7766 (class 0 OID 0)
-- Dependencies: 1282
-- Name: FUNCTION st_wkttosql(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wkttosql(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7767 (class 0 OID 0)
-- Dependencies: 1222
-- Name: FUNCTION st_wrapx(geom extensions.geometry, wrap double precision, move double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_wrapx(geom extensions.geometry, wrap double precision, move double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7768 (class 0 OID 0)
-- Dependencies: 1044
-- Name: FUNCTION st_x(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_x(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7769 (class 0 OID 0)
-- Dependencies: 626
-- Name: FUNCTION st_xmax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_xmax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7770 (class 0 OID 0)
-- Dependencies: 773
-- Name: FUNCTION st_xmin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_xmin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7771 (class 0 OID 0)
-- Dependencies: 1297
-- Name: FUNCTION st_y(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_y(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7772 (class 0 OID 0)
-- Dependencies: 1172
-- Name: FUNCTION st_ymax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ymax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7773 (class 0 OID 0)
-- Dependencies: 1147
-- Name: FUNCTION st_ymin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_ymin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7774 (class 0 OID 0)
-- Dependencies: 1028
-- Name: FUNCTION st_z(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_z(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7775 (class 0 OID 0)
-- Dependencies: 1066
-- Name: FUNCTION st_zmax(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmax(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7776 (class 0 OID 0)
-- Dependencies: 909
-- Name: FUNCTION st_zmflag(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmflag(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7777 (class 0 OID 0)
-- Dependencies: 789
-- Name: FUNCTION st_zmin(extensions.box3d); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_zmin(extensions.box3d) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7778 (class 0 OID 0)
-- Dependencies: 1288
-- Name: FUNCTION stripe_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.stripe_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7779 (class 0 OID 0)
-- Dependencies: 1416
-- Name: FUNCTION stripe_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.stripe_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7780 (class 0 OID 0)
-- Dependencies: 627
-- Name: FUNCTION stripe_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.stripe_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7781 (class 0 OID 0)
-- Dependencies: 754
-- Name: FUNCTION unlockrows(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.unlockrows(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7782 (class 0 OID 0)
-- Dependencies: 933
-- Name: FUNCTION updategeometrysrid(character varying, character varying, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(character varying, character varying, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7783 (class 0 OID 0)
-- Dependencies: 901
-- Name: FUNCTION updategeometrysrid(character varying, character varying, character varying, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(character varying, character varying, character varying, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7784 (class 0 OID 0)
-- Dependencies: 896
-- Name: FUNCTION updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.updategeometrysrid(catalogn_name character varying, schema_name character varying, table_name character varying, column_name character varying, new_srid_in integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7785 (class 0 OID 0)
-- Dependencies: 1437
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7786 (class 0 OID 0)
-- Dependencies: 595
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7787 (class 0 OID 0)
-- Dependencies: 688
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7788 (class 0 OID 0)
-- Dependencies: 1007
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7789 (class 0 OID 0)
-- Dependencies: 1234
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7790 (class 0 OID 0)
-- Dependencies: 893
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7791 (class 0 OID 0)
-- Dependencies: 1323
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7792 (class 0 OID 0)
-- Dependencies: 961
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7793 (class 0 OID 0)
-- Dependencies: 1089
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7794 (class 0 OID 0)
-- Dependencies: 667
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7795 (class 0 OID 0)
-- Dependencies: 591
-- Name: FUNCTION wasm_fdw_handler(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.wasm_fdw_handler() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7796 (class 0 OID 0)
-- Dependencies: 1026
-- Name: FUNCTION wasm_fdw_meta(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.wasm_fdw_meta() TO postgres WITH GRANT OPTION;


--
-- TOC entry 7797 (class 0 OID 0)
-- Dependencies: 588
-- Name: FUNCTION wasm_fdw_validator(options text[], catalog oid); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.wasm_fdw_validator(options text[], catalog oid) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7798 (class 0 OID 0)
-- Dependencies: 751
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 7799 (class 0 OID 0)
-- Dependencies: 634
-- Name: FUNCTION custom_access_token_hook(event jsonb); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.custom_access_token_hook(event jsonb) FROM PUBLIC;
GRANT ALL ON FUNCTION public.custom_access_token_hook(event jsonb) TO service_role;
GRANT ALL ON FUNCTION public.custom_access_token_hook(event jsonb) TO supabase_auth_admin;


--
-- TOC entry 7800 (class 0 OID 0)
-- Dependencies: 1264
-- Name: FUNCTION get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone) TO postgres;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_js(p_dumped_db text, p_id_device bigint, p_time_start timestamp with time zone, p_time_end timestamp with time zone) TO service_role;


--
-- TOC entry 7801 (class 0 OID 0)
-- Dependencies: 675
-- Name: FUNCTION get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO postgres;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO anon;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO authenticated;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v2(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO service_role;


--
-- TOC entry 7802 (class 0 OID 0)
-- Dependencies: 1171
-- Name: FUNCTION get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO postgres;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO anon;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO authenticated;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v3(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO service_role;


--
-- TOC entry 7803 (class 0 OID 0)
-- Dependencies: 666
-- Name: FUNCTION get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint); Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO postgres;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO anon;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO authenticated;
GRANT ALL ON FUNCTION public.get_position_dump_for_rp_v4(p_setup_id integer, p_rp_id integer, p_time_start timestamp with time zone, p_time_end timestamp with time zone, p_id_device bigint) TO service_role;


--
-- TOC entry 7804 (class 0 OID 0)
-- Dependencies: 1003
-- Name: FUNCTION update_area_hierarchy_path(); Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON FUNCTION rtls_config.update_area_hierarchy_path() TO anon;
GRANT ALL ON FUNCTION rtls_config.update_area_hierarchy_path() TO authenticated;
GRANT ALL ON FUNCTION rtls_config.update_area_hierarchy_path() TO service_role;


--
-- TOC entry 7805 (class 0 OID 0)
-- Dependencies: 1383
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;


--
-- TOC entry 7806 (class 0 OID 0)
-- Dependencies: 1082
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 7807 (class 0 OID 0)
-- Dependencies: 1432
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 7808 (class 0 OID 0)
-- Dependencies: 900
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 7809 (class 0 OID 0)
-- Dependencies: 2840
-- Name: FUNCTION st_3dextent(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_3dextent(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7810 (class 0 OID 0)
-- Dependencies: 2827
-- Name: FUNCTION st_asflatgeobuf(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7811 (class 0 OID 0)
-- Dependencies: 2830
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement, boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7812 (class 0 OID 0)
-- Dependencies: 2835
-- Name: FUNCTION st_asflatgeobuf(anyelement, boolean, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asflatgeobuf(anyelement, boolean, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7813 (class 0 OID 0)
-- Dependencies: 2841
-- Name: FUNCTION st_asgeobuf(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeobuf(anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7814 (class 0 OID 0)
-- Dependencies: 2828
-- Name: FUNCTION st_asgeobuf(anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asgeobuf(anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7815 (class 0 OID 0)
-- Dependencies: 2831
-- Name: FUNCTION st_asmvt(anyelement); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7816 (class 0 OID 0)
-- Dependencies: 2836
-- Name: FUNCTION st_asmvt(anyelement, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7817 (class 0 OID 0)
-- Dependencies: 2842
-- Name: FUNCTION st_asmvt(anyelement, text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7818 (class 0 OID 0)
-- Dependencies: 2829
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7819 (class 0 OID 0)
-- Dependencies: 2832
-- Name: FUNCTION st_asmvt(anyelement, text, integer, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_asmvt(anyelement, text, integer, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7820 (class 0 OID 0)
-- Dependencies: 2837
-- Name: FUNCTION st_clusterintersecting(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterintersecting(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7821 (class 0 OID 0)
-- Dependencies: 2843
-- Name: FUNCTION st_clusterwithin(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_clusterwithin(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7822 (class 0 OID 0)
-- Dependencies: 2846
-- Name: FUNCTION st_collect(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_collect(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7823 (class 0 OID 0)
-- Dependencies: 2833
-- Name: FUNCTION st_extent(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_extent(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7824 (class 0 OID 0)
-- Dependencies: 2838
-- Name: FUNCTION st_makeline(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_makeline(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7825 (class 0 OID 0)
-- Dependencies: 2844
-- Name: FUNCTION st_memcollect(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memcollect(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7826 (class 0 OID 0)
-- Dependencies: 2847
-- Name: FUNCTION st_memunion(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_memunion(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7827 (class 0 OID 0)
-- Dependencies: 2834
-- Name: FUNCTION st_polygonize(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_polygonize(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7828 (class 0 OID 0)
-- Dependencies: 2839
-- Name: FUNCTION st_union(extensions.geometry); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7829 (class 0 OID 0)
-- Dependencies: 2845
-- Name: FUNCTION st_union(extensions.geometry, double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.st_union(extensions.geometry, double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 7855 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 7857 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 7860 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 7862 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 7864 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 7866 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 7868 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 7869 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 7871 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 7873 (class 0 OID 0)
-- Dependencies: 338
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 7875 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 7877 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 7879 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 7882 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 7884 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 7887 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 7890 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 7891 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- TOC entry 7892 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- TOC entry 7893 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE wrappers_fdw_stats; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.wrappers_fdw_stats TO postgres WITH GRANT OPTION;


--
-- TOC entry 7903 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- TOC entry 7913 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.roles TO anon;
GRANT ALL ON TABLE public.roles TO authenticated;
GRANT ALL ON TABLE public.roles TO service_role;


--
-- TOC entry 7914 (class 0 OID 0)
-- Dependencies: 348
-- Name: TABLE device; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_measurement.device TO anon;
GRANT ALL ON TABLE rtls_measurement.device TO authenticated;
GRANT ALL ON TABLE rtls_measurement.device TO service_role;


--
-- TOC entry 7915 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE rtls_measurement_device; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.rtls_measurement_device TO postgres;
GRANT ALL ON TABLE public.rtls_measurement_device TO anon;
GRANT ALL ON TABLE public.rtls_measurement_device TO authenticated;
GRANT ALL ON TABLE public.rtls_measurement_device TO service_role;


--
-- TOC entry 7916 (class 0 OID 0)
-- Dependencies: 350
-- Name: TABLE position_dump; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT SELECT ON TABLE rtls_measurement.position_dump TO authenticated;


--
-- TOC entry 7917 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE rtls_measurement_position_dump; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.rtls_measurement_position_dump TO postgres;
GRANT ALL ON TABLE public.rtls_measurement_position_dump TO anon;
GRANT ALL ON TABLE public.rtls_measurement_position_dump TO authenticated;
GRANT ALL ON TABLE public.rtls_measurement_position_dump TO service_role;


--
-- TOC entry 7918 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE reference_point; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_measurement.reference_point TO anon;
GRANT ALL ON TABLE rtls_measurement.reference_point TO authenticated;
GRANT ALL ON TABLE rtls_measurement.reference_point TO service_role;


--
-- TOC entry 7919 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE rtls_measurement_reference_point; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.rtls_measurement_reference_point TO postgres;
GRANT ALL ON TABLE public.rtls_measurement_reference_point TO anon;
GRANT ALL ON TABLE public.rtls_measurement_reference_point TO authenticated;
GRANT ALL ON TABLE public.rtls_measurement_reference_point TO service_role;


--
-- TOC entry 7920 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE reference_point_measurement; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_measurement.reference_point_measurement TO anon;
GRANT ALL ON TABLE rtls_measurement.reference_point_measurement TO authenticated;
GRANT ALL ON TABLE rtls_measurement.reference_point_measurement TO service_role;


--
-- TOC entry 7921 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE rtls_measurement_reference_point_measurement; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.rtls_measurement_reference_point_measurement TO postgres;
GRANT ALL ON TABLE public.rtls_measurement_reference_point_measurement TO anon;
GRANT ALL ON TABLE public.rtls_measurement_reference_point_measurement TO authenticated;
GRANT ALL ON TABLE public.rtls_measurement_reference_point_measurement TO service_role;


--
-- TOC entry 7922 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE setup; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_measurement.setup TO anon;
GRANT ALL ON TABLE rtls_measurement.setup TO authenticated;
GRANT ALL ON TABLE rtls_measurement.setup TO service_role;


--
-- TOC entry 7923 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE rtls_measurement_setup; Type: ACL; Schema: public; Owner: supabase_admin
--

GRANT ALL ON TABLE public.rtls_measurement_setup TO postgres;
GRANT ALL ON TABLE public.rtls_measurement_setup TO anon;
GRANT ALL ON TABLE public.rtls_measurement_setup TO authenticated;
GRANT ALL ON TABLE public.rtls_measurement_setup TO service_role;


--
-- TOC entry 7928 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE user_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_roles TO anon;
GRANT ALL ON TABLE public.user_roles TO authenticated;
GRANT ALL ON TABLE public.user_roles TO service_role;
GRANT ALL ON TABLE public.user_roles TO supabase_auth_admin;


--
-- TOC entry 7930 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE user_permissions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_permissions TO anon;
GRANT ALL ON TABLE public.user_permissions TO authenticated;
GRANT ALL ON TABLE public.user_permissions TO service_role;


--
-- TOC entry 7931 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE alarm_events; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.alarm_events TO anon;
GRANT ALL ON TABLE rtls_config.alarm_events TO authenticated;
GRANT ALL ON TABLE rtls_config.alarm_events TO service_role;


--
-- TOC entry 7933 (class 0 OID 0)
-- Dependencies: 361
-- Name: SEQUENCE alarm_events_id_alarm_seq; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_config.alarm_events_id_alarm_seq TO anon;
GRANT ALL ON SEQUENCE rtls_config.alarm_events_id_alarm_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_config.alarm_events_id_alarm_seq TO service_role;


--
-- TOC entry 7944 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE area; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.area TO anon;
GRANT ALL ON TABLE rtls_config.area TO authenticated;
GRANT ALL ON TABLE rtls_config.area TO service_role;


--
-- TOC entry 7945 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE area_permission; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.area_permission TO anon;
GRANT ALL ON TABLE rtls_config.area_permission TO authenticated;
GRANT ALL ON TABLE rtls_config.area_permission TO service_role;


--
-- TOC entry 7946 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE asset; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.asset TO anon;
GRANT ALL ON TABLE rtls_config.asset TO authenticated;
GRANT ALL ON TABLE rtls_config.asset TO service_role;


--
-- TOC entry 7948 (class 0 OID 0)
-- Dependencies: 365
-- Name: SEQUENCE asset_id_asset_seq; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_config.asset_id_asset_seq TO anon;
GRANT ALL ON SEQUENCE rtls_config.asset_id_asset_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_config.asset_id_asset_seq TO service_role;


--
-- TOC entry 7949 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE asset_type; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.asset_type TO anon;
GRANT ALL ON TABLE rtls_config.asset_type TO authenticated;
GRANT ALL ON TABLE rtls_config.asset_type TO service_role;


--
-- TOC entry 7951 (class 0 OID 0)
-- Dependencies: 367
-- Name: SEQUENCE asset_type_id_asset_type_seq; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_config.asset_type_id_asset_type_seq TO anon;
GRANT ALL ON SEQUENCE rtls_config.asset_type_id_asset_type_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_config.asset_type_id_asset_type_seq TO service_role;


--
-- TOC entry 7952 (class 0 OID 0)
-- Dependencies: 368
-- Name: TABLE flyway_schema_history; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.flyway_schema_history TO anon;
GRANT ALL ON TABLE rtls_config.flyway_schema_history TO authenticated;
GRANT ALL ON TABLE rtls_config.flyway_schema_history TO service_role;


--
-- TOC entry 7953 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE frontend_last_position_tag; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT SELECT ON TABLE rtls_config.frontend_last_position_tag TO authenticated;


--
-- TOC entry 7954 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE frontend_raster_layers; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.frontend_raster_layers TO anon;
GRANT ALL ON TABLE rtls_config.frontend_raster_layers TO authenticated;
GRANT ALL ON TABLE rtls_config.frontend_raster_layers TO service_role;


--
-- TOC entry 7956 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE map_image; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.map_image TO anon;
GRANT ALL ON TABLE rtls_config.map_image TO authenticated;
GRANT ALL ON TABLE rtls_config.map_image TO service_role;


--
-- TOC entry 7957 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE uwb_device; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_config.uwb_device TO anon;
GRANT ALL ON TABLE rtls_config.uwb_device TO authenticated;
GRANT ALL ON TABLE rtls_config.uwb_device TO service_role;


--
-- TOC entry 7959 (class 0 OID 0)
-- Dependencies: 375
-- Name: SEQUENCE uwb_device_id_device_seq; Type: ACL; Schema: rtls_config; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_config.uwb_device_id_device_seq TO anon;
GRANT ALL ON SEQUENCE rtls_config.uwb_device_id_device_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_config.uwb_device_id_device_seq TO service_role;


--
-- TOC entry 7961 (class 0 OID 0)
-- Dependencies: 376
-- Name: SEQUENCE device_id_device_seq; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_measurement.device_id_device_seq TO anon;
GRANT ALL ON SEQUENCE rtls_measurement.device_id_device_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_measurement.device_id_device_seq TO service_role;


--
-- TOC entry 7962 (class 0 OID 0)
-- Dependencies: 378
-- Name: TABLE position_dump_geojson; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT SELECT ON TABLE rtls_measurement.position_dump_geojson TO authenticated;


--
-- TOC entry 7964 (class 0 OID 0)
-- Dependencies: 379
-- Name: SEQUENCE reference_point_id_reference_point_seq; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_measurement.reference_point_id_reference_point_seq TO anon;
GRANT ALL ON SEQUENCE rtls_measurement.reference_point_id_reference_point_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_measurement.reference_point_id_reference_point_seq TO service_role;


--
-- TOC entry 7966 (class 0 OID 0)
-- Dependencies: 380
-- Name: SEQUENCE reference_point_measurement_id_reference_point_measurement_seq; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq TO anon;
GRANT ALL ON SEQUENCE rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_measurement.reference_point_measurement_id_reference_point_measurement_seq TO service_role;


--
-- TOC entry 7968 (class 0 OID 0)
-- Dependencies: 381
-- Name: SEQUENCE setup_id_setup_seq; Type: ACL; Schema: rtls_measurement; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE rtls_measurement.setup_id_setup_seq TO anon;
GRANT ALL ON SEQUENCE rtls_measurement.setup_id_setup_seq TO authenticated;
GRANT ALL ON SEQUENCE rtls_measurement.setup_id_setup_seq TO service_role;


--
-- TOC entry 7969 (class 0 OID 0)
-- Dependencies: 382
-- Name: TABLE device; Type: ACL; Schema: rtls_measurement_2; Owner: postgres
--

GRANT ALL ON TABLE rtls_measurement_2.device TO anon;
GRANT ALL ON TABLE rtls_measurement_2.device TO authenticated;
GRANT ALL ON TABLE rtls_measurement_2.device TO service_role;


--
-- TOC entry 7970 (class 0 OID 0)
-- Dependencies: 383
-- Name: TABLE "position"; Type: ACL; Schema: rtls_measurement_2; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_measurement_2."position" TO anon;
GRANT ALL ON TABLE rtls_measurement_2."position" TO authenticated;


--
-- TOC entry 7971 (class 0 OID 0)
-- Dependencies: 384
-- Name: TABLE reference_point; Type: ACL; Schema: rtls_measurement_2; Owner: postgres
--

GRANT ALL ON TABLE rtls_measurement_2.reference_point TO anon;
GRANT ALL ON TABLE rtls_measurement_2.reference_point TO authenticated;
GRANT ALL ON TABLE rtls_measurement_2.reference_point TO service_role;


--
-- TOC entry 7972 (class 0 OID 0)
-- Dependencies: 385
-- Name: TABLE reference_point_measurement; Type: ACL; Schema: rtls_measurement_2; Owner: postgres
--

GRANT ALL ON TABLE rtls_measurement_2.reference_point_measurement TO anon;
GRANT ALL ON TABLE rtls_measurement_2.reference_point_measurement TO authenticated;
GRANT ALL ON TABLE rtls_measurement_2.reference_point_measurement TO service_role;


--
-- TOC entry 7973 (class 0 OID 0)
-- Dependencies: 386
-- Name: TABLE setup; Type: ACL; Schema: rtls_measurement_2; Owner: postgres
--

GRANT ALL ON TABLE rtls_measurement_2.setup TO anon;
GRANT ALL ON TABLE rtls_measurement_2.setup TO authenticated;
GRANT ALL ON TABLE rtls_measurement_2.setup TO service_role;


--
-- TOC entry 7974 (class 0 OID 0)
-- Dependencies: 387
-- Name: TABLE setup_reference_point; Type: ACL; Schema: rtls_measurement_2; Owner: supabase_admin
--

GRANT ALL ON TABLE rtls_measurement_2.setup_reference_point TO anon;
GRANT ALL ON TABLE rtls_measurement_2.setup_reference_point TO authenticated;


--
-- TOC entry 7983 (class 0 OID 0)
-- Dependencies: 430
-- Name: TABLE "position"; Type: ACL; Schema: rtls_timeseries; Owner: supabase_admin
--

GRANT SELECT ON TABLE rtls_timeseries."position" TO authenticated;


--
-- TOC entry 7984 (class 0 OID 0)
-- Dependencies: 446
-- Name: TABLE position_area; Type: ACL; Schema: rtls_timeseries; Owner: supabase_admin
--

GRANT SELECT ON TABLE rtls_timeseries.position_area TO authenticated;


--
-- TOC entry 7985 (class 0 OID 0)
-- Dependencies: 462
-- Name: TABLE position_dump_geojson; Type: ACL; Schema: rtls_timeseries; Owner: supabase_admin
--

GRANT SELECT ON TABLE rtls_timeseries.position_dump_geojson TO authenticated;


--
-- TOC entry 7998 (class 0 OID 0)
-- Dependencies: 496
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- TOC entry 7999 (class 0 OID 0)
-- Dependencies: 497
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- TOC entry 8000 (class 0 OID 0)
-- Dependencies: 498
-- Name: TABLE iceberg_namespaces; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_namespaces TO service_role;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO anon;


--
-- TOC entry 8001 (class 0 OID 0)
-- Dependencies: 499
-- Name: TABLE iceberg_tables; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_tables TO service_role;
GRANT SELECT ON TABLE storage.iceberg_tables TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_tables TO anon;


--
-- TOC entry 8003 (class 0 OID 0)
-- Dependencies: 501
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- TOC entry 8004 (class 0 OID 0)
-- Dependencies: 502
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- TOC entry 8005 (class 0 OID 0)
-- Dependencies: 503
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 8006 (class 0 OID 0)
-- Dependencies: 504
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 8008 (class 0 OID 0)
-- Dependencies: 505
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- TOC entry 8010 (class 0 OID 0)
-- Dependencies: 506
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- TOC entry 8011 (class 0 OID 0)
-- Dependencies: 507
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- TOC entry 8012 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 8013 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 4137 (class 826 OID 34510)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 4150 (class 826 OID 34511)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 4125 (class 826 OID 34509)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 4142 (class 826 OID 34520)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 4141 (class 826 OID 34519)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 4152 (class 826 OID 34518)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 4143 (class 826 OID 34523)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4153 (class 826 OID 34522)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4128 (class 826 OID 34521)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4139 (class 826 OID 34515)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4127 (class 826 OID 34517)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4140 (class 826 OID 34516)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4131 (class 826 OID 34498)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4122 (class 826 OID 34497)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4132 (class 826 OID 34499)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4148 (class 826 OID 34502)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4147 (class 826 OID 34500)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4123 (class 826 OID 34501)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4126 (class 826 OID 34513)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 4151 (class 826 OID 34514)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 4138 (class 826 OID 34512)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 4154 (class 826 OID 34526)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: rtls_config; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4129 (class 826 OID 34525)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: rtls_config; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4144 (class 826 OID 34524)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: rtls_config; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_config GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4130 (class 826 OID 34529)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: rtls_measurement; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4146 (class 826 OID 34528)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: rtls_measurement; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4145 (class 826 OID 34527)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: rtls_measurement; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA rtls_measurement GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4124 (class 826 OID 34505)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4134 (class 826 OID 34504)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4133 (class 826 OID 34503)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 4136 (class 826 OID 34508)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 4149 (class 826 OID 34507)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 4135 (class 826 OID 34506)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA supabase_functions GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 5352 (class 3466 OID 34535)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 5354 (class 3466 OID 34537)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 5351 (class 3466 OID 34534)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 5355 (class 3466 OID 34538)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 5353 (class 3466 OID 34536)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 5350 (class 3466 OID 34533)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2026-05-04 10:53:22 CEST

--
-- PostgreSQL database dump complete
--

--\unrestrict KKXw71o0UCYIDCWOQQnPmZYeCvpWL1TlJ9O3bhtw77bqmy2vgaIkz3K8lPJVbGH

