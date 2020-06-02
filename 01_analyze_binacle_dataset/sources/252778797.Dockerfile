FROM debian:jessie  
MAINTAINER David M. Lee, II <leedm777@yahoo.com>  
  
RUN apt-get update -qq && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y --no-install-recommends genisoimage && \  
apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*  
  
WORKDIR /data  
ENTRYPOINT ["/usr/bin/genisoimage"]  

