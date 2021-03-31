#!/usr/bin/env bash
function log_footer() {
  _logfile="${1}"
  _state="${2}"
  echo "---------------------------------------------------" >> "${_logfile}"
  echo "-- Deployment complete with status: ${_state}      " >> "${_logfile}"
  echo "---------------------------------------------------" >> "${_logfile}"
  rc=$?
  unset _logfile
  unset _state

  #I realize I'm only checking the last line here, but if it couldn't write to the file we 
  #still get an error.  Return 0 if successful right, 1 if couldn't write
  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi

}
