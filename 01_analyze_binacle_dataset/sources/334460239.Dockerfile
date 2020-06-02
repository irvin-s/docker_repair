FROM phusion/baseimage:0.10.0

# Expose mainnet ports (server, rpc)
EXPOSE 8333 8334

# Expose testnet ports (server, rpc)
EXPOSE 18333 18334

# Expose simnet ports (server, rpc)
EXPOSE 18555 18556

# Expose segnet ports (server, rpc)
EXPOSE 28901 28902

# Grab and install the latest version of roasbeef's fork of btcd and all
# related dependencies.

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
        apt-get install -y --no-install-recommends golang-1.8 screen git && \
        apt-get install -y --no-install-recommends -t jessie-backports jq && \
        rm -rf /var/lib/apt/lists/* && \
        go get -u github.com/Masterminds/glide

WORKDIR $GOPATH/src/github.com/roasbeef/btcd
RUN git clone https://github.com/roasbeef/btcd .
RUN glide install
RUN go install . ./cmd/...

RUN mkdir "/rpc" "/root/.btcd" "/root/.btcctl"
RUN touch "/root/.btcd/btcd.conf"

COPY container-files /

CMD ["/sbin/my_init"]
