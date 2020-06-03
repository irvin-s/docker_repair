FROM ethereum/client-go  
  
COPY genesis.json /root/genesis.json  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
git-core \  
curl \  
ca-certificates \  
&& curl -sL https://deb.nodesource.com/setup_4.x | bash - \  
&& apt-get install -y --no-install-recommends \  
nodejs \  
build-essential \  
&& cd /root \  
&& git clone https://github.com/cubedro/eth-net-intelligence-api \  
&& cd eth-net-intelligence-api \  
&& npm install \  
&& npm install -g pm2  
  
COPY app.json /root/eth-net-intelligence-api/app.json  
  
EXPOSE 8545  
EXPOSE 30303  
EXPOSE 30301/udp  
  
ENTRYPOINT ["/entrypoint.sh"]  

