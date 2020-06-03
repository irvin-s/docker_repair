FROM centos:7  
LABEL maintainer "Bezeklik"  
  
RUN sed -e '/installonly_limit/ s/5/0/' -i /etc/yum.conf && \  
yum --assumeyes --quiet update && \  
rm -rf /var/cache/yum  
  
CMD ["/bin/bash"]  

