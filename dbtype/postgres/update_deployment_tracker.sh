#!/usr/bin/env bash
function update_deployment_tracker() {

  _dbname="$1"

  ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -c "
  update deployment_tracker 
  set is_active = false,
  updated_at = now()
  where dbname = '${_dbname}'
  and is_active = true
  ;" > /dev/null 2>&1
  rc=$?

  unset _dbname

  if [ ${rc} -eq 0 ] 
  then
    return 0
  else
    return 1
  fi
}
