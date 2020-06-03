FROM dockerfile/ubuntu
MAINTAINER Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>, Cyrill Schumacher <cyrill@zookal.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive

# git is not needed here but included in the base docker image.
RUN apt-get remove -y git

RUN apt-get update && \
  apt-get -yq install mysql-server-5.5 pwgen && \
  rm -rf /var/lib/apt/lists/*

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL configuration
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Add MySQL scripts
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD import_sql.sh /import_sql.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# due do shared folders in the boot2docker vm
# 102 is the old mysql uid
# 33 is the old uid of www-data which is here not needed
RUN userdel -r www-data
RUN usermod -u 33 mysql && \
  find /var -uid 33 -exec chown -R mysql {} \; && \
  find /usr -uid 33 -exec chown -R mysql {} \;

RUN chown -R mysql /var/run/mysqld
RUN chown -R mysql /var/lib/mysql

# Exposed ENV
ENV MYSQL_USER admin
ENV MYSQL_PASS **Random**

# Replication ENV
ENV REPLICATION_MASTER **False**
ENV REPLICATION_SLAVE **False**
ENV REPLICATION_USER replica
ENV REPLICATION_PASS replica

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

EXPOSE 3306
CMD ["/run.sh"]
