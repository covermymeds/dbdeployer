function create_database() {
  _createdb=$1
  ${db_binary} ${server_flag} ${port_flag} ${user_flag} ${password_flag} -b -Q "create database [${_createdb}];"
  rc=$?
  unset _createdb
  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    echo "Error creating the database, exiting"
    return 1
  fi
}
