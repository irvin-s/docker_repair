FROM ubuntu
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y golang git
RUN mkdir $HOME/go
ENV GOPATH $HOME/go
RUN echo 'export GOPATH="$HOME/go"' >> ~/.profile
RUN mkdir -p $GOPATH/src/github.com/ethereum
WORKDIR $GOPATH/src/github.com/ethereum
RUN git clone https://github.com/ethereum/go-ethereum.git
WORKDIR $GOPATH/src/github.com/ethereum/go-ethereum
RUN git checkout master
RUN echo $GOPATH
RUN go get github.com/ethereum/go-ethereum
RUN go build ./cmd/bzzd
RUN go build ./cmd/geth
RUN ./geth account list
RUN touch password
RUN echo -n password > ./password
RUN cat ./password
CMD echo $PASSWORD | ./bzzd --bzzaccount=$BZZACCOUNT
