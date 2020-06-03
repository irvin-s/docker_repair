FROM golang:1.9-alpine  
  
ADD . /go/src/github.com/banzaicloud/ht-k8s-action-plugin  
WORKDIR /go/src/github.com/banzaicloud/ht-k8s-action-plugin  
RUN go build -o /bin/ht-k8s-action-plugin .  
  
FROM alpine:3.6  
RUN apk add --no-cache ca-certificates  
COPY \--from=0 /bin/ht-k8s-action-plugin /bin  
ENTRYPOINT ["/bin/ht-k8s-action-plugin"]  

