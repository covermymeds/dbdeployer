# General Info
The git plugin is designed to only review the files that have changed in comparison to a branch name when running a deployment report. This specifically can help alleviate issues when dealing with auto_deploy_folders.

# New Variables For Your Config
`branch_to_compare` This defaults to `origin/master`. If you want to adjust this to something else or define explicitly, please follow the below information.
In `/etc/dbdeployer/config.sh` or in `~/.dbdeployer` add the below line and adjust the source/branch accordingly
```
branch_to_compare='origin/master'
```
