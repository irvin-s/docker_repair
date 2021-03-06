# DOCKER-VERSION 1.0.0  
#  
# Ceph OSD  
#  
# USAGE NOTES:  
# * OSD_ID (numeric identifier for this OSD; obtain from `ceph osd create`)  
#  
# VERSION 0.0.2  
FROM ceph/base:giant  
MAINTAINER Seán C McCord "ulexus@gmail.com"  
# Expose the ceph OSD port (6800+, by default)  
EXPOSE 6800  
RUN apt-get update && apt-get -y install runit && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD my_init/my_init /sbin/my_init  
RUN chmod +x /sbin/my_init  
RUN mkdir -p /etc/container_environment  
  
ADD 2.sh /etc/runit/2  
RUN chmod +x /etc/runit/2  
  
RUN mkdir /etc/service/bootstrap  
ADD entrypoint.sh /etc/service/bootstrap/run  
RUN chmod +x /etc/service/bootstrap/run  
  
ENTRYPOINT ["/sbin/my_init"]  

