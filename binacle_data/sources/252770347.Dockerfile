FROM centos  
  
MAINTAINER MOHAMED ASHIQ LIYAZUDEEN mliyazud@redhat.com  
  
ENV container docker  
  
RUN echo "#!/bin/sh" > /usr/local/bin/gluster  
RUN chmod +X /usr/local/bin/gluster  
  
CMD ["/usr/sbin/init"]  
  

