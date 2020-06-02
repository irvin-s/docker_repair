FROM kibana:4.5  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN /opt/kibana/bin/kibana plugin --install elastic/sense  

