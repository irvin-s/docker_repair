FROM alpine:3.6  
RUN apk add --update curl && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT [ "curl" ]  

