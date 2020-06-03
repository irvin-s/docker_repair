FROM phusion/baseimage:0.10.0  
USER root  
RUN apt-get update && apt-get install tripwire --yes  
  
RUN rm /etc/tripwire/*  
  
ADD config/twcfg.txt /etc/tripwire/twcfg.txt  
ADD config/twpol.txt /etc/tripwire/twpol.txt  
  
ADD my_init/90_tripwire.sh /etc/my_init.d/90_tripwire.sh  
RUN chmod -R +x /etc/my_init.d/  
  

