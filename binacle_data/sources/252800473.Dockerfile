FROM centos:7  
MAINTAINER domeos  
  
ENV SKYDNS_ADDR 0.0.0.0:53  
ENV SKYDNS_DOMAIN local  
ENV SKYDNS_PATH_PREFIX domedns  
  
ADD skydns /opt/skydns  
  
EXPOSE 53  
ENTRYPOINT ["/opt/skydns"]  

