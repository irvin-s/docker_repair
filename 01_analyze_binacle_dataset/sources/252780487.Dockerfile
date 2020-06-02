FROM alpine  
MAINTAINER b3vis  
  
# upgrade & install packages  
RUN \  
apk upgrade --no-cache && \  
apk add --no-cache \  
lame \  
tmux \  
flac \  
python3  
# install build packages  
RUN \  
apk add --no-cache --virtual=build-dependencies \  
git \  
g++ \  
gcc \  
make && \  
# compile whatmp3  
cd /tmp && \  
git clone https://github.com/RecursiveForest/whatmp3 && \  
cd /tmp/whatmp3 && \  
make clean install && \  
# compile mktorrent  
cd /tmp && \  
git clone https://github.com/Rudde/mktorrent && \  
cd /tmp/mktorrent && \  
make clean install && \  
# cleanup  
apk del --purge \  
build-dependencies && \  
rm -rf \  
/tmp/* \  
/usr/lib/*.la  
#  
CMD ["/usr/local/bin/whatmp3","-h"]  

