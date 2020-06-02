FROM golang:alpine as builder  
  
#disable crosscompiling  
ENV CGO_ENABLED=0  
#compile linux only  
ENV GOOS=linux  
  
RUN apk add --update bash curl git  
  
RUN go get github.com/linkedin/Burrow \  
github.com/golang/dep/cmd/dep  
  
WORKDIR $GOPATH/src/github.com/linkedin/Burrow  
  
RUN dep ensure && go install && mkdir -p /etc/burrow/  
  
ADD ./ /etc/burrow/  
WORKDIR /etc/burrow/  
  
FROM alpine  
WORKDIR /etc/burrow/  
COPY \--from=builder /etc/burrow/ .  
COPY \--from=builder /go/bin/Burrow .  
CMD ["./Burrow", "--config-dir", "configs"]  

