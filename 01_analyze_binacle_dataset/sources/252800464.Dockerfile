FROM domecloud/debslim  
  
MAINTAINER Dome C. <dome@tel.co.th>  
  
  
RUN \  
apt-get update \  
&& apt-get -y upgrade \  
&& apt-get install -y procps rsync galera-3 mariadb-server  
  
  
  
COPY start.sh /  
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/  
RUN chmod +x /start.sh  
ENV TERM screen-256color  
ENV SHELL=/bin/bash  
  
ENTRYPOINT ["/start.sh"]  
  

