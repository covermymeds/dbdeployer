# General Info
The git plugin is designed to only review the files that have changed in comparison to a branch name when running a deployment report from a branch. This specifically can help alleviate issues when dealing with auto_deploy_folders. For instance, if person A were to checkout a branch from master and change a file in `dbname/sprocs/` and someone else were to do the same thing in a different branch and different file, a file system compare approach would clobber the deployment of the first persons file because the checksum doesn't match, even though the second person didn't modify that file.

# New Variables For Your Config
`branch_to_compare` This defaults to `origin/master`. If you want to adjust this to something else or define explicitly, please follow the below information.
In `/etc/dbdeployer/config.sh` or in `~/.dbdeployer` add the below line and adjust the source/branch accordingly
```
branch_to_compare='origin/master'
```

# deployment_report
This function was changed to see if you are in a branch when deploying. If you are, it will only use files that are committed to git that aren't on the `branch_to_compare`. If you are on the `branch_to_compare`, then it will fall back to a standard filesystem comparison.

This change is applied to both regular deployment folders and auto deployment folders.
