FROM ubuntu:trusty  
MAINTAINER Michael Davis <michael@damaru.com>  
# Thanks to Fernando Mayo <fernando@tutum.co>, Feng Honglin <hfeng@tutum.co>  
# Install packages  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && \  
apt-get -yq install mysql-server-5.6 pwgen && \  
rm -rf /var/lib/apt/lists/*  
  
# Remove pre-installed database  
RUN rm -rf /var/lib/mysql/*  
  
# Remove syslog configuration  
RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf  
  
# Add MySQL configuration  
ADD my.cnf /etc/mysql/conf.d/my.cnf  
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf  
  
# Add MySQL scripts  
ADD import_sql.sh /import_sql.sh  
ADD run.sh /run.sh  
RUN chmod 755 /*.sh  
ADD damaru.sql /damaru.sql  
  
# Exposed ENV  
ENV MYSQL_USER admin  
#ENV MYSQL_PASS **Random**  
ENV MYSQL_PASS admin  
#ENV ON_CREATE_DB **False**  
ENV MYSQL_DB damaru  
ENV ON_CREATE_DB damaru  
ENV STARTUP_SQL /damaru.sql  
  
# Add VOLUMEs to allow backup of config and databases  
VOLUME ["/etc/mysql", "/var/lib/mysql"]  
  
EXPOSE 3306  
CMD ["/run.sh"]  

