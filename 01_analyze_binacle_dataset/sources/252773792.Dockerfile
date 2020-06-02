FROM almanacproject/init_base  
  
COPY ./config.yml /opt/input/config.yml  
  
ENV CONFIG="/opt/input/config.yml"  
ENV OUTPUT="/opt/output/"  

