FROM ubuntu:16.04  
  
RUN apt-get update && \  
apt-get install -y \  
autoconf \  
automake \  
build-essential \  
curl \  
libssl-dev \  
libtool \  
texinfo \  
pkg-config \  
python \  
unzip \  
zlib1g-dev && \  
rm -rf /var/lib/apt/lists/* && \  
mkdir /working /source /output  
  
ENTRYPOINT ["make", "-C", "/source", \  
"WORKING=/working", \  
"OUTPUT=/output"]  

