#!/usr/bin/env bash
function update_deployment_tracker() {

  _db_destination_name="$1"

  ${db_binary} -D ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -e "
  update deployment_tracker 
  set is_active = false,
  updated_at = now()
  where dbname = '${_db_destination_name}'
  and is_active = true
  ;" > /dev/null 2>&1
  rc=$?

  unset _db_destination_name

  if [ ${rc} -eq 0 ] 
  then
    return 0
  else
    return 1
  fi
}
