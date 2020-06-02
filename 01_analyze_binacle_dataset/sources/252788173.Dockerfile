FROM debian:9  
MAINTAINER CreepCat <Centra1C0re@hotmail.com>  
  
RUN cd / && apt-get update -qq && \  
apt-get install -y wget && apt-get clean && \  
wget https://bytecoin.org/static/files/bytecoin-linux.tar.gz && \  
mkdir bytecoin && \  
tar -xvf bytecoin-linux.tar.gz -C /bytecoin && \  
rm -rf bytecoin-linux.tar.gz && \  
cd bytecoin  
  
WORKDIR /bytecoind  
  
ENTRYPOINT ["./launch bytecoind"]  

