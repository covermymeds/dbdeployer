#!/usr/bin/env bash
function drop_database() {

  _drop_dbname="$1"

  ${db_binary} -D ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -e "
  select concat('KILL ',id,';') from information_schema.processlist where DB = '${_drop_dbname}';
  " > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  ${db_binary} -D ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -e "
  drop database \"${_drop_dbname}\"; 
  " > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset _drop_dbname
  return 0
}
