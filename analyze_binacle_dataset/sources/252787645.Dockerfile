FROM phusion/baseimage:0.9.18  
MAINTAINER Bruce Robertson <bruce@imploder.co.uk>  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
# install python3 serial module so we can talk to the CurrentCost meter 2  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y python3-serial \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
# make the directories for the pythinb script to live in  
# also create runit service for the python script  
RUN mkdir /var/lib/pvcc \  
&& mkdir /etc/service/pvcc  
ADD pvcc.sh /etc/service/pvcc/run  
ADD pvcc.py /var/lib/pvcc/pvcc.py  
RUN chmod +x /etc/service/pvcc/run  

