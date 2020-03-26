FROM akadan47/ubuntu:14.04  
MAINTAINER akadan47@gmail.com  
  
ENV MYSQL_VERSION 5.5  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -yq mysql-server-$MYSQL_VERSION  
  
ADD my.cnf /etc/mysql/my.cnf  
RUN chmod 664 /etc/mysql/my.cnf  
  
ADD run /usr/local/bin/run  
RUN chmod 755 /usr/local/bin/run  
  
EXPOSE 3306  
VOLUME ["/var/lib/mysql"]  
VOLUME ["/run/mysqld"]  
  
CMD ["/usr/local/bin/run"]

