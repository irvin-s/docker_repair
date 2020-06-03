# build stage  
FROM golang:alpine AS build-env  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash git openssh  
RUN go get github.com/Shopify/sarama  
ADD . /src  
RUN cd /src && CGO_ENABLED=0 GOOS=linux go build -o kafka-http-config  
  
# final stage  
FROM centurylink/ca-certs  
COPY \--from=build-env /src/kafka-http-config /  
ADD config /  
ENTRYPOINT ["/kafka-http-config"]  

