# Base on latest CentOS image  
FROM centos:latest  
  
MAINTAINER “Dmitriy Khlystov ” <hdmitriy90@gmail.com>  
ENV container docker  
  
EXPOSE 2000 2001 3129 1723 1194 8329 8330  
EXPOSE 51925/udp 4500/udp 500/udp 1194/udp 1701/udp 37340/udp  
  
VOLUME "/lib/modules"  
  
ENTRYPOINT ["/bin/bash"]

