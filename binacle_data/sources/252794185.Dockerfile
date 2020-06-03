FROM alpine:latest  
MAINTAINER William Weiskopf <william@weiskopf.me>  
  
RUN apk add --no-cache \  
borgbackup  
  
ENTRYPOINT ["borg"]  
  

