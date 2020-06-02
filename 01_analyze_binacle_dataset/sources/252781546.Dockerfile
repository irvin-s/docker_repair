FROM golang:1.9.2-alpine3.7  
RUN apk add --no-cache git mercurial  
ADD . /go/src/github.com/banzaicloud/drone-plugin-zeppelin-client  
WORKDIR /go/src/github.com/banzaicloud/drone-plugin-zeppelin-client  
RUN go-wrapper download  
RUN go build -o /bin/zeppelin-client .  
  
FROM alpine:3.7  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/zeppelin-client /bin  
ENTRYPOINT ["/bin/zeppelin-client"]  

