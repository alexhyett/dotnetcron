# .Net Core console app running in a schedule in Docker

This is an example project showing you how to run a console app in a schedule in a docker container.

The docker image makes use of cron which is a unix utility for running commands on a schedule.

The docker file attached does the following:
1. Installs cron on the standard microsoft/dotnet:1.1.1-sdk image.
2. Copies your application files across to the docker image.
3. Copies the schedule file across to the docker image.
4. Restores and Publishes your dotnet core image. 
5. Runs cron and outputs the contents of the /var/log/cron.log file to the screen.

## How to use
To use this within your own dotnet core console app you will need the Dockerfile, schedule file dockerignore file and docker-compose.yml (if you are not using your own).

You need to modify the schedule file to reference the dll of your console app. 

Then run:

`docker-compose up`
