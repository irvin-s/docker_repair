FROM node:8  
MAINTAINER Aaronstar McClure <Jfeldt19@gmail.com>  
  
RUN apt update \  
&& apt upgrade -y \  
&& apt install -y curl ca-certificates openssl git tar bash sqlite \  
&& adduser -h /home/container container  
  
USER container  
ENV USER=container HOME=/home/container  
  
WORKDIR /home/container  
  
COPY ./entrypoint.sh /entrypoint.sh  
  
CMD ["/bin/bash", "/entrypoint.sh"]  

