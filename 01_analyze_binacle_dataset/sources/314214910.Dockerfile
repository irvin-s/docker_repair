FROM ubuntu:16.04

# Install dependencies
RUN apt-get update \
    && apt-get install -y -qq cron python3 python3-pip

# Copy over project files
RUN mkdir -p /root/mattermost-coffeebot
WORKDIR /root/mattermost-coffeebot
COPY . /root/mattermost-coffeebot

# Install Python libraries
RUN pip3 install -r requirements.txt

# Set up cronjob
ADD crontab /etc/cron.d/crontab
RUN chmod 0755 /etc/cron.d/crontab
RUN touch /var/log/coffeebot.log

# Alias the pairing job
RUN echo 'alias pair="/usr/bin/python3 /root/mattermost-coffeebot/pair.py >> /var/log/coffeebot.log 2>&1"' >> /root/.bashrc

# Start the cronjob
CMD cron -f && tail -f /var/log/coffeebot.log
