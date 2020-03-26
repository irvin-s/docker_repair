FROM beevelop/cordova  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
# @todo: CORCI_VERSION  
ENV CORCI_NAME Larry  
  
COPY cmd.sh /sbin/corci.sh  
  
WORKDIR /data  
# buildDeps are required for npm installation process  
RUN buildDeps='build-essential g++ python make'; \  
set -x && \  
apt-get update && apt-get install -y $buildDeps \--no-install-recommends && \  
apt-get install -y git p7zip-full && \  
npm i -g --unsafe-perm beevelop/corci-android && \  
chmod 755 /sbin/corci.sh && \  
  
# clean up  
rm -rf /var/lib/apt/lists/* && \  
apt-get purge -y --auto-remove $buildDeps && \  
apt-get autoremove -y && \  
apt-get clean  
  
CMD /sbin/corci.sh  
  
VOLUME ["/data", "/builds"]  

