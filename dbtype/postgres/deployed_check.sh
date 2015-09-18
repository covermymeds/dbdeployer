#!/usr/bin/env bash
function deployed_check() {

  deployment_tracker_table_exists

  if [ $? -eq 0 ]
  then

    if [ `${db_binary} ${deployment_db} ${server_flag} ${user_flag} ${port_flag} -1 -X -q -t -c "
    select coalesce ((select count(*) from deployment_tracker t
    where dbname = '${dbname}' 
    and ( deployment_outcome = 'OK' OR deployment_outcome = 'SKIP' )
    and deployment_type = '${change_type}'
    and deployment_name = '${filename}'
    and is_active is true
    group by deployment_name), 0 );" | xargs` -eq 0 ]
    then
      return 0
    else
      return 1
    fi
  elif [ ${dbname} = ${deployment_db} ]
  then
    #returning 0 because the deployments database needs to be able to install itself
    #and we don't want the script to exit if the table doesn't exist when deploying
    #the deployments databse
    return 0
  else
    return 2
  fi
}
