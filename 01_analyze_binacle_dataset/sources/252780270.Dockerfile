FROM gliderlabs/alpine:edge  
  
COPY run.sh /run.sh  
  
ENTRYPOINT ["/run.sh"]  
  

