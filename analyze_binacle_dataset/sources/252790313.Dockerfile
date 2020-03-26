#  
# MySQL Dockerfile  
#  
# https://github.com/capaldijo/mysql  
#  
# Pull base image.  
FROM debian:jessie  
  
MAINTAINER capaldijo  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get -yq install mysql-server && \  
rm -rf /var/lib/apt/lists/*  
  
ADD files/myConf.cnf /etc/mysql/conf.d/bind_0.cnf  
  
ADD scripts/init.sh /init.sh  
RUN chmod 755 /*.sh  
ENTRYPOINT ["/init.sh"]  
  
VOLUME /var/lib/mysql  
  
# Define default command.  
CMD ["mysqld_safe"]  
  
# Expose ports.  
EXPOSE 3306  

