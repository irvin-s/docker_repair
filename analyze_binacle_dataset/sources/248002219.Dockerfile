FROM python:3.4

ENV GOOGLER_GIT_URL https://github.com/jarun/googler/
ENV GO_VERSION 1.7.3

VOLUME /gopath

ADD https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz /tmp/

RUN git clone $GOOGLER_GIT_URL && \
    cd googler/ && \
    make install

RUN tar -C /usr/local -xvfz /tmp/go$GO_VERSION.linux-amd64.tar.gz && \
    export PATH=$PATH:/usr/local/go/bin && \
    mkdir /gopath/src && \
    mkdir /gopath/bin && \
    mkdir /gopath/lib && \
    export GOPATH=/gopath

CMD /bin/bash
