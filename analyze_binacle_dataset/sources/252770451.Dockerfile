FROM debian:stretch  
  
RUN set -ex; \  
apt-get update; \  
apt-get install -y --no-install-recommends \  
ca-certificates \  
curl \  
build-essential \  
debhelper \  
devscripts \  
fakeroot; \  
rm -rf /var/lib/apt/lists/*  

