#!/bin/bash
function drop_database() {

  _dbname="$1"

  ${db_binary} -d ${deployment_db} ${server_flag}${port_flag} ${user_flag} ${password_flag} -Q "
  ALTER DATABASE [${_dbname}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE [${_dbname}]; 
  " > /dev/null 2>&1
  if [ $? -ne 0 ] 
  then
    return 1
  fi

  unset _dbname
  return 0
}
