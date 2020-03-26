# Logstash and Elasticsearch server (end example of client configuration)
#
# VERSION               0.0.1

FROM       ubuntu:trusty

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Jonas Colmsjö <jonas@gizur.com>

RUN echo "export HOME=/root" >> /root/.profile

# Mirros: http://ftp.acc.umu.se/ubuntu/ http://us.archive.ubuntu.com/ubuntu/
#RUN echo "deb http://ftp.acc.umu.se/ubuntu/ trusty-updates main restricted" >> /etc/apt/source.list
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates main restricted" >> /etc/apt/source.list
RUN apt-get update
RUN apt-get install -y wget nano curl git

#
# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools
RUN easy_install supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Install rsyslog
# ---------------
#

RUN apt-get -y install rsyslog
RUN mv /etc/rsyslog.conf /etc/rsyslog.conf.org
ADD ./rsyslog.conf.client /etc/
ADD ./rsyslog.conf.server /etc/rsyslog.conf


#
# Install cron
# ------------

# Run jon every minute
#RUN echo '*/1 * * * *  /bin/bash -c "echo `date` testjob, just testing to print to stdout"' > /mycron
#RUN crontab /mycron

ADD ./etc-pam.d-cron /etc/pam.d/cron


#
# Install Logstash and Elasticsearch
# -----------------------------------
#

RUN apt-get install -y openjdk-7-jre
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
RUN tar zxvf logstash-1.4.2.tar.gz
ADD ./logstash.conf /

RUN curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.tar.gz
RUN tar -zxvf elasticsearch-1.4.4.tar.gz

RUN mv /elasticsearch-1.4.4/config/elasticsearch.yml /elasticsearch-1.4.4/config/elasticsearch.yml.org
ADD ./elasticsearch-config-elasticsearch.yml /elasticsearch-1.4.4/config/elasticsearch.yml


#
# Start things up
# ----------------
#

EXPOSE 514 5514 9200 9292

CMD ["supervisord"]
