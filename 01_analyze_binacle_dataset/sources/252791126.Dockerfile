FROM cybe/ps-base:alpine37  
  
RUN apk --no-cache add iftop  
  
COPY .iftoprc /root/  
  
ENTRYPOINT ["/usr/sbin/iftop"]  

