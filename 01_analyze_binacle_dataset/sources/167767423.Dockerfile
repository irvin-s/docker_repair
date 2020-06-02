FROM ubuntu:trusty

MAINTAINER Frode Egeland <egeland@gmail.com>

# Base
ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US en_US.UTF-8
RUN dpkg-reconfigure locales
RUN apt-get update
RUN apt-get install -y python3-pip postgresql-server-dev-all postgresql-common supervisor

# Supervisor
RUN update-rc.d -f supervisor disable

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start Script
ADD startup /usr/local/bin/startup
RUN chmod +x /usr/local/bin/startup

CMD ["/usr/local/bin/startup"]

# Install global dependencies
RUN pip3 install gunicorn setproctitle flask psycopg2 SQLAlchemy coverage nose Mako Flask-Script Flask-Migrate Flask-HTTPAuth Flask-SQLAlchemy

# Install gunicorn running script
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

# Volumes
VOLUME ["/root/app/logs"]

# Ports
EXPOSE 80
