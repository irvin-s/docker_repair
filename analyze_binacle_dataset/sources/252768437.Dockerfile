FROM golang:1.8.0-alpine  
WORKDIR /go/src/wait-for-service  
COPY main.go main.go  
RUN go install  
ENTRYPOINT ["wait-for-service"]  
  

