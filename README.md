# .Net Core console app running in a schedule in Docker

This is an example project showing you how to run a console app in a schedule in a docker container.

For more information see a full breakdown on my blog:
https://www.alexhyett.com/scheduled-dotnet-core-console/

The docker image makes use of cron which is a unix utility for running commands on a schedule.

The issue I came across with running console apps in cron is that the environment variables aren't visible to cron jobs. You have to specify the environment variables up front before running your job.

However, the whole point of Docker is not to have a hardcoded values which are likely to change between environments.

You therefore need to copy the environment variables to a script when your container starts and then set up your environment as part of the cron script.

The docker file attached does the following:
1. Copies your project files across and restores them.
2. Copies your application files across to the docker image.
3. Publishes your application to the out location.
3. Creates a new 2.0.0-runtime image.
4. Copies your published app to the new image.
5. Installs cron into the runtime image.
6. Copies scripts and schedule file, removes carrage returns and sets permissions
5. Copies environment variables so that cron can access them.
6. Runs cron and outputs the contents of the /var/log/cron.log file to the screen.

## How to use
To use this within your own dotnet core console app you will need the following files:

* Dockerfile
* schedule
* export_env.sh
* run_app.sh
* .dockerignore 
* docker-compose.yml

You need to modify the run_app.sh file to reference the dll of your console app and the schedule file if you want it to run on a different schedule other than once a minute.

Then run:

`docker-compose up`
