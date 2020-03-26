FROM busybox  
  
MAINTAINER info@digitalpatrioten.com  
  
ADD /var/etc /var/etc  
  
VOLUME /var/etc  
CMD /bin/sh  

