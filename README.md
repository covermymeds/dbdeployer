Please refer to the [repo wiki](https://github.com/covermymeds/dbdeployer/wiki) for usage info, help, and more.  

# DBdeployer General Info 

DBdeployer was developed to be a lightweight tool to manage database deployments without the need for tools like java or php and a large front end.  It is entirely written in bash and is extensible to any databases that have a command line interface and bash available.  It supports being run locally on the server or you can pass in information necessary to connect to a database remotely.

# Pull Requests, Active Development

This tool was developed in house and is currently utilized throughout all of our various environments. We are still adding a lot of features but have seen majore benefits from the simplicity of the code base and the ability to track our deployments.

If you would like to make a pull request, please feel free to do so and it should be reviewed relatively quickly with feedback provided and a clear expectation of when it might be merged.

If you would like to extend the script to support another database, you should be able to copy one of the dbtype folders to a new database name and then edit the things that are specifically different in your database. More information on extending the tool to support other database platforms will be available in the wiki.

# Issues

We track our issues within the repo using github issues. If you find a problem and aren't sure how to fix it with a pull request, feel free to create an issue and we will see if we can fix it for you.
