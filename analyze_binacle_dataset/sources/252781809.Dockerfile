FROM ubuntu:14.04  
MAINTAINER Chris McKinnel <chrismckinnel@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
software-properties-common \  
\--no-install-recommends && \  
add-apt-repository ppa:tomahawk/ppa && \  
apt-get update && \  
apt-get install -y \  
tomahawk  
  
ENTRYPOINT [ "/usr/bin/tomahawk" ]

