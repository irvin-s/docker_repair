FROM golang:1.6.2

## checkout etcd
ARG ETCD_COMMIT=d32113a0e53f6bc44e4a20afb57bcbdb472a9002
RUN (mkdir -p $GOPATH/src/github.com/coreos && \
  cd $GOPATH/src/github.com/coreos && \
  git clone https://github.com/coreos/etcd && \
  cd etcd && \
  git checkout $ETCD_COMMIT)
WORKDIR $GOPATH/src/github.com/coreos/etcd

## initialize ./gopath
RUN rm -f gopath/src && mkdir -p gopath && ln -s $(pwd)/cmd/vendor gopath/src

## copy GoReplay to ./gopath
RUN mkdir -p gopath/src/github.com/AkihiroSuda
ADD . gopath/src/github.com/AkihiroSuda/go-replay
RUN ls -l gopath/src/github.com/AkihiroSuda
ADD ./example/etcd-5155/replay-etcd-5155.patch ./
RUN git apply replay-etcd-5155.patch

## build
RUN GOPATH=$(pwd)/gopath go test -race -c github.com/coreos/etcd/integration

## entrypoint
ENV GRMAX 1000ms
ENV GOMAXPROCS 1
ENTRYPOINT ./integration.test -test.v -test.run TestIssue2746
