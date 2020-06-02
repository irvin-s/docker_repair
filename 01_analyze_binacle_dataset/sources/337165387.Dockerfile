FROM golang


WORKDIR /ethereum_proxy

ADD . /ethereum_proxy

ENV GOPATH=/ethereum_proxy
ENV PATH=$PATH:/$GOPATH/.bin

WORKDIR /ethereum_proxy/src


#RUN go get -v ./...
# run the rpc server

ENTRYPOINT ["/bin/bash","/ethereum_proxy/docker_run.sh"] 
CMD ["run"]
