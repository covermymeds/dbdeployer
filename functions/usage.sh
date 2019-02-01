#!/usr/bin/env bash
function usage() {
  echo "${script_name} [options] 
  -A|--run-as [run-as-user]       Verifies that specified user is running script
                                    (default: postgres)
  -a|--auto-deploy-enabled        Enables folders specified in auto_deploy_folders
                                    to show up in deployment report and updates
                                    based on changes in checksum
                                    (default: disabled)
  -c|--confirm                    No arguments, automatically confirms choices 
                                    without user interaction
  -C|--checksum-off               No arguments, turns off checksum logging

  --disable-ping-check            No arguments, turns off ping check when server
                                    flag is in use
  -d|--database [name]            Database name to work with (will attempt to 
                                    auto-discover if -f is used, but can be 
                                    overwritten by using this variable)
  -D|--database-dir [directory]   Directory to deploy databases from
                                    (default /var/lib/dbdeployer)
  -e|--environment [environment]  Environment to use
                                    (if environments exist in command tree)
  -E|--force-encryption           Forces tls to be used with connection
                                    (default false)
  -f|--file [filename]            Filename to be deployed 
                                    (requires path from ${script_name} script)
  -k|--skip                       Causes deployment to be skipped but file is
                                    still written to deployment_tracker
                                    (can be used if file was deployed by a
                                    different machanism)
  -m|--module-list                Module or plugin directories to load. Should be a
                                    comma seperated list. List module specified last
                                    will be applied for functions that are redundant in
                                    module list (example: git,report_override)
  -n|--db-destination-name [name] Deploy a database (-d) to a specific destination db,
                                    useful for when the source name does not match the
                                    final name of the database to be created.
                                    ex. determinator -> determinator_test
  -o|--variables_to_replace '[key:value,key2:value]' This is a key/value pair where the
                                    key and value are separated by a ':'. Multiple sets
                                    can be specified by separating by comma's. If
                                    variable-override is enabled this will use the 'sed'
                                    command to find/replace values
  -p|--port [port]                Database port to connect on.  (requires -s|server
                                    to be specified)
  --post-deploy-script [script]   Can be a script name or command. This is run with
                                    'exec' after the update command completes.
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
  -x|--drop-database              No argument, please note this is a desctructive change.
                                    This will drop the database specified
                                    (requires -d|--database to be specified)
                                    (not compatible with -r|report flag)
                                    (not compatible with -k|skip flag)
                                    (cannot be used with deployment tracking database)
                                    (can optionally include the -n|--db-destination-name)
  -X|--drop-and-reload            No argument, please note this is a destructive change. 
                                    This will drop the database specified and will rebuild 
                                    from scripts in the same way a freshly stood up database 
                                    is deployed. Can be useful in dev/test environments
                                    (requires -d|--database to be specified)
                                    (not compatible with -r|report flag)
                                    (not compatible with -k|skip flag) 
                                    (cannot be used with deployment tracking database)
                                    (can optionally include the -n|--db-destination-name)
  -h|--help                       Show this help message
  "
}
