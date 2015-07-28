db_report_string() {
  _deployment_type="$1"

  ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -h -1 -b -Q "
  SET NOCOUNT ON;
  SELECT '${db_basedir}/' + dbname + '/' + deployment_type + '/' + deployment_name
  FROM deployment_tracker
  WHERE dbname = '${dbname}'
  AND isnull(is_active, 0)=1
  AND deployment_type = '${_deployment_type}'
  AND deployment_outcome in ('OK','SKIP');" | sort -rn

  if [ $? -ne 0 ]
  then
    return_val=1
  else
    return_val=0
  fi
  unset _deployment_type

  return ${return_val}
}
