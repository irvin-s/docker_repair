FROM golang:1.10-alpine

RUN apk add --no-cache curl git gcc make musl-dev linux-headers 

RUN curl -L -o /usr/bin/solc https://github.com/ethereum/solidity/releases/download/v0.4.17/solc-static-linux && chmod +x /usr/bin/solc

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN go get -d github.com/ethereum/go-ethereum
RUN go install github.com/ethereum/go-ethereum/cmd/abigen

RUN echo $GOPATH
# run the codegen
ENTRYPOINT ["/bin/sh","/tools/abigen/docker_run.sh"]
CMD ["run"]
