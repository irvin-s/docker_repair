FROM golang as builder  
WORKDIR /go/src/github.com/ancientlore/served  
ADD . .  
RUN CGO_ENABLED=0 GOOS=linux go get .  
RUN CGO_ENABLED=0 GOOS=linux go install  
  
FROM alpine:latest  
WORKDIR /go  
ADD demo.config /go/etc/served.config  
ADD . /go/src/github.com/ancientlore/served  
COPY \--from=builder /go/bin/served /go/bin/served  
  
ENTRYPOINT ["/go/bin/served", "-run"]  
  
EXPOSE 8000  

