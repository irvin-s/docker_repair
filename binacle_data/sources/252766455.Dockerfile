FROM abstracttechnology/webapp:latest  
MAINTAINER Giorgio Borelli <giorgio.borelli@abstract.it>  
  
ENV DEBIAN_FRONTEND noninteractive  
USER root  
  
RUN \  
apt-get update && \  
apt-get install -y curl && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -y nodejs && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
USER webapp  

