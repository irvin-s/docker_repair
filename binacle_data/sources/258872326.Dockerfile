# Quagga BGP

FROM ubuntu:trusty

MAINTAINER FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

RUN apt-get update
RUN apt-get install -qy --no-install-recommends supervisor quagga telnet tcpdump wget git ca-certificates build-essential

RUN wget --no-check-certificate -O go.tgz https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz &&\
    tar -C /usr/local -xzf go.tgz &&\
    rm go.tgz

RUN sed -i 's/bgpd=no/bgpd=yes/g' /etc/quagga/daemons
RUN sed -i 's/zebra=no/zebra=yes/g' /etc/quagga/daemons

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

ENTRYPOINT ["/usr/bin/supervisord"]
