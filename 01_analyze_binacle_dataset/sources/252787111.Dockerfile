FROM golang:alpine  
  
ADD build.sh /build.sh  
ADD start.sh /start.sh  
RUN chmod +x /build.sh /start.sh  
  
RUN mkdir /data  
RUN apk add --update bash && \  
/build.sh && \  
rm -rf /var/cache/apk/* /build.sh  
  
ENTRYPOINT ["/start.sh"]  
  
EXPOSE 7659 7651 7653 7650  
VOLUME ["/data"]  

