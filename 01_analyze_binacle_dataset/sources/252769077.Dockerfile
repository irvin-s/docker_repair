FROM alpine:3.2  
RUN apk add --update postgresql-client && rm -rf /var/cache/apk/*  
  
CMD "sh"  

