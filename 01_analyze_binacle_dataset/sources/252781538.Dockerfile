FROM golang:1.9.2-alpine3.7  
ADD . /go/src/github.com/banzaicloud/drone-plugin-k8s-proxy  
WORKDIR /go/src/github.com/banzaicloud/drone-plugin-k8s-proxy  
RUN go build -o /bin/k8s-proxy .  
  
FROM alpine:3.7  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/k8s-proxy /bin  
ENTRYPOINT ["/bin/k8s-proxy"]

