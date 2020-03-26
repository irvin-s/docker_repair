FROM ubuntu:trusty
MAINTAINER Dennis Micky Jensen <root@mewm.org>

# Download MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server pwgen && \
    rm -rf /var/lib/mysql/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set bind address to 0.0.0.0 and enforce port
RUN sed -i -r 's/bind-address.*$/bind-address = 0.0.0.0/' /etc/mysql/my.cnf
RUN sed -i -r 's/port.*$/port = 3305'/ /etc/mysql/my.cnf

# Add bash scripts for creating a user and run server
ADD create-mariadb-user.sh /create-mariadb-user.sh
ADD run-mariadb.sh /run-mariadb.sh
RUN chmod 775 /*.sh

# To avoid mysql whining about this variable
ENV TERM dumb 

# Set default entry point
CMD ["/run-mariadb.sh"]