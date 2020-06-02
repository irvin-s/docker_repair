FROM clashclanvn/firstimage:latest  
RUN mkdir -p /opt/scripts  
RUN mkdir -p /opt/scripts1  
RUN mkdir -p /opt/scripts2  
RUN mkdir -p /opt/scripts3  
COPY check_symbol_rate.sh /opt/scripts/  
COPY check_symbol_rate.sh /opt/scripts2/  
  

