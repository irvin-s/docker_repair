FROM centos:centos6
MAINTAINER Jose De la Rosa "https://github.com/jose-delarosa"

# Change as desired
ENV MYSQL_ADMIN root
ENV MYSQL_ADMIN_PASSWORD password

# Update and install
RUN yum -y update
RUN yum -y install mysql-server && \
    yum clean all && rm -fr /var/cache/*

# Create MySQL database and users
RUN service mysqld start; \
    mysqladmin -u $MYSQL_ADMIN password $MYSQL_ADMIN_PASSWORD; \
    mysql -u $MYSQL_ADMIN -e "grant all privileges on *.* to $MYSQL_ADMIN@\"%\" identified by '$MYSQL_ADMIN_PASSWORD' with grant option;" --password=$MYSQL_ADMIN_PASSWORD

VOLUME ["/var/lib/mysql"]
USER mysql
EXPOSE 3306

# Set the default command to run when starting the container
CMD ["mysqld_safe"]
