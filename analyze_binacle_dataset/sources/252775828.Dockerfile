FROM phusion/baseimage:0.9.9  
MAINTAINER Ryan Bourgeois <bluedragonx@gmail.com>  
  
# set up the container environment  
ENV HOME /root  
ENV DEBIAN_FRONTEND noninteractive  
ENTRYPOINT ["/sbin/my_init"]  
  
# we want an app user for running non-system things  
RUN groupadd -g 9999 app && useradd -u 9999 -g app -m app  
  
# configure system services  
ADD files/logrotate/logrotate.conf /etc/logrotate/  
ADD files/logrotate/syslog-ng.conf /etc/logrotate/conf.d/  
ADD files/syslog-ng/syslog-ng.conf /etc/syslog-ng/  
ADD files/syslog-ng/destination.conf /etc/syslog-ng/  
ADD files/syslog-ng/run /etc/service/syslog-ng/  

