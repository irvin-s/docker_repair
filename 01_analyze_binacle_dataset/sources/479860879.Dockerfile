############################################################
# Dockerfile to build MonetDB and R images
# Based on CentOS 7
############################################################
FROM centos:7
MAINTAINER Panagiotis Koutsourakis <panagiotis.koutsourakis@monetdbsolutions.com>

#######################################################
# Expose ports
#######################################################
EXPOSE 50000

#######################################################
# Setup supervisord
#######################################################
# Install supervisor
RUN yum install -y python-setuptools
RUN easy_install supervisor
# Create a log dir for the supervisor
RUN mkdir -p /var/log/supervisor
# Copy the config
COPY configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#############################################################
# Enables repos, update system, install packages and clean up
#############################################################
RUN yum -y install epel-release numpy

# Update & upgrade
RUN yum update -y && \
    yum upgrade -y

#############################################################
# MonetDB installation
#############################################################
# Create users and groups
RUN groupadd -g 5000 monetdb && \
    useradd -u 5000 -g 5000 monetdb

# Enable MonetDB repo
RUN yum install -y https://www.monetdb.org/downloads/epel/MonetDB-release-epel.noarch.rpm

# Update & upgrade
RUN yum update -y && \
    yum upgrade -y

ARG MonetDBVersion=11.31.7

# Install MonetDB server
RUN yum install -y MonetDB-$MonetDBVersion \
                   MonetDB-stream-$MonetDBVersion \
                   MonetDB-client-$MonetDBVersion \
                   MonetDB-SQL-server5-$MonetDBVersion \
                   MonetDB-SQL-server5-hugeint-$MonetDBVersion \
                   MonetDB5-server-$MonetDBVersion \
                   MonetDB5-server-hugeint-$MonetDBVersion

# Install MonetDB extensions
RUN yum install -y MonetDB-geom-MonetDB5-$MonetDBVersion \
                   MonetDB-R-$MonetDBVersion \
                   MonetDB-python2-$MonetDBVersion

# Clean up
RUN yum -y clean all

#######################################################
# Setup MonetDB
#######################################################
# Add helper scripts
COPY scripts/set-monetdb-password.sh /home/monetdb/set-monetdb-password.sh
RUN chmod +x /home/monetdb/set-monetdb-password.sh

# Add a monetdb config file to avoid prompts for username/password
# We will need this one to authenticate when running init-db.sh, as well
COPY configs/.monetdb /home/monetdb/.monetdb

# Copy the database init scripts
COPY scripts/init-db.sh /home/monetdb/init-db.sh
RUN chmod +x /home/monetdb/init-db.sh

# As of the Jun2016 release, we have to set the property listenaddr to any host
# because now it only listens to the localhost by default
RUN echo "listenaddr=0.0.0.0" >> /var/monetdb5/dbfarm/.merovingian_properties

# Init the db in a script to allow more than one process to run in the container
# We need two: one for monetdbd and one for mserver
# The script will init the database with using the unprivileged user monetdb
RUN su -c 'sh /home/monetdb/init-db.sh' monetdb

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

