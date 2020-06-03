FROM golang as builder  
WORKDIR /go/src/github.com/ancientlore/webnull  
ADD . .  
WORKDIR /go/src/github.com/ancientlore/webnull  
RUN CGO_ENABLED=0 GOOS=linux go get .  
RUN CGO_ENABLED=0 GOOS=linux go install  
  
FROM scratch  
WORKDIR /go  
COPY \--from=builder /go/bin/webnull /go/bin/webnull  
  
ENTRYPOINT ["/go/bin/webnull", "-addr", ":8080"]  
  
EXPOSE 8080  

