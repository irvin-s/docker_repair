FROM ubuntu:xenial

RUN apt-get update && apt-get install -y golang-1.10 git

ENV GOLANG_VERSION 1.10

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/lib/go-1.10/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# Expose lnd ports (server, rpc).
EXPOSE 9735 8080 10009

RUN git config --global user.email "robot@docker.io"
RUN git config --global user.name "DockRob"
RUN git clone https://github.com/lightningnetwork/lnd $GOPATH/src/github.com/lightningnetwork/lnd
RUN echo $GOPATH
WORKDIR $GOPATH/src/github.com/lightningnetwork/lnd
RUN git checkout v0.5-beta

# Make lnd folder default.

RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure
RUN go install . ./cmd/...

RUN rm -rf $GOPATH/src

RUN apt-get purge -y golang-1.10 git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["lnd"]
