#!/usr/bin/env bash

error_state='false'                                           #initialize error state
package_name='dbdeployer'                                     #name of package/folder to reference
package_base_data_dir='/var/lib'                              #location to install data dir
package_data_dir="${package_base_data_dir}/${package_name}"   #full path to data dir
package_database_dir="${package_data_dir}/databases"          #default path for user databases
bin_dir='/usr/bin'                                            #location to install binary
config_base_dir='/etc'                                        #location to install config dir
config_dir="${config_base_dir}/${package_name}"               #full path to config dir
function_base_dir='/usr/libexec'                              #location to install functions dir
function_dir="${function_base_dir}/${package_name}"           #full path to functions dir
log_dir="/var/log/${package_name}"                            #default log location
user_name='dbdeployer'                                        #name of user to deploy
user_home_dir="$package_data_dir"                             #user home directory
group_name='dbdeployer'                                       #name of the group (used for log file permission)



BASEDIR=$(dirname $0)
cd $BASEDIR

#verify suitable user to install (root)
if [ `whoami` != 'root' ]
then
  echo "Must be root to run install"
  error_state='true'
fi

#verify directories exist
for x in dbtype dbtype/postgres 'functions' sample_structure deployments ${bin_dir} ${config_base_dir} ${function_base_dir} ${package_base_data_dir}
do
  if ! [ -d "${x}" ]
  then
    echo "Directory ${x} was not found"
    error_state='true'
  fi
done

#verify files exist
for x in dbdeployer config.sh dbdeployer_release
do
  if ! [ -f "${x}" ]
  then
    echo "File ${x} was not found"
    error_state='true'
  fi
done

#check error_state and exit if true
if [ ${error_state} = 'true' ]
then
  echo "Errors were found in the pre-check, exiting"
  exit 1
fi

#create user
if [ `grep "^${user_name}:" /etc/passwd | wc -l` -eq 0 ]
then
  useradd -r -g ${group_name} -m -d ${user_home_dir} ${user_name}
  if [ $? -ne 0 ]
  then
    echo "Failed to add user ${user_name} to system, exiting"
    exit 1
  fi #end error check
fi

#make necessary directories on filesystem
for x in ${config_dir} ${function_dir} ${package_data_dir} ${package_database_dir} ${log_dir}
do
  if ! [ -d ${x} ]
  then
    mkdir ${x}
    if [ $? -ne 0 ]
    then
      echo "Failed to create directory '${x}', exiting"
      exit 1
    fi #end error check
  fi #end directory exists check
done

#copy config file
#if ! [ -f ${config_dir}/config.sh ]
#then
  cp config.sh ${config_dir}
  if [ $? -ne 0 ]
  then
    echo "Failed to copy config file, exiting"
    exit 1
  fi #end error check
#fi #end config file exists

#copy version file
cp dbdeployer_release ${config_dir}
if [ $? -ne 0 ]
then
  echo "Failed to copy version file, exiting"
  exit 1
fi #end error check

#copy executable file
cp dbdeployer ${bin_dir}
if [ $? -ne 0 ]
then
  echo "Failed to copy executable file, exiting"
  exit 1
fi #end error check

#copy functions directory
cp -R 'functions' ${function_dir}
if [ $? -ne 0 ]
then
  echo "Failed to copy functions directory, exiting"
  exit 1
fi #end error check

#copy dbtype functions directory
cp -R dbtype ${function_dir}
if [ $? -ne 0 ]
then
  echo "Failed to copy dbtype functions directory, exiting"
  exit 1
fi #end error check

#copy sample_structure directory
cp -R sample_structure ${package_data_dir}
if [ $? -ne 0 ]
then
  echo "Failed to copy sample_structure directory, exiting"
  exit 1
fi #end error check

#copy deployments directory
cp -R deployments ${package_data_dir}
if [ $? -ne 0 ]
then
  echo "Failed to copy deployments directory, exiting"
  exit 1
fi #end error check

#set permissions on log_dir
chown root:${group_name} ${log_dir}
if [ $? -ne 0 ]
then
  echo "Failed to set ownership of log directory, exiting"
  exit 1
fi #end error check
chmod 775 ${log_dir}
if [ $? -ne 0 ]
then
  echo "Failed to set permission on log directory, exiting"
  exit 1
fi #end error check

#installation is complete
echo "Installation has completed successfully."

#warn that they will have to add users to the dbdeployer group before deploying files
echo "Please add any users that will be deploying files to the 'dbdeployer' group."
echo "Can be done with this command on RHEL systems: usermod -aG dbdeployer [username]"
