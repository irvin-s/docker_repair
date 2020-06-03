FROM centos:latest  
  
LABEL maintainer="csfreak@csfreak.com"  
LABEL name="csfreak/rsyslog"  
  
RUN yum install -y rsyslog  
  
RUN mkdir -p /logs  
  
RUN echo "$IncludeConfig /etc/rsyslog.d/" > /etc/rsyslog.conf  
RUN rm /etc/logrotate.d/syslog  
  
EXPOSE 514/udp  
EXPOSE 514/tcp  
  
VOLUME /logs  
  
VOLUME /etc/rsyslog.d  
VOLUME /etc/logrotate.d  
  
ENTRYPOINT ["/usr/sbin/rsyslogd","-n"]  

