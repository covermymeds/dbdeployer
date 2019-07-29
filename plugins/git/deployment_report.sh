#!/usr/bin/env bash
unset deployment_report

# variables for git-plugin
branch_to_compare="${branch_to_compare:-origin/master}"

deployment_report() {
  #standard deploy folders
  echo "Running report for database: ${db_destination_name}"
  IFS=':|' read -a folder_list <<< "${deployment_folders}"

  #ensure we are in the directory where the checkout occurs since we will be using git
  cd ${db_basedir}

  for i in ${folder_list[@]}
  do
    echo "Differences for ${i}:"
    DB=`eval "db_report_string '${i}'"`
    #echo "DB: ${DB}"

    if [ `ls "${db_basedir}"/"${dbname}"/"${i}"/ | grep ".sql" | wc -l | xargs` -gt 0 ]
    then
      if [ "`git rev-parse --abbrev-ref --symbolic-full-name @{u}`" = "${branch_to_compare}" ]
      then
        # on master, compare from file system
        FS=`eval "ls -o1 "${db_basedir}"/"${dbname}"/"${i}"/*.sql | awk {'print ${deployment_report_argnum}'} | sort -rn"`
      else
        diff_files=`git diff --name-status ${branch_to_compare} | grep -E '^A|^M' | awk {'print \$2'} | grep "^${dbname}/${i}/[^/]*\.sql$" | xargs`

        #echo "diff_file: ${diff_files}"

        for x in ${diff_files}
        do
          trim_x=`echo $x`
          FS=`echo -e "${FS}\n${db_basedir}/${trim_x}\n"`

        done
      fi

    else
      FS=''
    fi

    #echo -e "FS: \n${FS}"

    #diff -B -b <(echo "${DB}" | sort -n) <(echo "${FS}" | sort -n) | sort -n
    for x in `diff -B -b <(echo "${DB}" | sort -n) <(echo "${FS}" | sort -n) | grep ">" | grep '.sql' | sed 's/^..//' | sort -n | xargs`
    do
      if ! [ -z "${x}" ]
      then
        echo "${script_name} -f "${x}" -n "${db_destination_name}" ${run_as_cli} ${environment_flag} ${server_cli} ${port_cli} ${dbuser_cli} ${password_cli} ${skip_cli} ${dbtype_cli}"
      fi
    done
  done

  # auto deploy folders
  if [ "${auto_deploy_folders_enabled}" = 'true' ]
  then

    if [ "${calculate_checksum}" = 'true' ] 
    then
      IFS=':|' read -a auto_deploy_folder_list <<< "${auto_deploy_folders}"
      for i in ${auto_deploy_folder_list[@]}
      do
        DB='' #clear variable from earlier runs
        FS='' #clear variable from earlier runs
        deploy_folder="${db_basedir}/${dbname}/${i}"

        if [ -d "${deploy_folder}" ]
        then
          echo "Differences for ${i}:"
          DB=`eval "db_report_string '${i}' 'true' 'true'"`


          if [ `ls "${deploy_folder}"/ | grep ".sql" | wc -l | xargs` -gt 0 ]
          then
            FS_CHECKSUM='' #initialize empty var
            if [ "`git rev-parse --abbrev-ref --symbolic-full-name @{u}`" = "${branch_to_compare}" ]
            then
              FS_LIST=`eval "ls -o1 "${deploy_folder}"/*.sql | awk {'print ${deployment_report_argnum}'} | sort -rn | xargs"`

              for j in ${FS_LIST}
              do
                # echo "file: $j"
                FS_CHECKSUM=`md5sum "${j}" | awk {'print $1'}`
                # echo "FS_CHECKSUM: $FS_CHECKSUM"
                FS=`echo -e "${FS}\n$j--dbdeployer-md5sum--$FS_CHECKSUM"`
              done
            else
              FS_LIST=`eval "git diff --name-only ${branch_to_compare} | grep \"^${dbname}/${i}/\" | grep '.sql' | xargs"`
              for j in ${FS_LIST}
              do
                # echo "file: $j"
                FS_CHECKSUM=`md5sum "${j}" | awk {'print $1'}`
                # echo "FS_CHECKSUM: $FS_CHECKSUM"
                FS=`echo -e "${FS}\n${db_basedir}/$j--dbdeployer-md5sum--$FS_CHECKSUM"`
              done
            fi


          else
            FS=''
          fi

  #    echo "DB: $DB"
  #    echo "FS: $FS"


          for x in `diff -B -b <(echo "${DB}" | sort -n) <(echo "${FS}" | sort -n) | grep ">" | grep '.sql' | sed 's/^..//' | sort -n | xargs`
          do
            if ! [ -z "${x}" ]
            then
              auto_deploy_file=`echo ${x} | awk -F '--dbdeployer-md5sum--' {'print $1'}`
              echo "${script_name} -f "${auto_deploy_file}" -c -n "${db_destination_name}" ${run_as_cli} ${environment_flag} ${server_cli} ${port_cli} ${dbuser_cli} ${password_cli} ${skip_cli} ${dbtype_cli}"
            fi
          done
        fi #end directory exists check
      done
    fi #end calculate_checksum check
  fi #end auto deploy folders enabled

  echo "Provided by git plugin"
}
