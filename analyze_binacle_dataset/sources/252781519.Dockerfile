# build stage  
FROM golang:1.9.3-alpine3.7  
ADD . /go/src/github.com/banzaicloud/aws-autoscaling-exporter  
WORKDIR /go/src/github.com/banzaicloud/aws-autoscaling-exporter  
RUN go build -o /bin/aws-autoscaling-exporter .  
  
FROM alpine:latest  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/aws-autoscaling-exporter /bin  
ENTRYPOINT ["/bin/aws-autoscaling-exporter"]  

