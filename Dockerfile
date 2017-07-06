FROM microsoft/dotnet:1.1.1-sdk

ARG BUILDCONFIG=DEBUG

# Install Cron
RUN apt-get update -qq && apt-get -y install cron -qq --force-yes

# Copy project files to avoid restoring packages if they haven't changed
COPY . /app/.
WORKDIR /app/

# Set up schedule
ADD schedule /etc/cron.d/schedule
RUN chmod 0644 /etc/cron.d/schedule

# Create log file
RUN touch /var/log/cron.log
RUN chmod 0666 /var/log/cron.log

# Publish dotnet core app
RUN dotnet restore
RUN dotnet publish -c $BUILDCONFIG -o out

# Volume required for tail command
VOLUME /var/log

# Run Cron
CMD /usr/sbin/cron && tail -f /var/log/cron.log