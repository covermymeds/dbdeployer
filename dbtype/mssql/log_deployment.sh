#!/bin/bash
function log_deployment() {

  _db_destination_name="$1"
  _change_type="$2"
  _filename="$3"
  _state="$4"
  _additional_fields=''
  _additonal_values=''
  _file_checksum="$5"
  _file_already_deployed="$6"

  if [[ "${_file_already_deployed}" == 'true' ]]
  then
    mark_inactive="
    UPDATE deployment_tracker 
    SET is_active = 0
    WHERE dbname = '${_db_destination_name}'
    AND deployment_type = '${_change_type}'
    AND deployment_name = '${_filename}'
    AND is_active = 1;";
  else
    mark_inactive=''
  fi

  if [ "${_db_destination_name}" != "${deployment_db}" ]
  then
    _additional_fields=",
    deployed_by,
    deployed_as,
    reference_url,
    checksum"
    _additional_values=",
    '${deployed_by}',
    '${deployed_as}',
    '${change_control}',
    '${_file_checksum}'"
  fi

  _query_string="
  BEGIN TRANSACTION;
  ${mark_inactive}
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
    '${_db_destination_name}', 
    '${_change_type}', 
    '${_filename}', 
    '${_state}'
    $_additional_values
  )
  ;
  COMMIT;"

  ${db_binary} -d ${deployment_db} ${server_flag} ${port_flag} ${encryption_flag} ${user_flag} ${password_flag} -l0 -b -Q "${_query_string}" > /dev/null 2>&1
  rc=$?

  unset _deploy_db
  unset _db_destination_name
  unset _change_type
  unset _filename
  unset _state
  unset _additional_fields
  unset _additional_values
  unset _file_checksum
  unset _file_already_deployed
  
  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
