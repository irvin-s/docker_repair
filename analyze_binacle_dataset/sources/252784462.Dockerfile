FROM phusion/baseimage:0.9.16  
RUN apt-get update -y  
RUN apt-get install -y vpnc  
  
# Setup vpnc service  
RUN mkdir -p /etc/service/vpnc  
COPY vpnc.sh /etc/service/vpnc/run  
  
# Clean up  
RUN apt-get autoremove -y  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD ["/sbin/my_init"]  

