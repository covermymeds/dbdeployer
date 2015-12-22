## 201?-??-?? Release 1.0.3
### Summary
Added checksum log to db

### Changes
  - Added checksum logging and options to postgres and mssql
  - Added label to indicate database in warning message for drop and reload


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

