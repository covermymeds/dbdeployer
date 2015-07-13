#!/usr/bin/env bash
function drop_and_reload() {

  __dbname="$1"
  drop_database "${__dbname}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  create_database "${__dbname}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  update_deployment_tracker "${__dbname}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  update_db_to_current "${__dbname}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset _dbname
  return 0

}
