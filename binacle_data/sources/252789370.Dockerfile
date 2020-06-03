FROM duffqiu/dockerjdk7:latest  
MAINTAINER duffqiu@gmail.com  
  
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7  
RUN yum -y update  
RUN yum install -y wget git e4fsprogs docker  
  
VOLUME /var/lib/docker  
  
ENV PORT=2375  
ADD wrapdocker /usr/local/bin/wrapdocker  
RUN chmod +x /usr/local/bin/wrapdocker  
  
EXPOSE 2375  
ENTRYPOINT [ "/usr/local/bin/wrapdocker" ]  
  
CMD ["/bin/bash" , "-l"]  

