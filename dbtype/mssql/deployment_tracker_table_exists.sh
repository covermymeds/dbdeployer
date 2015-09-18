#!/usr/bin/env bash
deployment_tracker_table_exists() {

  _table_exists=`${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -h -1 -b -Q "
  SET NOCOUNT ON;
  if OBJECT_ID('deployments.dbo.deployment_tracker') is not NULL
  select 't';"`

  if [ "${_table_exists}" = 't' ]
  then
    return 0
  else
    return 1
  fi
}
