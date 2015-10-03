#!/usr/bin/env bash
function usage() {
  echo "${script_name} [options] 
  -A|--run-as [run-as-user]       Verifies that specified user is running script
                                    (default: postgres)
  -c|--confirm                    No arguments, automatically confirms choices 
                                    without user interaction
  -d|--database [name]            Database name to work with (will attempt to 
                                    auto-discover if -f is used, but can be 
                                    overwritten by using this variable)
  -D|--database-dir [directory]   Directory to deploy databases from
                                    (default /var/lib/dbdeployer)
  -e|--environment [environment]  Environment to use 
                                    (if environments exist in command tree)
  -f|--file [filename]            Filename to be deployed 
                                    (requires path from ${script_name} script)
  -k|--skip                       Causes deployment to be skipped but file is
                                    still written to deployment_tracker
                                    (can be used if file was deployed by a
                                    different machanism)
  -p|--port [port]                Database port to connect on.  (requires -s|server
                                    to be specified)
  -P|--password [password]        Database password to use.  (requires -U|username
                                    to be specified)
  -r|--report                     No argument, show report of what needs 
                                    deployed (requires -d to be specified)
  -R|--change-control '[URL]'     This will log a reference URL.  Please include 
                                    single quotes around the URL.  Field is restricted
                                    to 255 characters. Recommended uses for this 
                                    option include link to version control or change
                                    control ticket. 
                                    (if used with -r flag option is validated but ignored)
                                    (if used with -u flag, will log for all deployed files)  
  -s|--server [host/ip]           Server name or IP address
  -T|--dbtype [type]              Database type defined from folders in:
                                    ${fn_basedir}/dbtype
  -U|--username [username]        Username to connect to the database as
  -u|--update                     No argument, requires database to be specified
                                    and will run all commands to bring a 
                                    database to current.  Ultimately runs report 
                                    and executes findings
  -v|--verbose                    No argument, shows what the variables are that
                                    are being used at time of deployment
  -X|--drop-and-reload            No argument, please note this is a destructive change. 
                                    This will drop the database specified and will rebuild 
                                    from scripts in the same way a freshly stood up database 
                                    is deployed. Can be useful in dev/test environments
                                    (requires -d flag)
                                    (not compatible with -r|report flag)
                                    (not compatible with -k|skip flag) 
                                    (cannot be used with deployment tracking database)
  -h|--help                       Show this help message
  "
}
