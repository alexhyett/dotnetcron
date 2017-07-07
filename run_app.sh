#!/bin/bash

# Set environment variables copied from container
source /app/set_env.sh;

# Run your dotnet console app
dotnet /app/dotnet-cron.dll