FROM golang:1.9.4-alpine3.7  
ADD . /go/src/github.com/banzaicloud/sshKeyGenerator  
WORKDIR /go/src/github.com/banzaicloud/sshKeyGenerator  
RUN go build -o /bin/ssh_keygen .  
  
FROM alpine:latest  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/ssh_keygen /bin  
ENTRYPOINT ["/bin/ssh_keygen"]

