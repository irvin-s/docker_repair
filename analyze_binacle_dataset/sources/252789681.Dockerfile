FROM golang:latest as builder  
ENV HOME=/root  
COPY . /go/src/github.com/dvdmuckle/curl-a-joke  
RUN go get github.com/dvdmuckle/curl-a-joke  
FROM ubuntu:bionic  
COPY \--from=builder /go/bin/curl-a-joke /root/curl-a-joke  
ENV HOME=/root  
COPY jokes.json /root/  
WORKDIR "/root"  
ENTRYPOINT ["/root/curl-a-joke"]  

