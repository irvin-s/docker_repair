FROM ubuntu  
  
Maintainer Jason Carver <ut96caarrs@snkmail.com>  
  
RUN apt-get update  
RUN apt-get install -y software-properties-common  
RUN add-apt-repository -y ppa:ethereum/ethereum  
RUN add-apt-repository -y ppa:ethereum/ethereum-dev  
RUN apt-get update  
RUN apt-get install -y geth  
  

