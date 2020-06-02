FROM debian:jessie  
  
ADD image /usr/local/bin  
RUN install.sh && rm /usr/local/bin/install.sh  
  
ENV INPUT /bbx/input/biobox.yaml  
ENV OUTPUT /bbx/output  
ENV METADATA /bbx/metadata  
  
ENTRYPOINT ["validate_inputs.sh"]  

