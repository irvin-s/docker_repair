FROM jenkins:latest  
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>  
  
LABEL Description="Jenkins container with docker.io binary" \  
Vendor="ACME Products" \  
Version="1.0"  
  
USER root  
  
RUN set -e; \  
wget -qO- \  
https://releases.rancher.com/cli/v0.4.1/rancher-linux-amd64-v0.4.1.tar.gz \  
| tar xzv \  
-C /usr/local/bin \  
\--strip-components=2; \  
wget -qO- \  
https://get.docker.com/builds/Linux/x86_64/docker-1.13.0.tgz \  
| tar xzv \  
-C /usr/local/bin \  
\--strip-components=1;  
  

