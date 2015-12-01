#!/usr/bin/env bash
deployment_report() {
  echo "Running report for database: ${db_destination_name}"
  IFS='|' read -a folder_list <<< "${deployment_folders}"
  for i in ${folder_list[@]}
  do
    echo "Differences for ${i}:"
    DB=`eval "db_report_string '${i}'"`


    if [ `ls "${db_basedir}"/"${dbname}"/"${i}"/ | grep ".sql" | wc -l | xargs` -gt 0 ]
    then
      FS=`eval "ls -o1 "${db_basedir}"/"${dbname}"/"${i}"/*.sql | awk {'print ${deployment_report_argnum}'} | sort -rn"`
    else
      FS=''
    fi

    for x in `diff -B -b <(echo "${DB}") <(echo "${FS}") | grep ">" | grep '.sql' | sed 's/^..//' | sort -n | xargs`
    do
      if ! [ -z "${x}" ]
      then
        echo "${script_name} -f "${x}" -n "${db_destination_name}" ${run_as_user_flag} ${environment_flag} ${server_cli} ${port_cli} ${dbuser_cli} ${password_cli} ${skip_cli} ${dbtype_cli}"
      fi
    done
  done
}
