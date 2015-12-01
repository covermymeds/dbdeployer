#!/usr/bin/env bash
function drop_database() {

  _drop_dbname="$1"

  #postgres does not let you drop a database with active connections, so we must kill connections first
  ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -c "
  select pg_terminate_backend(pid) from pg_stat_activity where datname = '${_drop_dbname}';
  " > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -c "
  drop database \"${_drop_dbname}\"; 
  " > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset _drop_dbname
  return 0
}
