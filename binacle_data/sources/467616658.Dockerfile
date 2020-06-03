FROM golang AS build

RUN mkdir -p /go/src/enbase
WORKDIR /go/src/enbase
COPY . .
RUN curl -L -s https://github.com/golang/dep/releases/download/v0.3.1/dep-linux-amd64 -o $GOPATH/bin/dep
RUN chmod +x $GOPATH/bin/dep
RUN $GOPATH/bin/dep ensure
RUN go build -ldflags "-linkmode external -extldflags -static" enbase

FROM rabbitmq:3.7
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get install --allow-unauthenticated -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*
VOLUME ["/data/db"]
WORKDIR /data
EXPOSE 15671 15672 27017 28017
COPY --from=build /go/src/enbase/enbase /enbase
CMD ["screen rabbitmq-server && mongod && /enbase"]
