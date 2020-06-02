FROM kibana  
  
MAINTAINER Luis Muniz <luis.muniz@b2boost.com>  
  
COPY kibana.yml /opt/kibana/config/kibana.yml  
  
RUN gosu kibana /opt/kibana/bin/kibana plugin --install elastic/sense  
  

