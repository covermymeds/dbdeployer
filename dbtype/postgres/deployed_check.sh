#!/usr/bin/env bash
function deployed_check() {
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
}
