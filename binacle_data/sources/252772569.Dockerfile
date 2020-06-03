FROM gliderlabs/alpine:3.4  
RUN apk update && apk add openssh-client  
  
ENTRYPOINT ["ssh"]  

