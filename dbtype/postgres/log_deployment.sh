#!/usr/bin/env bash
function log_deployment() {

  _deploy_db="$1"
  _change_type="$2"
  _filename="$3"
  _state="$4"
  _additional_fields=''
  _additonal_values=''

  if [ "${_deploy_db}" != "${deployment_db}" ]
  then
    _additional_fields=",
    deployed_by,
    deployed_as,
    reference_url"
    _additional_values=",
    '${deployed_by}',
    '${deployed_as}',
    '${change_control}'"
  fi

  _query_string="
  insert into deployment_tracker 
  ( 
    dbname, 
    deployment_type , 
    deployment_name , 
    deployment_outcome
    $_additional_fields
  )
  values 
  ( 
    '${_deploy_db}', 
    '${_change_type}', 
    '${_filename}', 
    '${_state}'
    $_additional_values
  )
  ;"


  ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -c "${_query_string}" > /dev/null 2>&1
  rc=$?

  unset _deploy_db
  unset _change_type
  unset _filename
  unset _state
  unset _query_string
  unset _additional_fields
  unset _additional_values

  if [ ${rc} -eq 0 ] 
  then
    return 0
  else
    return 1
  fi
}
