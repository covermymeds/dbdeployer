#!/bin/bash

echo -e "
Please reference the below sections for usage and naming patterns

1. Schema
2. Seed Data
3. Changes
4. Rollback
5. Baselining sql
6. Archive Directory

" > README.md

cat schema/README 	>> README.md
cat seed/README 	>> README.md
cat changes/README 	>> README.md
cat rollback/README 	>> README.md

echo -e "
################################################################################
# 5. Baselining sql
################################################################################

When a number of changes have accrued and it becomes harder to apply
changes than it would be to just start over, we can baseline.

When a database is baselined its contents should be merged to the schema 
file(s) and seed data file(s) that best represents the content.  Existing 
change files should then be moved to the archive folder for the database.
In the even that environment folders are used, the same environment foldes
should be exist in the archive folder and files should be copied as they
exist in the changes folder (i.e: mv changes/* archive/). Files in the 
rollback directory shoudl be removed as they will no longer be needed.

Anyone on an old version of the checked out database should be able to apply
things that are newer than its newest \"change\" in the archive folder as well
as all all items in the changes folder to get back to current.

New checkouts by default will be current as the changes are included in the new
baseline or schema scripts used.  

The recommended way to archive files is to just stand up a new tiny database
from DBdeployer and then use whatever tools are available to you to dump
the schema and seed data to appropriate files. If you choose, you can even 
elect to just use a single schema or seed data file to contain everything
without splitting your data.

DBdeployer also supports manual archiving and baselining. By baselining individual 
files in this way it allows us to not have to merge all items in 
changes to the baseline and schema at a single time.  We can merge maybe 30 of
50 changes in a git branch and then merge to master while not worrying about
users abililty to deploy things back up to date.

" >> README.md

cat archive/README     >> README.md

echo -e "
################################################################################
# 7. Environment Handling
################################################################################

There will be some changes where data will be different between environments.
There are a few that I have encountered and they include:

- passwords between environments
- urls for configuration files (test points to test servers, prod to prod)
- sequence data

In situations like this where there are data differences between environments, a 
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

" >> README.md

