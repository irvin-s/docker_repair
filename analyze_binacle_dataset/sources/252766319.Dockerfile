FROM justcontainers/base-alpine  
MAINTAINER tynor88 <tynor@hotmail.com>  
  
RUN apk add --no-cache socat parallel  
  
COPY /root /  

