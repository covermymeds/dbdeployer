#!/usr/bin/env bash
function log_header() {
  _logfile="${1}"
  echo "---------------------------------------------------" >> "${_logfile}"
  echo "-- Time: ${timestamp}                              " >> "${_logfile}"
  echo "-- Database: ${dbname}                             " >> "${_logfile}"
  echo "-- Change Type: ${change_type}                     " >> "${_logfile}"
  echo "-- Deployed File: ${file_path}                     " >> "${_logfile}"
  echo "---------------------------------------------------" >> "${_logfile}"
  rc=$?
  unset _logfile

  #I realize I'm only checking the last line here, but if it couldn't write to the file we 
  #still get an error.  Return 0 if successful right, 1 if couldn't write
  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi

}
