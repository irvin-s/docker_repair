FROM golang:latest
ADD . /go/src/github.com/huawei-microservice-demo/mesher-example/server
WORKDIR /go/src/github.com/huawei-microservice-demo/mesher-example/server
RUN go get github.com/tedsuo/rata
RUN go install github.com/huawei-microservice-demo/mesher-example/server
ENTRYPOINT /go/bin/server
EXPOSE 3000
