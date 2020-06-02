FROM kibana:4.4.1  
WORKDIR /opt/kibana  
  
RUN bin/kibana plugin --install elasticsearch/marvel/latest  
RUN bin/kibana plugin --install elastic/sense  
  
RUN chmod 777 /opt/kibana -R  

