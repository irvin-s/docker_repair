FROM develar/java  
MAINTAINER Rafael Cortês <rafael@codacy.com>  
  
RUN apk update && \  
apk add bash git openssh && \  
echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \  
git config --global core.quotepath false && \  
git config --global core.packedGitLimit 512m && \  
git config --global core.packedGitWindowSize 512m && \  
git config --global pack.deltaCacheSize 2047m && \  
git config --global pack.packSizeLimit 2047m && \  
git config --global pack.windowMemory 2047m && \  
rm -rf /var/cache/apk/*  
  
ENV LANG en_US.utf8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.utf8  

