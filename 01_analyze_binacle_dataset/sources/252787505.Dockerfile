FROM alpine:3.2  
ADD buckettest.sh /usr/local/bin/  
  
RUN chmod 755 /usr/local/bin/* && \  
apk update && \  
apk add bash curl drill && \  
rm -rf /var/cache/apk/* && \  
rm -rf /tmp/* && \  
rm -rf /var/tmp/*  
  
ENTRYPOINT [ "/usr/local/bin/buckettest.sh" ]  

