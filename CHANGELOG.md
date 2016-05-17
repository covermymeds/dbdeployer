## 2016-02-19 Release 1.1.2
### Summary
Added option to disable auto deploy folders

### Changes
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

