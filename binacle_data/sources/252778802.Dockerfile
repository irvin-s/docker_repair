FROM alpine:latest  
  
RUN apk --update add socat  
  
ENTRYPOINT ["socat"]  

