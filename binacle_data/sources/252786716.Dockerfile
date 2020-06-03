FROM node:4.7  
# runit depends on /etc/inittab  
RUN touch /etc/inittab  
RUN apt-get update &&\  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y -q runit  
  
COPY runit_bootstrap /usr/sbin/runit_bootstrap  
  
ENTRYPOINT ["/usr/sbin/runit_bootstrap"]  

