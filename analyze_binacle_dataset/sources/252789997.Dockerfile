FROM alpine:3.4  
RUN apk add --update curl && \  
rm -rf /var/cache/apk/*  
  
COPY curl-wrapper.sh /usr/bin/  
RUN chmod +x /usr/bin/curl-wrapper.sh  
  
WORKDIR "/home"  
  
ENTRYPOINT ["/usr/bin/curl-wrapper.sh"]  

