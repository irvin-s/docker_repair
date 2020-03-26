FROM haproxy:alpine  
  
COPY build/command/* /build/command/  
RUN /build/command/install  
  
COPY command/* /command/  
  
ENTRYPOINT /command/entrypoint  

