# Riak CS service for testing and development  
FROM phusion/baseimage:0.9.18  
MAINTAINER Dimagi <devops@dimagi.com>  
  
VOLUME /var/lib/riak-data  
  
COPY install.sh /tmp/install.sh  
RUN /tmp/install.sh  
COPY etc/ /etc/  
COPY set-admin-keys.sh /bin/set-admin-keys.sh  
  
EXPOSE 9980  
CMD ["/sbin/my_init", "--quiet"]  

