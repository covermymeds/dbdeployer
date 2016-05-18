#!/usr/bin/env bash
###############################################################################
# This is the global defaults file. Changes here apply to all users
#
# If enabled, you can override this file by using the same variable names in  
# the "~/.dbdeployer" file in your home directory.
###############################################################################

#set the bash format of how you want your timestamps to appear in log files
timestamp=$(date)

#name of the database where deployments are tracked
deployment_db='deployments'

#log directory
log_dir='/var/log/dbdeployer'

#displays values that are used for most of the functions for troubleshooting
verbose='false'

#the script asks questions when you do something dangerous like drop a database,
#redeploy the same script, or try to create a new database.  If set to true
#it will not prompt you for your answer and will always assume yes
confirm='false'

#this must match one of the folders in /usr/libexec/dbdeployer/dbtype. The
#value of this variable decides which functions should be loaded.
dbtype='postgres'

#In test environments it can be nice to drop the database and reload it to a
#known good state. This is obviously dangerous in a production environment
#so we have disabled that feature by default.
allow_drop_and_reload='false'

#This is the location where we should look for database folders.  The 
#specified path out of the box is the recommended location, however it may
#need permissions adjusted to be writeable by your deployment user. 
db_basedir='/var/lib/dbdeployer/databases'

#this is where the functions are deployed by default.  If you want to move
#them somewhere else for whatever reason, you can update the path here
fn_basedir='/usr/libexec/dbdeployer'

#user to make sure the script is being run as
run_as='postgres'

#path variable should include the path to the db_binary.  Uncomment and add path 
#as colon delimited list if your db_binary is not in your users path
#PATH=$PATH

#declare the awk variable that the filename resides in when you list the directories
#On my mac, this is 1, on my rhel systems its 8.  You can see by running the below command
# ls -o1 ${dbname}/${i}/*.sql and counting as a space delimited set.  You can verify
#you have the correct value by piping output to awk with the below line
# | awk {'print ${deployment_report_argnum}'}
deployment_report_argnum='$8'

#uncomment and specify the environment you would like to automatically assume.
#Environments can be used to identify files that are different for each environment
#or that that should only be deployed to a single environment. Environments are
#created by creating folders inside of any of the database change tracking folders.
#environment=prod

#regex to use when deciding a valid database name. Below specifies that it should be
#alphanumeric, allow for spaces underscores, and dashes, and be less than 128 chars
dbname_regex='[[:alnum:][:space:]_\-]{0,127}'

#regex to parse for a valid URL (used for reference url)
url_regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

#folders to be considered as requirements for deployment files.
#List in order they should be deployed
deployment_folders='schema:|seed:|changes'

#whether or not to include auto_deploy_folders in the report for deployment
auto_deploy_folders_enabled='false'

#folders that will include files in report when changes are found based on checksum
#Requires calculate_checksum option to be set to true. These folders are deployed
#after the list of deployment_folders.
auto_deploy_folders='sprocs:|functions:|utility'

#environment exclusion list (add folders inside database dir that aren't environments)
env_exclude="/:|output:|archive:|rollback:|grants:|thesaurus"

#allows global file to be overridden by users ~/.dbdeployer file
allow_config_override='true'

#calculates the checksum of files and stores in the database. This is required to be
#true for the autodeploy directory to work 
calculate_checksum='true'

#key:value pairs to replace in sql files prior to deploying. Must be expressed with
#a colon as the separator for key/value and multiple replaces can be done with a 
#comma separated list.
#example: variables_to_replace='$(key1):value1,$(key2):value2,$(key3),value3'
variables_to_replace=''
