FROM alpine:latest  
  
MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"  
RUN apk update &&\  
apk add --update mysql-client  
  
# this can be overriden  
ENTRYPOINT ["/usr/bin/mysqldump"]  

