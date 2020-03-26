FROM ubuntu:14.04.3

RUN apt-get -yqq update && \
    apt-get -yqq upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -yqq install --no-install-recommends \
      curl ruby ruby-dev build-essential git && \
    apt-get -y clean && \
    gem install fpm

ENV GOLANG_VERSION 1.4.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz
ENV GOLANG_DOWNLOAD_SHA1 460caac03379f746c473814a65223397e9c9a2f6

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA1  golang.tar.gz" | sha1sum -c - \
	&& tar -C /usr/src -xzf golang.tar.gz \
	&& rm golang.tar.gz \
	&& cd /usr/src/go/src && ./make.bash --no-clean 2>&1

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/src/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN mkdir -p /package/root/ && \
    mkdir -p /package/root/usr/bin/ && \
    mkdir -p /package/root/etc/mesos-dns/ && \
    mkdir -p /package/root/etc/init/

RUN go get github.com/tools/godep

COPY Makefile /
COPY mesos-dns.conf /package/root/etc/init/

WORKDIR /

CMD ["make", "ubuntu-trusty"]
