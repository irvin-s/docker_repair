FROM centos:7  
MAINTAINER Andy Wong <pslandywong@hotmail.com>  
  
RUN yum install -y keepalived  
  
ADD entrypoint.sh /  
  
ADD config_keepalived.sh /  
  
ADD keepalived.conf /etc/keepalived/  
  
RUN chmod +x /entrypoint.sh  
  
RUN chmod +x /config_keepalived.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

