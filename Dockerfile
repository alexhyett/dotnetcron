FROM microsoft/dotnet:1.1.1-sdk AS build

ARG BUILDCONFIG=RELEASE

# Copy project files to avoid restoring packages if they haven't changed
COPY *.csproj ./build/
RUN dotnet restore ./build/

COPY . ./build/
WORKDIR /build/
RUN dotnet publish -c $BUILDCONFIG -o out

# build runtime image
FROM microsoft/dotnet:1.1.1-runtime 
WORKDIR /app
COPY --from=build /build/out ./

# Add export environment variable script
COPY export_env.sh .
COPY run_app.sh .
RUN chmod +x export_env.sh run_app.sh

# Install Cron
RUN apt-get update -qq && apt-get -y install cron -qq --force-yes

# Set up schedule
ADD schedule /etc/cron.d/schedule
RUN chmod 0644 /etc/cron.d/schedule

# Create log file
RUN touch /var/log/cron.log
RUN chmod 0666 /var/log/cron.log

# Volume required for tail command
VOLUME /var/log

# Run Cron
CMD /app/export_env.sh && /usr/sbin/cron && tail -f /var/log/cron.log