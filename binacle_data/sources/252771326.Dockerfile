FROM selenium/node-chrome:2.44.0  
MAINTAINER Aitor Pazos <mail@aitorpazos.es>  
  
COPY entry_point.sh /opt/bin/entry_point.sh  
  
USER root  
RUN chmod a+x /opt/bin/entry_point.sh  
USER seluser  

