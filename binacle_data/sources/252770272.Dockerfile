From ubuntu:15.10  
RUN apt-get update && apt-get install -y software-properties-common  
RUN apt-add-repository -y ppa:bitcoin/bitcoin  
Run apt-get update  
  
RUN apt-get install -y bitcoind  
  
EXPOSE 8332 8333 18332 18333  
VOLUME /root/.bitcoin  
  
CMD ["bitcoind", "-regtest", "-printtoconsole"]  

