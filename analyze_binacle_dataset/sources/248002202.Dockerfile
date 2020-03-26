FROM python:3.4

ENV GOOGLER_GIT_URL https://github.com/jarun/googler/
ENV GO_VERSION 1.7.3
ENV GO_URL https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz

ADD $GO_URL /tmp/

RUN git clone $GOOGLER_GIT_URL &&\
    cd googler/ &&\
    make install

RUN tar -C /usr/local -xzf /tmp/go$GO_VERSION.linux-amd64.tar.gz &&\
	mkdir /gopath &&\
    mkdir /gopath/src &&\
    mkdir /gopath/bin &&\
    mkdir /gopath/lib &&\
    rm -f /tmp/go$GO_VERSION.linux-amd64.tar.gz

ENV GOPATH /gopath
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

RUN go get -u github.com/xzdbd/api &&\
	go get -u github.com/beego/bee
	
EXPOSE 8098

CMD bee run $GOPATH/src/github.com/xzdbd/api
