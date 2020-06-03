
FROM debian:latest
MAINTAINER contact@samuel-berthe.fr

RUN apt-get update && apt-get install -y cron git python python-setuptools python-pip curl

# Add crontab file in the cron directory
ADD schedule /etc/cron.d/schedule

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/schedule

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log

RUN mkdir /root/.ssh
ADD . /root/repo
