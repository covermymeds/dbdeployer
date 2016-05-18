function deploy_file() {
  _db_to_deploy="${1}"
  _deploy_file="${2}"
    if ! [ -z "${3}" ]
  then
    _logfile="${3}"
  fi

  #create a temp file to hold the concatenate of the pre_deploy, deploy and post_deploy files
  tmpfile="/tmp/tmp_${filename}"

  cat "${fn_basedir}"/dbtype/"${dbtype}"/pre_deploy.sql > "${tmpfile}"

  cat "${_deploy_file}" >> "${tmpfile}"

  #Check if a procedure, if so add GO to the post_deploy

  if grep -qwi "procedure\|function\|trigger" "${tmpfile}"
  then
       echo  >> "${tmpfile}"
       echo " GO " >> "${tmpfile}"

  fi

  cat "${fn_basedir}"/dbtype/"${dbtype}"/post_deploy.sql >> "${tmpfile}"

  _date_start=$(date -u +"%s")

  deploy_output=$(${db_binary} -d ${_db_to_deploy} ${server_flag}${port_flag} ${user_flag} ${password_flag} -l0 -h -1 -e -b -i "${tmpfile}")

  rc=$?

  _date_end=$(date -u +"%s")

  _script_duration=$(($_date_end-$_date_start))
  rm -f "${tmpfile}"

  echo "${deploy_output}"
  echo "Script duration $(($_script_duration / 60)) minutes and $(($_script_duration % 60)) seconds."

  if ! [ -z "${_logfile}" ]
  then
    echo "${deploy_output}" >> "${_logfile}"
  fi

  if [[ $deploy_output == *"SqlState 24000, Invalid cursor state"* ]]
  then
    echo
    echo "File failed to deploy within a transaction.  This is most likely due to a bug in the Linux SQLCMD utility.  You can attempt to deploy the file manually using the following command.";
    echo ${db_binary} -d ${_db_to_deploy} ${server_flag}${port_flag} ${user_flag} ${password_flag} -h -1 -e -b -i "$_deploy_file"
    rc=1

  fi

  unset _db_to_deploy
  unset _deploy_file

  if [ ${rc} -eq 0 ]
  then
    return 0
  else
    return 1
  fi
}
