FROM debian:stretch

# cron container

# Install deps
RUN apt-get update; apt-get install -q -y cron\
    python-pip

RUN pip install docker

COPY *.py /root/


# RUN chmod +x /root/*.sh
RUN chmod +x /root/*.py

# Copy crontab file in the cron directory
COPY crontab_monitoring /etc/cron.d/crontab_monitoring
# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab_monitoring
RUN crontab /etc/cron.d/crontab_monitoring

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD ["cron", "-f", "&&", "tail", "-f", "/var/log/cron.log"]
