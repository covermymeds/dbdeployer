#!/bin/bash
function update_deployment_tracker() {

  _dbname="$1"

  ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -b -Q "
  update deployment_tracker 
  set is_active = false,
  updated_at = getdate()
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
