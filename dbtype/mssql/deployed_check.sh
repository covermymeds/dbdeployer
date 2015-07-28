function deployed_check() {
  if [ `${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -h -1 -b -Q "SET NOCOUNT ON; select coalesce ((select count(*) from deployment_tracker t
  where dbname = '${dbname}'
  and ( deployment_outcome = 'OK' OR deployment_outcome = 'SKIP' )
  and deployment_type = '${change_type}'
  and deployment_name = '${filename}'
  and isnull(is_active, 0)=1
  group by deployment_name), 0 );" | xargs` -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
