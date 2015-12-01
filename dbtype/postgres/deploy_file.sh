#!/usr/bin/env bash
function deploy_file() {
  _db_to_deploy="${1}"
  _deploy_file="${2}"
  if ! [ -z "${3}" ]
  then 
    _logfile="-L${3}"
  fi

  ${db_binary} ${_db_to_deploy} ${server_flag} ${user_flag} ${port_flag} -1 -X -v 'timing' -v 'ON_ERROR_STOP=1' -a -f "${_deploy_file}" "${_logfile}"
  rc=$?

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
