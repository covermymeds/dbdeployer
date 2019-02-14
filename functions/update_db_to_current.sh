#!/usr/bin/env bash
function update_db_to_current() {

  _dbname="$1"
  _db_destination_name="$2"

  #echo "report_var executes: ${script_name} ${run_as_cli} -D ${db_basedir} -r -d \"${_dbname}\" -n \"${_db_destination_name}\" ${environment_flag} ${server_cli} ${port_cli} ${dbuser_cli} ${password_cli} ${skip_cli} ${dbtype_cli} ${module_list_cli} | grep \"${script_name} -f\""

  report_var=`${script_name} ${run_as_cli} -D ${db_basedir} -r -d "${_dbname}" -n "${_db_destination_name}" ${environment_flag} ${server_cli} ${port_cli} ${dbuser_cli} ${password_cli} ${skip_cli} ${dbtype_cli} ${module_list_cli} | grep "${script_name} -f"`
  local IFS=$'\n'
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
  unset _db_destination_name
  return 0
}
