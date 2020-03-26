FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get install -y rsyslog python-pip 

ADD cron cron
ADD requirements.txt requirements.txt
ADD sender.py sender.py

RUN echo 'size 10M' >> /etc/logrotate.conf
RUN chmod a+x /cron/bin/sender.sh
RUN pip install -r requirements.txt
RUN crontab /cron/crontab && touch /var/log/cron.log

CMD sh /cron/start.sh
