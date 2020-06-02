# Database container with simple data for a Web application
# Using RHEL 7 base image and MariahDB database
# Version 1

# Pull the rhel image from the local repository
FROM registry.access.redhat.com/rhel:latest
USER root

MAINTAINER Maintainer_Name

RUN yum install --disablerepo=\* \
                --enablerepo=rhel-7-server-rpms \
                -y mariadb-server && \
    yum clean all

# Set up Mariahdb database
ADD gss_db.sql /tmp/gss_db.sql
RUN /usr/libexec/mariadb-prepare-db-dir
RUN /usr/bin/mysqld_safe --basedir=/usr & \
    sleep 10s && \
    /usr/bin/mysqladmin -u root password 'redhat' && \
    mysql --user=root --password=redhat < /tmp/gss_db.sql && \
    mysqladmin shutdown --password=redhat

# Expose Mysql port 3306
EXPOSE 3306

# Start the service
CMD ["--basedir=/usr"]
ENTRYPOINT ["/usr/bin/mysqld_safe"]
