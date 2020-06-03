FROM ubuntu:xenial  
LABEL maintainer="Akira Koyasu <mail@akirakoyasu.net>"  
  
RUN apt-get update && apt-get install -y \  
apt-transport-https \  
ca-certificates \  
curl \  
iproute2 \  
vim-tiny \  
\--no-install-recommends \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /src/*.deb  

