FROM golang:1.10-stretch  
  
COPY run.sh /  
  
ENTRYPOINT ["/run.sh"]  

