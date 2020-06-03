FROM haskell  
  
RUN apt-get update && apt-get install -y \  
libncurses5-dev \  
curl \  
&& curl -sSL http://hledger.org/hledger-install.sh | bash  

