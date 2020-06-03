FROM golang:1.4.2
MAINTAINER kuizhi.feng

################### prepare      ##################
ADD ./codis-deps ./conf/codis /project/

################### install codis ##################
RUN \
    mkdir -p /etc/codis && \
    mv /project/codis.default.conf   /etc/codis/config.ini  && \
    mv /project  $GOPATH/src/github.com/ && \
    cd $GOPATH/src/github.com/wandoulabs/codis && \
    make && \
    make gotest
