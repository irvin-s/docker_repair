FROM docker/compose:1.7.0  
MAINTAINER Andrew Jones <andrew@andrew-jones.com>  
  
# Install Git and SSH  
RUN apk add --no-cache git openssh  

