function show_deployments() {
  echo "This deployment was already found in the database with an OK status."
  echo "Below are all deployments for this file.  Please investigate."
  ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -h -1 -b -Q "select * from deployment_tracker t
  where dbname = '${db_destination_name}'
  and ( deployment_outcome = 'OK' OR deployment_outcome = 'SKIP' )
  and deployment_type = '${change_type}'
  and deployment_name = '${filename}';"

  if [ $? -ne 0 ]
  then
    return 1
  else
    return 0
  fi
}
