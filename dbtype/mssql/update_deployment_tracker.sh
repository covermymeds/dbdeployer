#!/bin/bash
function update_deployment_tracker() {

  _db_destination_name="$1"

  ${db_binary} -d ${deployment_db} ${server_flag} ${port_flag} ${encryption_flag} ${user_flag} ${password_flag} -l0 -b -Q "
  update deployment_tracker 
  set is_active = 0,
  updated_at = getdate()
  where dbname = '${_db_destination_name}'
  and ISNULL(is_active,1) = 1
  ;"
# > /dev/null 2>&1
  rc=$?

  unset _db_destination_name

  if [ ${rc} -eq 0 ] 
  then
    return 0
  else
    return 1
  fi
}
