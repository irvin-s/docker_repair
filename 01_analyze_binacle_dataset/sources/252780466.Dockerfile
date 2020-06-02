FROM coolersport/mustache  
  
COPY generate.sh /home/alpine  
  
USER root  
  
RUN chmod +x /home/alpine/generate.sh && \  
chown alpine:alpine /home/alpine/generate.sh  
  
USER alpine  
  
ENTRYPOINT ["/home/alpine/generate.sh"]  

