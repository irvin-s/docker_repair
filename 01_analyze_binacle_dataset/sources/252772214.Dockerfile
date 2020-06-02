# This dockerfile is used to run the autostew webserver  
FROM autostew/base  
Maintainer Michael Wittig <witmic1@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY dependencies.sh dependencies.sh  
RUN ./dependencies.sh

