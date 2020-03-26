#  
# Creates a foundation container for Hugo on Alpine Linux  
#  
FROM alpine  
MAINTAINER Randolph Kahle "randolph.kahle@databliss.net"  
RUN apk update && apk add git  
  
COPY hugo /usr/local/bin/hugo  

