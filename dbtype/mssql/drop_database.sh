#!/bin/bash
function drop_database() {

  _drop_dbname="$1"

  ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -l0 -Q "
  ALTER DATABASE [${_drop_dbname}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [${_drop_dbname}]; 
  " > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset _drop_dbname
  return 0
}
