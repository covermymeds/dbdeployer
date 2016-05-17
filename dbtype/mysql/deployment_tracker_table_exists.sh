#!/usr/bin/env bash
deployment_tracker_table_exists() {

  _table_exists=`${db_binary} -D ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -N -s --skip-pager -e "
  SELECT count(*) 
  FROM information_schema.tables
  WHERE table_schema = '${deployment_db}' 
  AND table_name = 'deployment_tracker'
  LIMIT 1;
  "`

  if [ "$_table_exists" = '1' ]
  then
    return 0
  else
    return 1
  fi
}
