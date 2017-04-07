#!/usr/bin/env bash
db_report_string() {
  _deployment_type="${1}"
  _include_checksum="${2}"
  _is_autodeploy="${3}"

  deployment_tracker_table_exists

  if [ "${_include_checksum}" = 'true' ]
  then
    checksum_value=",'--dbdeployer-md5sum--',checksum"
  else
    checksum_value=''
  fi

  if [ $? -eq 0 ]
  then

    _sqlstring="
    SELECT CONCAT('${db_basedir}/','${dbname}','/',deployment_type,'/',deployment_name${checksum_value}) 
    FROM deployment_tracker 
    WHERE dbname = '${db_destination_name}' 
    AND deployment_type = '${_deployment_type}' 
    AND deployment_outcome in ('OK','SKIP')
    AND (
      is_active is true
    "

    if [[ "${auto_deploy_folders_enabled}" = 'true' && "${is_auto_deploy}" = 'true' ]]
    then
      _sqlstring="${_sqlstring}
      OR·
        deployment_type IN ('${_deployment_type}')
      "
    fi
    _sqlstring="${_sqlstring}
    );
    "

    ${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -N -s --skip-pager -e "
    ${_sqlstring}" | sort -rn
    
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
