#
# Dockerfile that builds container with Postgres
# When not using vagrant, run it manually with: docker build .
#


# Image: Postgres
#
# VERSION               0.0.1

FROM     ubuntu
MAINTAINER Jonas Colmsjö "jonas@gizur.com"


# sudo will complain about unknown host otherwise
#RUN echo "127.0.0.1\tlocalhost" >> /etc/hosts
#RUN echo "127.0.0.1\t`hostname`" >> /etc/hosts

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y


#
# Install Postgres
#

RUN apt-get install postgresql -y


#
# Add configuration changes
#

ADD ./etc/postgresql/9.1/main /etc/postgresql/9.1/main


# Stop the database
RUN /bin/su postgres -c "/usr/sbin/service postgresql stop"

# Hack, manual cleanup seams necessary
RUN if [ -e /var/lib/postgresql/9.1/main/postmaster.pid ]; then rm /var/lib/postgresql/9.1/main/postmaster.pid; fi
RUN if [ -d /var/run/postgresql ]; then rm -rf /var/run/postgresql; fi
RUN mkdir -p /var/run/postgresql
RUN chown -R postgres:postgres /var/run/postgresql


# Create postgres user for OpenERP
ADD . /src
RUN chown -R postgres:root /src
RUN /src/init.sh


#
# Start Postgres
#

EXPOSE 5432

CMD ["/bin/su","postgres","-c","/usr/lib/postgresql/9.1/bin/postgres -D /var/lib/postgresql/9.1/main -c config_file=/etc/postgresql/9.1/main/postgresql.conf"]
