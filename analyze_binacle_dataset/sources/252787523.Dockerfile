################################################################################  
# broadtech/alpine-mariadb  
# This Dockerfile creates an image that deploys MariaDB  
  
# Base Image  
FROM alpine  
  
  
LABEL "vendor"="BroadTech Innovations PVT LTD"  
LABEL "vendor.url"="http://www.broadtech-innovations.com/"  
LABEL "maintainer"="sgeorge.ml@gmail.com"  
  
# Upgrade existing packages in the base image  
RUN apk --no-cache upgrade  
  
# Install 'mariadb/mysql' client  
RUN apk add --no-cache mysql-client  
  
# Install mariadb from packages with out caching install files  
RUN apk add --no-cache mariadb  
  
# Create directory for 'mysqld.sock'  
RUN mkdir -p /run/mysqld  
  
# Create log files directory  
RUN mkdir -p /var/log/mysql  
  
# Create 'mysql' database  
RUN /usr/bin/mysql_install_db --user=mysql  
  
# Allow root@% user to connect from any host with password 'INSecure'  
RUN /usr/bin/mysqld --user=root & \  
sleep 20s \  
&& echo "GRANT ALL ON *.* TO root@'localhost' IDENTIFIED BY 'INSecure' \  
WITH GRANT OPTION;" | mysql \  
&& echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'INSecure' \  
WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -u root -pINSecure \  
&& /usr/bin/mysqladmin -u root -pINSecure shutdown  
  
RUN mkdir /etc/docker-entrypoint.d  
COPY docker-entrypoint.d/* /etc/docker-entrypoint.d/  
RUN chmod u+x /etc/docker-entrypoint.d/*  
  
COPY scripts/run_parts_entrypoint.sh /usr/sbin/  
RUN chmod u+x /usr/sbin/run_parts_entrypoint.sh  
  
# Open 'mariadb/mysql' port 3306 for access  
EXPOSE 3306  
  
# Start 'mysqld' when container runs  
ENTRYPOINT ["/usr/sbin/run_parts_entrypoint.sh"]  
  
#  
##################---END---######################################################  

