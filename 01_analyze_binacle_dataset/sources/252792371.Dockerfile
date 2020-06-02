FROM golang:1.6  
  
RUN apt-get install git  
RUN export GOPATH=$HOME/go \  
&& go get github.com/ethereum/ethash \  
&& go get github.com/ethereum/go-ethereum/common \  
&& go get github.com/gorilla/mux \  
&& go get gopkg.in/redis.v3 \  
&& go get github.com/yvasiyarov/gorelic  
  
RUN export GOPATH=$HOME/go \  
&& git clone https://github.com/sammy007/open-ethereum-pool.git \  
&& cd open-ethereum-pool \  
&& go build -o ether-pool main.go  
  
WORKDIR open-ethereum-pool  
  
ADD ./startup.sh .  
RUN chmod +x ./startup.sh  
  
ENTRYPOINT ["./startup.sh"]  
  

