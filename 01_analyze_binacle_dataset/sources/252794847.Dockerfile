FROM ubuntu:16.04  
RUN DEBIAN_FRONTEND=noninteractive; \  
apt-get update && \  
apt-get -y install \  
net-tools \  
rinetd  
  
COPY rinetd.conf.template /etc/rinetd.conf.template  
COPY run.sh /usr/local/bin/run.sh  
RUN chmod +x /usr/local/bin/run.sh  
  
CMD ["/usr/local/bin/run.sh"]  

