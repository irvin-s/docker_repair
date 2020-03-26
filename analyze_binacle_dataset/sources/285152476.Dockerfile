FROM golang:latest
ADD . /go/src/github.com/huawei-microservice-demo/mesher-example/client
WORKDIR /go/src/github.com/huawei-microservice-demo/mesher-example/client
RUN go get github.com/tedsuo/rata
RUN go install github.com/huawei-microservice-demo/mesher-example/client
ENTRYPOINT /go/bin/client
EXPOSE 3000
