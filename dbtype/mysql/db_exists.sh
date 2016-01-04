#!/usr/bin/env bash
function db_exists() {
  _check_db="$1"

  eval `[[ "${_check_db}" =~ ^${dbname_regex}$ ]] && return 0 || return 1`
  rc=$?
  if [ $rc -eq 0 ]
  then

    query_output=`${switch_user_flag} ${db_binary} ${server_flag} ${user_flag} ${port_flag} -N -s --skip-pager -e "
    select coalesce ((SELECT count(SCHEMA_NAME) 
      FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${_check_db}'),0
    );" | xargs`

    if [ "${query_output}" == "1" ]
    then
      rc=0
    else
      rc=1
    fi
  else
    rc=1
  fi
  
  unset _check_db

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
