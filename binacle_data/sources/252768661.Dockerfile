FROM golang as builder  
WORKDIR /go/src/github.com/ancientlore/hashsrv  
ADD . .  
WORKDIR /go/src/github.com/ancientlore/hashsrv/cmd/hashsrv  
RUN CGO_ENABLED=0 GOOS=linux go get .  
RUN CGO_ENABLED=0 GOOS=linux go install  
  
FROM scratch  
WORKDIR /go  
ADD hashsrv.config /go/etc/hashsrv.config  
COPY \--from=builder /go/bin/hashsrv /go/bin/hashsrv  
  
ENTRYPOINT ["/go/bin/hashsrv", "-run"]  
  
EXPOSE 9009  

