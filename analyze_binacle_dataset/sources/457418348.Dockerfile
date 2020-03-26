FROM golang:1.12-stretch
RUN apt-get update
RUN apt-get install python3-pip -y

RUN pip3 install --upgrade pip
RUN pip install pytest pytest-sugar
RUN pip install git+git://github.com/jonathanlloyd/pyborg.git

RUN curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.16.0
