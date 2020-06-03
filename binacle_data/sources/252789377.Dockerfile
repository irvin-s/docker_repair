FROM centos:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7  
RUN yum -y update  
  
RUN yum -y install keepalived  
RUN rpm -e --nodeps keepalived  
  
ADD ./bin/keepalived /opt/bin/keepalived  
RUN chmod +x /opt/bin/keepalived  
ADD ./bin/genhash /opt/bin/genhash  
RUN chmod +x /opt/bin/genhash  
ADD ./bin/start.sh /opt/bin/start.sh  
RUN chmod +x /opt/bin/start.sh  
  
RUN mkdir -p /etc/keepalived/  
  
ENTRYPOINT [ "/opt/bin/start.sh"]  

