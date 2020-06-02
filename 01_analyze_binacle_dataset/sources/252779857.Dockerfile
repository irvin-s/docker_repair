FROM golang:1.10 AS build  
  
WORKDIR /go/src/github.com/connesc/streamconv  
COPY . .  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
FROM gcr.io/distroless/base  
COPY \--from=build /go/bin/streamconv .  
ENTRYPOINT ["./streamconv"]  

