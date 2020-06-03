FROM qfarm/gometalinters:latest

ADD . /go/src/github.com/qfarm/qfarm

WORKDIR /go/src/github.com/qfarm/qfarm

RUN go get github.com/qfarm/qfarm/cmd/worker

EXPOSE 8080
CMD /go/bin/worker --config-path=/go/src/github.com/qfarm/qfarm/config/worker.toml
