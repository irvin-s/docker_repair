FROM alpine:3.7  
MAINTAINER jbo <jbo@oxalide.com>  
  
ARG SPEED=1  
RUN apk add --no-cache bash gawk sed grep bc coreutils  
ENV SPEED 1  
COPY echo.sh /  
  
RUN chmod +x echo.sh  
  
ENTRYPOINT ["/bin/bash", "-c", "./echo.sh"]  

