FROM duffqiu/storm:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7  
RUN yum -y update  
  
ADD start-sv /storm/start-sv  
RUN chmod +x /storm/start-sv  
  
ENV NBID 1  
ENV S_PORT 6704  
ENV E_PORT 6700  
ENV ZK_NM 3  
EXPOSE 6700-6800  
ENTRYPOINT [ "/storm/start-sv" ]  
  

