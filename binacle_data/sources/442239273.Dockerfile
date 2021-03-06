# Container with fcron (since cron don't work in docker)
#
# VERSION               0.0.1
#
#
# Guidelines
# ----------
#
# * Always use ubuntu:latest. Problems with new ubuntu releases should be fixed before
#  moving new images into production.
#
# * Daemons are managed with supervisord.
#
# * Logging from all processes should be performed to `/var/log/supervisor/supervisord.log`.
#   The start script will `tail -f` this log so it shows up in `docker logs`. The log file of 
#   daemons that can't log to `/var/log/supervisor/supervisord.log` should also be tailed
#   in `start.sh`
# 

FROM       ubuntu:latest

# Format: MAINTAINER Name <email@addr.ess>
MAINTAINER Jonas Colmsjö <jonas@gizur.com>

RUN apt-get update
RUN apt-get install -y curl wget nano unzip

RUN echo "export HOME=/root" > /.profile


#
# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools
RUN easy_install supervisor
#RUN apt-get install -y supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Install sendmail and build-essential
# ------------------------------------

RUN apt-get install -y build-essential sendmail


#
# Install fcron and batches
# -------------------------

ADD ./src-fcron /src
RUN cd /src/fcron-3.2.0; ./configure 
RUN cd /src/fcron-3.2.0; make
RUN cd /src/fcron-3.2.0; make install


# Set fcrontab entry 
RUN fcrontab -l > mycron
# Run jon every minute
RUN echo "*/1 * * * *  sh -c date >> /var/log/cronjob" >> mycron
RUN fcrontab mycron
RUN rm mycron


#
# Start things
# -------------

ADD ./start.sh /
CMD ["/start.sh"]
