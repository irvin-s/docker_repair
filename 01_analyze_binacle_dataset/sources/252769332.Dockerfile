FROM kibana:4.5  
MAINTAINER Anita Bendelja <bendelja.anita@gmail.com>  
  
RUN gosu kibana /opt/kibana/bin/kibana plugin --install elastic/sense  

