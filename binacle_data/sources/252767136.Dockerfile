FROM ubuntu:14.04  
MAINTAINER Alex Levin  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update -y --force-yes  
RUN apt-get install monit -y --force-yes  
  
RUN mv /etc/monit /etc/monit.orig  
ADD etc_monit /etc/monit  
RUN chown -R root:root /etc/monit/monitrc  
RUN chmod 600 /etc/monit/monitrc  
  
CMD ["/usr/bin/monit", "-I"]  

