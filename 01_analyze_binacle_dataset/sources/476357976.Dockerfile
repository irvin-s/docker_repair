FROM    centos:centos6

MAINTAINER Thomas Qvarnstrom <tqvarnst@redhat.com>

# Update the system and Install necessary RPMs
RUN yum -y install wget && yum -y update && yum clean all

# Set root password
RUN echo "root:redhat" | /usr/sbin/chpasswd

########################
# Install PostgreSQL 9.3
########################
RUN yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
RUN yum -y install postgresql93-server postgresql93-contrib;yum clean all
RUN service postgresql-9.3 initdb

# PostgreSQL setup
USER postgres
ENV PGDATA /var/lib/pgsql/9.3/data
ENV PGINST /usr/pgsql-9.3

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host    all         all         0.0.0.0/0               md5" >> $PGDATA/pg_hba.conf
RUN echo "" >> $PGDATA/pg_hba.conf
RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf
RUN echo "" >> $PGDATA/postgresql.conf

RUN $PGINST/bin/pg_ctl start -w -D $PGDATA && \
	$PGINST/bin/psql --command "CREATE USER jdg WITH PASSWORD 'jdg';" && \
	$PGINST/bin/psql --command "CREATE DATABASE jdg WITH OWNER jdg;"

############################################
# Install Supervisor
############################################
USER root
RUN wget -O /tmp/epel-release-6-8.noarch.rpm http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 
RUN rpm -ivh /tmp/epel-release-6-8.noarch.rpm
RUN yum -y install supervisor
RUN echo "[program:postgresql]" >> /etc/supervisord.conf
RUN echo "command=/etc/init.d/postgresql-9.3 start" >> /etc/supervisord.conf

############################################
# Start PostgreSQL
############################################
CMD ["/usr/bin/supervisord", "-n"]

EXPOSE 5432