FROM ubuntu:latest
MAINTAINER Nicolas Fiorini "nicolas.fiorini@nih.gov"

RUN apt-get update && apt-get -y upgrade && apt-get -y install cron python python3
RUN apt-get install -y python3-pip
RUN apt-get -y install r-base
RUN apt-get -y install libcurl4-gnutls-dev
RUN apt-get -y install libssl-dev

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/pubrunner
ADD . /app

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/pubrunner

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
