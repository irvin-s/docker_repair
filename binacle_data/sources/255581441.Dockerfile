FROM golang:1.7

ADD Makefile /
WORKDIR /
RUN make setup

ADD ./voting-app/main.go /go/src/github.com/ordina-jworks/prometheus-demo/voting-app/main.go
ADD ./voting-generator/main.go /go/src/github.com/ordina-jworks/prometheus-demo/voting-generator/main.go
ADD ./alert-console/main.go /go/src/github.com/ordina-jworks/prometheus-demo/alert-console/main.go

RUN make build-go

CMD ["/bin/bash"]
