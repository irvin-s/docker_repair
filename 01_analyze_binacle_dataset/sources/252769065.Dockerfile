FROM ubuntu:16.04  
MAINTAINER Andrey Andreev <andyceo@yandex.ru> (@andyceo)  
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
VOLUME /root  
ENTRYPOINT ["/usr/bin/bitcoind", "-printtoconsole"]  
HEALTHCHECK \--interval=5m \--timeout=1m \  
CMD bitcoin-cli getinfo || exit 1  

