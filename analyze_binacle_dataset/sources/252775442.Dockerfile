FROM alpine:3.3  
MAINTAINER Bernhard Mayr  
RUN apk update && apk add docker  
CMD sh  

