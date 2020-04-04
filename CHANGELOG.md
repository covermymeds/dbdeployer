## 2020-04-3 Release 1.5.7
### Summary
Bug fix

### Changes
  - fix bug with full path not displaying in some cases for deploy file in auto deploy folders
  - fix bug that caused confirm flag to not pass through in some cases

## 2020-02-10 Release 1.5.6
### Summary
Bug fix, minor new features

### Changes
  - fix bug that prevented auto deploy folders from working with environment overrides
  - fix bug in git plugin for auto deploy folders to allow environment overrides
  - give warning on git plugin when branch is behind master to avoid orphan changes from showing up
  - validate that files exist in git plugin. Things in master would show up as file not found when comparing branch
  - add --check-pending which gives a 0 or 1 return code if files need deployed

## 2019-02-14 Release 1.5.5
### Summary
Add cli override for parameters,fix run as implementation

### Changes
  - add override for the --allow-drop-databases command option
  - fix run as implementation to pass through to forked processes

## 2019-02-12 Release 1.5.4
### Summary
Add disable feature for plugins

### Changes
  - Flag to disable any plugins that are inherited via config

## 2019-02-12 Release 1.5.3
### Summary
Bug Fix

### Changes
  - Fix bug in git plugin allowing for proper execution of environment folders

## 2019-02-08 Release 1.5.2
### Summary
Add git binary to image and add version flag

### Changes
  - Added git to the docker file as a dependency to support the git plugin
  - Added version to help output

## 2019-02-01 Release 1.5.1
### Summary
Bug Fix, added post deployment script execution

### Changes
  - Fix issue when not in git checkoiut location using git plugin
  - Added --post-deploy-script option to exec arbitrary script at end of run
    - This passes `-d $dbname` and `-n $db_destination_name` to script passed in

## 2019-01-09 Release 1.4.2
### Summary
Auto deploy folder bug fix

### Changes
  - Fix pathing issue when using auto deploy folders

## 2018-09-24 Release 1.4.1
### Summary
Encryption, Remote Deploy, code cleanup

### Changes
  - MSSQL and Postgres can now enforce that they only connect with encryption
  - PSQL can now remote deploy with user/pass/host settings in the same way
  that mssql does.
  - Clean up and localize IFS usage in various files
  - Add containerization features for docker

## 2016-05-18 Release 1.3.1
### Summary
Add plugin support and Git plugin

### Changes
  - Added plugin functionality
  - Added plugin for Git
  - Adjusted the way auto deploy folders work in db_report_string dbtype functions
  - Auto deploy will not redeploy a file from master automatically if it has had a checksum that has been deployed in the past (this protects a situation where an environment is ahead of master, you can force a deploy of an auto deploy file still by using the -f flag with the path to the file).

## 2016-05-18 Release 1.2.1
### Summary
Bug fix

### Changes
  - Quoted variables to ensure negative test compares correctly for checksum and auto deploy folders

## 2016-05-18 Release 1.2.0
### Summary
Lots of new features and bug fixes

### Changes
  - BREAKING CHANGE: Changed the variable name for `allow_drop_and_reload` to `allow_drop_database`
  - BREAKING CHANGE: Created `dbdeployer` group with installer that has permissions to log directory. You will need to add users to this group or adjust permissions on the log directory
  - Added ability to drop the desired database or destination database without doing a reload (useful for dev and ci environments, or decommissioning production databases)
  - Moved logging to /var/log/dbdeployer (configurable via config file)
  - Added support for MySQL!
  - Removed hard coded values for ping server check and enabled them to be configured in config file
  - Changed logging to not include the change type as part of the folder structure for log file. This allows rollbacks of a migration to be seen in the same file migration was deployed from (if deploying rollbacks from the rollback directory)
  - Changed mssql dbtype to disable the connection timeout. Default was 8 seconds before
  - Migrated existing variable replace in mssql to global function. Available to all dbtypes now based on config variable set of key:value pairs (available on the command line as well)
  - auto_deploy_folders_enabled option was added with a default value of false to resolve https://github.com/covermymeds/dbdeployer/issues/34. More work to other items mentioned in this issue will come in the future.


## 2016-02-08 Release 1.1.1
### Summary
Moved location of functionality

### Changes
  - Removed concatonation piece from variable env_exclude in config file and made it merge the pieces together in the program itself.


## 2015-12-30 Release 1.1.0
### Summary
New features added

### Changes
  - BREAKING CHANGE: Changed the field separator for deployment_folders to be `:|` instead of just `:`
  - Added config var for `auto_deploy_folders` that uses checksums to decide if files in those folders need re-deployed. This is dependent upon the `calculate_checksum` variable being set to true.
  - Added checksum logging and options to postgres and mssql
  - Added label to indicate database in warning message for drop and reload
  - Added global config variable to optionally disable user config files


## 2015-12-09 Release 1.0.2
### Summary
New features added, bugfix

### Changes
  - Added deployment target database name allowing a database folder to be deployed to a name other than the database folder name. i.e, a database name of mydatabase can be deployed to a database name of mydatabase_test
  - Fix issue where newline was needed before a go statement in sql server
  - Changed the way mssql wraps transactions to stitch together a single file instead of deploy with multiple files through sqlcmd. This fixes most cases where sqlcmd fails to deploy items inside a transaction. If the transaction fails to deploy dbdeployer will ask if you would like to deploy the file outside of a transaction.
  - Build in mechanism to allow dbname to be substitued in mssql files in the event that the script needs to reference the database name.
  - Fixed bug that caused reference urls to not be logged correctly
  - Fixed bug in creation of deployments database for dbdeployer for mssql
  - Added ability to specify dbtype on the command line instead of only in the config file(s)

