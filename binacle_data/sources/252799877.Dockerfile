FROM busybox  
  
MAINTAINER info@digitalpatrioten.com  
  
ADD /configurations /solr-configurations  
  
VOLUME /solr-configurations  
  
CMD /bin/sh

