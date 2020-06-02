FROM python:3.4

ENV GOOGLER_GIT_URL https://github.com/jarun/googler/
ENV GO_VERSION 1.7.3

VOLUME /gopath

COPY ./go1.7.3.linux-amd64.tar.gz /tmp/

RUN git clone $GOOGLER_GIT_URL && \
    cd googler/ && \
    make install

RUN tar -C /usr/local -xzf /tmp/go$GO_VERSION.linux-amd64.tar.gz && \
    mkdir /gopath/src && \
    mkdir /gopath/bin && \
    mkdir /gopath/lib 

ENV GOPATH /gopath
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

COPY ./cow /etc/init.d/

ENV COW_INSTALLDIR /usr/local/bin

RUN curl -L git.io/cow | bash &&\
    chmod u+x /etc/init.d/cow &&\
    update-rc.d cow defaults

CMD bee run $GOPATH/src/github.com/xzdbd/api
