FROM lsiobase/xenial  
MAINTAINER ChiefN  
  
run apt-get update && \  
apt-get -y install libboost-all-dev && \  
apt-get -y upgrade  
  
# cleanup  
RUN apt-get clean && \  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*

