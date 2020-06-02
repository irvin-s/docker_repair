FROM golang
MAINTAINER yida
WORKDIR /go/src/
COPY . ./okex
EXPOSE 80
VOLUME /go/src/okex/log
CMD ["/bin/bash", "/go/src/okex/script/build.sh"]