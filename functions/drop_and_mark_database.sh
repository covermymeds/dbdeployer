#!/usr/bin/env bash
function drop_and_mark_database() {

  __db_destination_name="$1"

  drop_database "${__db_destination_name}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi
  update_deployment_tracker "${__db_destination_name}"
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset __db_destination_name
  return 0

}
