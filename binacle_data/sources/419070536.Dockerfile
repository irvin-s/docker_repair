FROM golang:1.10 as builder
RUN mkdir /build 
ADD . /build/
WORKDIR /build 
RUN go get -u github.com/Azure/azure-k8s-metrics-adapter 
WORKDIR $GOPATH/src/github.com/Azure/azure-k8s-metrics-adapter/samples/servicebus-queue/
RUN go get -u github.com/Azure/azure-service-bus-go && make
FROM frolvlad/alpine-bash
COPY --from=builder /go/src/github.com/Azure/azure-k8s-metrics-adapter/samples/servicebus-queue/bin/producer /app/
WORKDIR /app
CMD ["./producer"]

