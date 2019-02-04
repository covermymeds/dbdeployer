#!/usr/bin/env bash
function exec_post_deploy_script() {

  _script_to_exec="$1"

  # database name will automatically be passed to script with -d flag

  echo "Executing script post dbdeployer run: ${_script_to_exec} -d ${dbname} -n ${db_destination_name}"
  script_result=`$_script_to_exec -d $dbname -n ${db_destination_name}`

  if [ $? -ne 0 ]
  then
    echo "Failed to execute script: ${_script_to_exec}"
    rc=1
  else
    rc=0
  fi

  echo -e $script_result

  unset script_result
  unset _script_to_exec
  return $rc
}
