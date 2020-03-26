FROM golang:latest as builder  
RUN go get github.com/davidscholberg/irkbot  
FROM ubuntu:latest  
ENV HOME=/root  
COPY \--from=builder /go/bin/irkbot /root/irkbot  
ENTRYPOINT ["/root/irkbot"]  

