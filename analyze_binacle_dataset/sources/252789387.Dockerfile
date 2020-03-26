FROM duffqiu/storm:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7  
RUN yum -y update  
  
EXPOSE 8080  
ADD start-ui /storm/start-ui  
RUN chmod +x /storm/start-ui  
  
ENTRYPOINT [ "/storm/start-ui" ]  
  

