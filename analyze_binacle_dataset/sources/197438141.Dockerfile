FROM ubuntu
MAINTAINER https://github.com/ariabov

# Install monitoring scripts

RUN apt-get update && \
  apt-get install -y unzip wget libwww-perl libdatetime-perl && \
  rm -rf /tmp/* /var/tmp/*

RUN wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip && \
  unzip CloudWatchMonitoringScripts-1.2.1.zip && \
  rm CloudWatchMonitoringScripts-1.2.1.zip

WORKDIR aws-scripts-mon

COPY awscreds.template awscreds.template

# Setup cron

ADD crontab /etc/crontab
RUN crontab /etc/crontab

# Log file for debugging

RUN touch /var/log/cron.log
RUN chmod 0644 /var/log/cron.log

ENTRYPOINT cron -f
