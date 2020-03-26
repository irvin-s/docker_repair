# build stage  
FROM golang:1.9.3-alpine3.7  
ADD . /go/src/github.com/banzaicloud/ht-aws-asg-action-plugin  
WORKDIR /go/src/github.com/banzaicloud/ht-aws-asg-action-plugin  
RUN go build -o /bin/ht-aws-asg-action-plugin .  
  
FROM alpine:latest  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/ht-aws-asg-action-plugin /bin  
ENTRYPOINT ["/bin/ht-aws-asg-action-plugin"]  

