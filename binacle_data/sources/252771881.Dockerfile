From ubuntu:trusty  
MAINTAINER Christian Costa  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get -q -y install supervisor postfix rsyslog  
COPY supervisord.conf /etc/supervisor/  
COPY init.sh /opt/init.sh  
RUN rm -rf /etc/rsyslog.d/*  
RUN rm -rf /etc/rsyslog.conf  
COPY ./etc/rsyslog.conf /etc  
COPY ./etc/rsyslog.d/* /etc/rsyslog.d/  
EXPOSE 25/tcp 465/tcp 587/tcp  
RUN rm -rf /var/lib/apt/lists/* /tmp/* && \  
apt-get autoremove -y && \  
apt-get autoclean  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

