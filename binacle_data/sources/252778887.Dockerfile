  
FROM ubuntu:14.04  
  
  
RUN \  
apt-get update && apt-get upgrade -y && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y mysql-server-5.6  
  
ADD my.cnf /etc/mysql/my.cnf  
  
VOLUME ["/data"]  
  
WORKDIR /data  
  
CMD ["mysqld"]  

