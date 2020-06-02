FROM golang:1.4.2-wheezy

RUN echo "deb-src http://httpredir.debian.org/debian wheezy main" >> /etc/apt/sources.list && \
    echo "deb-src http://httpredir.debian.org/debian wheezy-updates main" >> /etc/apt/sources.list && \
    apt-get -yqq update && \
    apt-get -yqq upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends \
      curl ruby ruby-dev build-essential git && \
    apt-get -y clean && \
    gem install fpm

RUN mkdir -p /package/root/ && \
    mkdir -p /package/root/usr/bin/ && \
    mkdir -p /package/root/etc/mesos-dns/ && \
    mkdir -p /package/root/etc/init/

RUN go get github.com/tools/godep

COPY Makefile /
COPY mesos-dns.init /package/
COPY mesos-dns.postinst /package/
COPY mesos-dns.postrm /package/

WORKDIR /

CMD ["make", "debian-wheezy"]
