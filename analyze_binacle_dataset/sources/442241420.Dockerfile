# template with supervisord
#
# VERSION               0.0.1
#
#


FROM       ubuntu:trusty
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

RUN echo "export HOME=/root" >> /root/.profile

# Mirros: http://ftp.acc.umu.se/ubuntu/ http://us.archive.ubuntu.com/ubuntu/
RUN echo "deb http://ftp.acc.umu.se/ubuntu/ trusty-updates main restricted" >> /etc/apt/source.list
RUN apt-get update

# Some good utils
RUN apt-get install -y wget nano curl git


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
# Install pip (for python)
#

RUN easy_install pip


#
# Install rsyslog
# ---------------

RUN apt-get install -y  rsyslog
ADD ./etc-rsyslog.conf /etc/rsyslog.conf


#
# Install cron and batches
# ------------------------

# Run backup job every hour
#ADD ./backup.sh /
#RUN echo '0 1 * * *  /bin/bash -c "/backup.sh"' > /mycron
# Run job every minute
RUN echo '*/1 * * * *  /bin/bash -c "/batches.sh"' >> /mycron
#RUN crontab /mycron
ADD ./etc-pam.d-cron /etc/pam.d/cron


EXPOSE 80 443
CMD ["supervisord"]
