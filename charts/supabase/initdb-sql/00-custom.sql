-- migrate:up

--
-- Our Custom Fix so it works (adding pgbouncer stuff, else the migrations fail)
--

-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
CREATE SCHEMA pgbouncer;

-- Set up auth roles for the developer
create role pgbouncer       nologin noinherit;
-- Authenticator is not created yet 
-- grant pgbouncer              to authenticator;


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--
CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
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

-- migrate:down
