FROM alpine:3.2  
RUN apk add --update cdrkit && rm -rf /var/cache/apk/*  
  
COPY run.sh /  
RUN chmod +x /run.sh  
  
VOLUME /config  
  
ENTRYPOINT ["./run.sh"]  

