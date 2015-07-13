#!/usr/bin/env bash
function deploy_file() {
  _deploy_file="$1"
  _logfile="$2"

  ${db_binary} ${dbname} ${server_flag} ${user_flag} ${port_flag} -1 -X -v 'timing' -v 'ON_ERROR_STOP=1' -a -f "${_deploy_file}" -L "${_logfile}"
  rc=$?

  unset _deploy_file
  unset _logfile

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
