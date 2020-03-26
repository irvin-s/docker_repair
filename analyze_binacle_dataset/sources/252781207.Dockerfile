FROM mariadb:10  
MAINTAINER Porawit Poboonma <ball6847@gmail.com>  
  
ENV TERM=xterm-256color  
  
RUN apt-get update && \  
apt-get install -y netcat && \  
rm -rf /var/lib/apt/lists/*  
  
ADD docker-entrypoint.sh /docker-entrypoint.sh  
ADD conf.d/00-galera.cnf /etc/mysql/conf.d/00-galera.cnf  
  
EXPOSE 3306 4444 4567 4568  

