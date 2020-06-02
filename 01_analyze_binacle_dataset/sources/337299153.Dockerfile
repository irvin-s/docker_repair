FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV GOROOT /opt/go
ENV GOPATH $HOME/.golang
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin
ENV VERSION v0-alpha.42

RUN apt-get update
RUN apt-get install -y curl git-core make gcc
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN cd /opt && curl -LO https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz
RUN cd /opt && tar xvfs go1.9.4.linux-amd64.tar.gz
RUN rm /opt/go1.9.4.linux-amd64.tar.gz

RUN go get -d github.com/ganggo/ganggo
WORKDIR $GOPATH/src/github.com/ganggo/ganggo

RUN make install
RUN make precompile

COPY start.sh /start.sh
COPY app.conf $GOPATH/src/github.com/ganggo/ganggo/conf/app.conf

CMD ["/bin/bash", "/start.sh"]
