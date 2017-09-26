FROM microsoft/dotnet:2.0.0-sdk AS build

ARG BUILDCONFIG=RELEASE

# Copy project files to avoid restoring packages if they haven't changed
COPY *.csproj ./build/
WORKDIR /build/
RUN dotnet restore

COPY . .
RUN dotnet publish -c $BUILDCONFIG -o out

# build runtime image
FROM microsoft/dotnet:2.0.0-runtime 
WORKDIR /app
COPY --from=build /build/out ./

# Install Cron
RUN apt-get update -qq && apt-get -y install cron -qq --force-yes

# Add export environment variable script and schedule
COPY *.sh ./
COPY schedule /etc/cron.d/schedule
RUN sed -i 's/\r//' export_env.sh \
    && sed -i 's/\r//' run_app.sh \
    && sed -i 's/\r//' /etc/cron.d/schedule \
    && chmod +x export_env.sh run_app.sh \
    && chmod 0644 /etc/cron.d/schedule

# Create log file
RUN touch /var/log/cron.log
RUN chmod 0666 /var/log/cron.log

# Volume required for tail command
VOLUME /var/log

# Run Cron
CMD /app/export_env.sh && /usr/sbin/cron && tail -f /var/log/cron.log