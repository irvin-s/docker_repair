FROM ubuntu:16.04  
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8842ce5e && \  
echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main" \  
> /etc/apt/sources.list.d/bitcoin.list  
RUN apt-get update && \  
apt-get install -y bitcoind && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
ENV HOME /bitcoin  
VOLUME ["/bitcoin"]  
EXPOSE 8332 8333  
WORKDIR /bitcoin  
CMD bitcoind  

