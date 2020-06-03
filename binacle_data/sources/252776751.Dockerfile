FROM golang:1.8  
MAINTAINER cblomart@gmail.com  
  
RUN apt-get update && apt-get install -y \  
musl \  
musl-tools \  
upx-ucl \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

