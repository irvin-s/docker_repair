FROM lsiobase/ubuntu:xenial  
  
ARG BUILD_DATE  
ARG VERSION  
LABEL build_version="Build-version:- ${VERSION} Build-date:- ${BUILD_DATE}"  
LABEL maintainer="corytire"  
  
RUN \  
apt-get update && \  
apt-get install -y \  
ffmpeg \  
atomicparsley \  
python-dev \  
python-pip && \  
pip install --upgrade pip && \  
pip install --upgrade virtualenv && \  
pip install --no-cache-dir -U \  
pycryptodomex \  
youtube-dl && \  
apt-get clean && \  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
VOLUME /youtube /config  

