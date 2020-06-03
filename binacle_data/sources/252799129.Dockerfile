FROM debian:8.0  
MAINTAINER andystanton  
ENV LANG C.UTF-8  
RUN apt-get update && \  
apt-get install -y patch mono-devel mono-runtime fsharp && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

