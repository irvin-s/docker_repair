FROM ubuntu:14.04  
  
RUN \  
apt-get update -yq && \  
apt-get install -yq \  
build-essential \  
git \  
libsqlite3-dev \  
libprotobuf-dev \  
protobuf-compiler && \  
apt-get clean && \  
rm -rf /var/lib/apt  
  
RUN \  
git clone https://github.com/mapbox/tippecanoe.git && \  
cd tippecanoe && \  
make && \  
make install  

