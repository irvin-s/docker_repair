FROM phusion/baseimage:0.10.0

# Force Go to use the cgo based DNS resolver. This is required to ensure DNS
# queries required to connect to linked containers succeed.
ENV GODEBUG netdns=cgo
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/lib/go-1.8/bin:$PATH

# Install glide to manage vendor.
RUN   mkdir /go && \
        add-apt-repository ppa:gophers/archive && \
        echo 'deb http://ftp.debian.org/debian jessie-backports main' | tee /etc/apt/sources.list.d/jessie-backports.list && \
        apt-key adv --recv-key --keyserver hkp://keyserver.ubuntu.com:80 8B48AD6246925553 && \
        apt-get update && \
        apt-get install -y --no-install-recommends golang-1.9 golang-1.9-race-detector-runtime screen git build-essential && \
        apt-get install -y --no-install-recommends -t jessie-backports jq && \
        rm -rf /var/lib/apt/lists/* && \
        go get -u github.com/Masterminds/glide

# Grab and install the latest version of lnd and all related dependencies.
RUN git clone https://github.com/bajohns/lnd $GOPATH/src/github.com/lightningnetwork/lnd \
  && cd $GOPATH/src/github.com/lightningnetwork/lnd \
  && git checkout alive-0.2

# Make lnd folder default.
WORKDIR $GOPATH/src/github.com/lightningnetwork/lnd

# Install dependency and install/build lnd.
RUN glide install && go build -race && go install -race . ./cmd/...

ADD container-files /

ENV LND_HOME /root/.lnd
# Expose lnd ports (server, rpc).
EXPOSE 9735 10009

RUN mkdir /rpc

CMD ["/sbin/my_init"]
