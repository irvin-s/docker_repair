FROM blacklabelops/centos  
MAINTAINER Steffen Bleul <blacklabelops@itbleul.de>  
  
# install dev tools  
RUN yum install -y \  
vi && \  
yum clean all && rm -rf /var/cache/yum/* && \  
mkdir -p /opt/rsyslogd/rsyslog.d/  
  
COPY ./docker-entrypoint.sh /opt/rsyslogd/docker-entrypoint.sh  
COPY ./rsyslog.conf /etc/rsyslog.conf  
  
WORKDIR /opt/rsyslogd  
VOLUME ["/var/log", "/dev"]  
ENTRYPOINT ["/opt/rsyslogd/docker-entrypoint.sh"]  
CMD ["rsyslogd"]  

