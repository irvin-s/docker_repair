FROM alpine:latest  
RUN apk update && apk add git openssh  
  
WORKDIR /tmp  
  
ENTRYPOINT [ "sh" ]  

