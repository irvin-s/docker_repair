FROM ubuntu:16.04  
MAINTAINER Dan Leehr "dan.leehr@duke.edu"  
ENV DEBIAN_FRONTEND noninteractive  
  
WORKDIR /tmp  
  
RUN apt-get update && \  
apt-get install -y \  
zlib1g-dev \  
build-essential \  
curl  
  
### Install bwa  
ENV VERSION 0.7.12  
ENV NAME bwa  
ENV URL "https://github.com/lh3/bwa/archive/${VERSION}.tar.gz"  
RUN curl -SL $URL | tar -zxv && \  
cd ${NAME}-${VERSION} && \  
make -j 4 && \  
cd .. && \  
cp ./${NAME}-${VERSION}/${NAME} /usr/local/bin/ && \  
strip /usr/local/bin/${NAME}; true && \  
rm -rf ./${NAME}-${VERSION}/  

