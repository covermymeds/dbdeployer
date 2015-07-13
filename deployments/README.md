
Please reference the below sections for usage and naming patterns
1. Schema
2. Seed Data
3. Changes
4. Rollback
5. Baselining sql
6. Archive Directory


################################################################################
# 1. Schema
################################################################################

This folder should contain the entire schema for the database.  Files should be
preceeded with a numerical value starting with 1000 and increment by 1000 as
applicable if more than one file needs to be referenced to instantiate the 
schema.  

In the event we come up with a file that should be executed between existing 
files, then pick the number in thbe middle of the two scripts surrounding the
new script.  For example.  if I have script 1000.sql which executes first, and
script 2000.sql that executes second and I want to add something that executes
between those two files, but for logistical reasons should remain separate
and not get merged to the end or beginning of one of those files, then that file
should be named 1500.sql.

Ideally there is only one sql file that exists and gets called, but if there 
was a desire to break up schema, stored procedures/functions, triggers, etc
a multi-file system can handle this approach.  

################################################################################
# 2. Seed data
################################################################################

This folder should contain the all seed data for the database.  Files should be
preceeded with a numerical value starting with 1000 and increment by 1000 as
applicable if more than one file needs to be referenced to instantiate the
schema.

In the event we come up with a file that should be executed between existing
files, then pick the number in thbe middle of the two scripts surrounding the
new script.  For example.  if I have script 1000.sql which executes first, and
script 2000.sql that executes second and I want to add something that executes
between those two files, but for logistical reasons should remain separate
and not get merged to the end or beginning of one of those files, then that file
should be named 1500.sql.

Ideally there is only one sql file that exists and gets called, but if there
was a desire to break up schema, stored procedures/functions, triggers, etc
a multi-file system can handle this approach.

There may be some situations where data can be loaded faster via csv's than
from direct insert queries.  Only sql files will be executed in this folder,
but those files can reference other files with the various database load 
data commands.
################################################################################
# 3. Changes
################################################################################


This folder should contain updates or changes to the schema 
and seed data forthe database.  Multiple changes can be in a 
single file, but all changes must be additive.  This means 
that there is never a rollback and redeploy.  A rollback 
would be executed as an update, and the re-deployment as yet
another update. Rollbacks should still be created for 
changes written and should be stored in the rollbacks directory
even though if they are used they will be added into the 
changes directory as a new file.

Deploying updates in an additive fashion allows any developer
to check out the database and not worry about their checkout
being invalidated.

Files here should be named with the date in format:
YYYYMMDD-[XX-][description_of_change].sql

where YYYY is the 4 digit year, MM is the 2 digit month, DD is
the 2 digit day

XX- is an optional argument that can be used if there are more than
one script associated with a change.  The numbers should be incrmental
ordering the scripts in an alpha sort. 

The description should not have any spaces in it.  Instead underscores 
should be used.

When changes are baselined, they are moved to the archive
direcotry and their contents are merged into the correct schema 
or seed data file.

################################################################################
# 4. Rollback
################################################################################

Most changes should contain a rollback.  Some exceptions may be 
made to this, such as when you use a rollback, the rollback of a 
rollback is the original change.  There may also be pre-approved
changes that are so standard or reference stored proceedures that
a rolback is not required.

Rollback's should be named the same as the file they are referencing
in the changes directory.


################################################################################
# 5. Baselining sql
################################################################################

When a number of changes have accrued and it become harder to apply
changes than it would be to just start over, we can baseline.

When a file is baselined it's contents should be merged to the schema file or
seed data file that best represents the content.  The file itself should then
be moved to the archive folder for the database.

Anyone on an old version of the checked out database should be able to apply
things that are newer than its newest "change" in the archive folder as well
as all all items in the changes folder to get back to current.

New checkouts by default will be current as the changes are included in the new
baseline or schema scripts used.  

By archiving files in this way it allows us to not have to merge all items in 
changes to the baseline and schema at a single time.  We can merge maybe 30 of
50 changes in a git branch and then merge to master while not worrying about
users abililty to come back up to date.


################################################################################
# 6. Archive Directory
################################################################################

As part of the process of baselining, files will be migrated to the archive
directory.  I suppose over time we may want to purge files from the archive.  
There is no automated method to do this.  Before purging I would make sure that
all instances and developers are up to date before permanently removing files
from here.  

Personally I think items older than 12 months may be good to purge to keep the 
directory size smaller.  We are using a versioning control system, so the files
are nevery actually gone.  Purging is done to make the directory not
overwhelming to look through from a human perspective as well as to not allow
so many files that the file system may begin to have trouble listing the 
directory.


################################################################################
# 7. Environment Handling
################################################################################

There will be some changes where data will be different between environments.
Currently we are lucky enough to either not have any, or not have identified
scenarios within our application that this happens.  There are a few that I
have encountered in past positions and they include:

- passwords between environments
- urls for configuration files (test points to test servers, prod to prod)
- sequence data

In situations like this where there are differences between environments, a 
folder should be created for each environment within the seed, schema, 
changes, and archive directories.  When a file is added, it should follow an 
override pattern.  The deployment script will check for existence of the file 
specified for deployment in the regular directory first, it will then see if 
there is a file with the same name in the environment specific directory.  if it
exists in the environment specific directory, that is the file that will get
applied and the one in the common directory will be ignored.

Generic example:
dbname/filename.sql
dbname/prod/filename.sql
dbname/qa/filename.sql
dbname/test/
dbname/sandbox/

In the above layout, the test and sandbox would get the common file deployed
and the prod and qa environments would get the file deployed with their
specific data.  

Individual environment only deployment example:

dbname/filename.sql
dbname/prod/filename.sql
dbname/qa/
dbname/test/
dbname/sandbox/

In this case, filename.sql in the common directory is an empty file, so it 
can be deployed or marked to be skipped, but prod will see the file and apply 
the file specific to its own environment


