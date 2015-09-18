#!/usr/bin/env bash
db_report_string() {
  _deployment_type="$1"

  deployment_tracker_table_exists

  if [ $? -eq 0 ]
  then
  
    ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -1 -X -q -A -t -c "
    SELECT CONCAT('${db_basedir}/',dbname,'/',deployment_type,'/',deployment_name) 
    FROM deployment_tracker 
    WHERE dbname = '${dbname}' 
    AND deployment_type = '${_deployment_type}' 
    AND deployment_outcome in ('OK','SKIP')
    AND is_active is true;" | sort -rn
    
    if [ $? -ne 0 ] 
    then
      return_val=1
    else
      return_val=0
    fi
  else
    if [ "${dbname}" = "${deployment_db}" ]
    then
      return_val=0
    else
      return_val=1
    fi
  fi

  unset _deployment_type

  return ${return_val}
}
