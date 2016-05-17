db_report_string() {
  _deployment_type="$1"
  _include_checksum="$2"

  deployment_tracker_table_exists

  if [ "${_include_checksum}" = 'true' ]
  then
    checksum_value=" + '--dbdeployer-md5sum--' + checksum"
  else
    checksum_value=''
  fi

  if [ $? -eq 0 ]
  then
    ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -l0 -h -1 -b -Q "
    SET NOCOUNT ON;
    SELECT '${db_basedir}/' + '${dbname}' + '/' + deployment_type + '/' + deployment_name${checksum_value}
    FROM deployment_tracker
    WHERE dbname = '${db_destination_name}'
    AND isnull(is_active, 1)=1
    AND deployment_type = '${_deployment_type}'
    AND deployment_outcome in ('OK','SKIP');" | sort -rn

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
