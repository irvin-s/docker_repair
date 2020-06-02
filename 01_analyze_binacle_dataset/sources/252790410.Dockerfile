# build stage  
FROM golang:1.9.2 AS build-env  
ADD . /src  
RUN cd /src && \  
go get -d -v k8s.io/apimachinery/pkg/api/errors \  
k8s.io/apimachinery/pkg/apis/meta/v1 \  
k8s.io/client-go/kubernetes \  
k8s.io/client-go/rest && \  
CGO_ENABLED=0 GOOS=linux go build -o goapp  
  
# final stage  
FROM alpine  
WORKDIR /app  
COPY \--from=build-env /src/goapp /app/  
ENTRYPOINT ./goapp  

