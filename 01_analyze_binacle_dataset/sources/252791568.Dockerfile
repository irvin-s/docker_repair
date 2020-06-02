FROM alpine:latest  
MAINTAINER Brendan Dahl <dahl.brendan@gmail.com>  
  
RUN apk --update --no-progress add nodejs unrar bash git  
  
WORKDIR /root  

