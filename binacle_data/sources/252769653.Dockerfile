FROM ubuntu:16.04  
  
ENV VERSION 0.16.2  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get install -y --no-install-recommends \  
ca-certificates \  
software-properties-common \  
wget && \  
add-apt-repository ppa:bitcoin-abc/ppa && \  
apt-get update && \  
apt-get install -y --no-install-recommends bitcoind && \  
apt-get purge -y software-properties-common && \  
apt-get autoremove -y && \  
apt-get autoclean -y && \  
apt-get clean  
  
VOLUME ["/root"]  
  
EXPOSE 8332 8333 18332 18333  
  
CMD ["/usr/bin/bitcoind", "-printtoconsole"]  

