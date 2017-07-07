# .Net Core console app running in a schedule in Docker

This is an example project showing you how to run a console app in a schedule in a docker container.

The docker image makes use of cron which is a unix utility for running commands on a schedule.

The issue I came across with running console apps in cron is that the environment variables aren't visible to cron jobs. You have to specify the environment variables up front before running your job.

However, the whole point of Docker is not to have a hardcoded values which are likely to change between environments.

You therefore need to copy the environment variables to a script when your container starts and then set up your environment as part of the cron script.

The docker file attached does the following:
1. Installs cron on the standard microsoft/dotnet:1.1.1-sdk image.
2. Copies your application files across to the docker image.
3. Copies the schedule file across to the docker image.
4. Restores and Publishes your dotnet core image. 
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