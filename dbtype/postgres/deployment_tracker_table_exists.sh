#!/usr/bin/env bash
deployment_tracker_table_exists() {

  _table_exists=`${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -1 -X -q -A -t -c "
  SELECT EXISTS (
    SELECT 1 
    FROM   pg_catalog.pg_class c
    JOIN   pg_catalog.pg_namespace n ON n.oid = c.relnamespace
    WHERE  n.nspname = 'public'
    AND    c.relname = 'deployment_tracker'
    AND    c.relkind = 'r'    -- only tables(?)
  );"`

  if [ "$_table_exists" = 't' ]
  then
    return 0
  else
    return 1
  fi
}
