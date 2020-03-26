FROM alpine:3.3  
  
# forcing rebuild of ajces docker images  
RUN apk update && apk upgrade  

