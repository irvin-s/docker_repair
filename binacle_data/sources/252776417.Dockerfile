FROM boomtownroi/base:16.04  
# Add your name if you find yourself here  
MAINTAINER Robert Landers <rlanders@boomtownroi.com>  
  
# Install packages  
RUN apt-get update && \  
apt-get -yq install cron mysql-server pwgen && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Remove pre-installed database  
RUN rm -rf /var/lib/mysql/*  
  
# Remove syslog configuration  
RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf  
  
ADD root /  
  
# Exposed ENV  
ENV MYSQL_USER admin  
ENV MYSQL_PASS **Random**  
ENV ON_CREATE_DB **False**  
  
# Replication ENV  
ENV REPLICATION_MASTER **False**  
ENV REPLICATION_SLAVE **False**  
ENV REPLICATION_USER replica  
ENV REPLICATION_PASS replica  
  
# Add VOLUMEs to allow backup of config and databases  
VOLUME ["/etc/mysql", "/var/lib/mysql"]  
  
EXPOSE 3306

