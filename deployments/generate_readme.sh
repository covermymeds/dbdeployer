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

When a number of changes have accrued and it become harder to apply
changes than it would be to just start over, we can baseline.

When a file is baselined it's contents should be merged to the schema file or
seed data file that best represents the content.  The file itself should then
be moved to the archive folder for the database.

Anyone on an old version of the checked out database should be able to apply
things that are newer than its newest \"change\" in the archive folder as well
as all all items in the changes folder to get back to current.

New checkouts by default will be current as the changes are included in the new
baseline or schema scripts used.  

By archiving files in this way it allows us to not have to merge all items in 
changes to the baseline and schema at a single time.  We can merge maybe 30 of
50 changes in a git branch and then merge to master while not worrying about
users abililty to come back up to date.

" >> README.md

cat archive/README     >> README.md

echo -e "
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

" >> README.md

