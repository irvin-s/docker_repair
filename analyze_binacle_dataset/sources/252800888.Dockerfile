FROM alpine:latest  
  
COPY data /data  
  
VOLUME /data  
  
ENTRYPOINT ["/bin/ash", "-c", "sleep 100000000"]  

