#!/usr/bin/env bash
function deploy_file() {
  _db_to_deploy="${1}"
  _deploy_file="${2}"
  if ! [ -z "${3}" ]
  then 
    _logfile="${3}"
  fi

  deploy_output=`${db_binary} -D ${_db_to_deploy} ${server_flag} ${user_flag} ${port_flag} -vvv --skip-pager < "${_deploy_file}"`
  rc=$?
 
  echo "${deploy_output}"

  if ! [ -z "${_logfile}" ]
  then
    echo "${deploy_output}" >> "${_logfile}"
  fi

  unset _db_to_deploy
  unset _deploy_file
  unset _logfile

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
