#!/usr/bin/env bash
function update_db_to_current() {

  _dbname="$1"

  report_var=`${script_name} -D ${db_basedir} -r -d "${dbname}" ${environment_flag} ${server_cli} ${port_cli} ${dbuser_cli} ${password_cli} ${skip_cli} | grep "${script_name} -f"`
  IFS=$'\n'
  for j in `echo -e "${report_var}"`
  do
    echo "Running: ${j}"
    eval ${j}
    rc=$?
    if [ ${rc} -ne 0 ]
    then
      if ! [ -z ${verbose} ]
      then
      echo "Failed Call: ${j}"
      fi
      return 1
    fi
  done



  unset _dbname
  return 0
}
