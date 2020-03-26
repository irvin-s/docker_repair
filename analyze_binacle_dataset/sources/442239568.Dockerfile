# Container with memcached
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
RUN apt-get install -y nano telnet

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
# Install memcached
# ------------------------------------

RUN apt-get install -y memcached


#
# Start things
# --------------

EXPOSE 11211

ADD ./start.sh /
CMD ["/start.sh"]
