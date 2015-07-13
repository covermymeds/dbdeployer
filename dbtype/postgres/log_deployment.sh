#!/usr/bin/env bash
function log_deployment() {

  _deploy_db="$1"
  _change_type="$2"
  _filename="$3"
  _state="$4"

  ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -c "
  insert into deployment_tracker 
  ( 
    dbname, 
    deployment_type , 
    deployment_name , 
    deployment_outcome,
    deployed_by,
    deployed_as,
    reference_url
  )
  values 
  ( 
    '${_deploy_db}', 
    '${_change_type}', 
    '${_filename}', 
    '${_state}',
    '${deployed_by}',
    '${deployed_as}',
    '${change_control}'
  )
  ;" > /dev/null 2>&1
  rc=$?

  unset _deploy_db
  unset _change_type
  unset _filename
  unset _state

  if [ ${rc} -eq 0 ] 
  then
    return 0
  else
    return 1
  fi
}
