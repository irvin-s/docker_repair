  
FROM ubuntu:14.04  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBCONF_NONINTERACTIVE_SEEN true  
RUN apt-get update  
RUN apt-get upgrade -y  
  
RUN apt-get install -y software-properties-common  
RUN add-apt-repository ppa:ethereum/ethereum-qt  
RUN add-apt-repository ppa:ethereum/ethereum  
RUN apt-get update  
RUN apt-get install -y cpp-ethereum  
  
ENTRYPOINT ["/usr/bin/eth"]  

