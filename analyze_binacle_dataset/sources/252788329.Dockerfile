FROM centos:7  
RUN yum install -y rsyslog  
  
VOLUME /var/log/servers  
  
ENTRYPOINT rsyslogd -n  

