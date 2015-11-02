#!/bin/bash
function update_deployment_tracker() {

  _dbname="$1"

  ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -b -Q "
  update deployment_tracker 
  set is_active = 0,
  updated_at = getdate()
  where dbname = '${_dbname}'
  and ISNULL(is_active,1) = 1
  ;"
# > /dev/null 2>&1
  rc=$?

  unset _dbname

  if [ ${rc} -eq 0 ] 
  then
    return 0
  else
    return 1
  fi
}
