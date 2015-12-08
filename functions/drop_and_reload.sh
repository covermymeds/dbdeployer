#!/usr/bin/env bash
function drop_and_reload() {

  __dbname="$1"
  __db_destination_name="$2"

  drop_database "${__db_destination_name}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  create_database "${__db_destination_name}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  update_deployment_tracker "${__db_destination_name}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  update_db_to_current "${__dbname}" "${__db_destination_name}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset __dbname
  unset __db_destination_name
  return 0

}
