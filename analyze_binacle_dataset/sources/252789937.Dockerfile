FROM debian:8.1  
MAINTAINER Roman Zakharov <camanru@ya.ru>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update &&\  
apt-get upgrade -y &&\  
apt-get install -y mc vim git htop curl wget mysql-server-5.5  
  
ADD my.cnf /etc/mysql/conf.d/my.cnf  
ADD start.sh /usr/local/bin/start.sh  
RUN chmod +x /usr/local/bin/start.sh  
  
EXPOSE 3306  
  
VOLUME ["/var/lib/mysql"]  
CMD ["/usr/local/bin/start.sh"]

