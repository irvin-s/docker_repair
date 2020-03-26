FROM alpine:latest  
  
RUN apk add --no-cache strongswan dumb-init  
  
COPY entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  

