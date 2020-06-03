FROM calmcacil/baseimage  
MAINTAINER Calmcacil  
  
# Install some important libs.  
RUN apt-get install -y \  
lib32stdc++6 && \  
# fetch and unpack AMP files  
curl -o \  
/tmp/ampinstmgr.zip -L \  
http://cubecoders.com/Downloads/ampinstmgr.zip && \  
unzip -q /tmp/ampinstmgr.zip -d /opt/amp && \  
  
# cleanup  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
# copy local files  
COPY root/ /  
  
# volumes  
VOLUME /amp  

