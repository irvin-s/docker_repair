FROM golang:1.11
WORKDIR /go/src/gosrc.io/mqtt
RUN curl -o codecov.sh -s https://codecov.io/bash && chmod +x codecov.sh
COPY . ./
# RUN go get -t  ./...
