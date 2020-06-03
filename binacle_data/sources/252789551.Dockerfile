FROM ubuntu:16.04  
LABEL maintainer "Brian Hewitt <durendal@durendals-domain.com>"  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
git \  
build-essential \  
libssl-dev \  
libdb++-dev \  
libboost-all-dev \  
ca-certificates \  
qt5-default \  
qt5-qmake \  
qtbase5-dev-tools \  
qttools5-dev-tools \  
make  
  
RUN \  
git clone https://github.com/rubycoinorg/rubycoin.git && \  
cd rubycoin && \  
qmake USE_UPNP=- && \  
make && \  
mv rubycoin-qt /usr/local/bin && \  
cd .. && \  
rm -rf rubycoin  
  
RUN apt-get remove --purge -y \  
git \  
qt5-default \  
qt5-qmake \  
build-essential \  
ca-certificates \  
qtbase5-dev-tools \  
qttools5-dev-tools \  
libssl-dev \  
libdb++-dev \  
libboost-all-dev \  
make  
  
VOLUME ["/rubycoin"]  
  
EXPOSE 5937 5938  
COPY ["bin", "/usr/local/bin/"]  
COPY ["docker-entrypoint.sh", "/usr/local/bin/"]  
  
ENTRYPOINT ["docker-entrypoint.sh"]  

