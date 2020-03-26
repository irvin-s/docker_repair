FROM phusion/baseimage:latest  
MAINTAINER du@cs.columbia.edu  
# Version 2014-10-23  
ENV HOME /root  
CMD ["/sbin/my_init"]  
  
RUN apt-get update  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq  
  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh  

