FROM mysql:5.7  
MAINTAINER Erik Osterman "e@osterman.com"  
# System ENV  
ENV TIMEZONE Etc/UTC  
ENV DEBIAN_FRONTEND noninteractive  
ENV PATH "$PATH:/usr/local/bin"  
ENV TERM xterm  
ENV PERL_MM_USE_DEFAULT true  
  
ENV MYSQL_CLIENT_CNF=/root/.my.cnf  
ENV MYSQL_INIT_SQL /tmp/init.sql  
  
RUN apt-get update && \  
apt-get -y install procps libdbd-mysql libdbd-mysql-perl mysqltuner && \  
ln -s /usr/bin/mysqlcheck /usr/bin/mysqlanalyze && \  
ln -s /usr/bin/mysqlcheck /usr/bin/mysqloptimize && \  
ln -s /usr/bin/mysqlcheck /usr/bin/mysqlrepair  
  
ADD entrypoint.sh /entrypoint.sh  
ADD my.cnf /etc/mysql/conf.d/  
CMD mysqld  

