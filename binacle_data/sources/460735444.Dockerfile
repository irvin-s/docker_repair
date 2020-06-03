FROM ubuntu
RUN apt-get update;apt-get -y install golang git
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin
RUN mkdir -p /go/bin
WORKDIR /go
ADD nats-ping.go /go/
RUN go get |  true
RUN go build nats-ping.go
RUN chmod +x /go/nats-ping
CMD ./nats-ping
