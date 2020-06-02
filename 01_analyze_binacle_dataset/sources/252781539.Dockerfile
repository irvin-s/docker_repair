FROM golang:1.9-alpine  
  
RUN apk add --no-cache git mercurial  
ADD . /go/src/github.com/banzaicloud/drone-plugin-pipeline-client  
WORKDIR /go/src/github.com/banzaicloud/drone-plugin-pipeline-client  
RUN go-wrapper download  
RUN go build -o /bin/pipeline-client .  
  
FROM alpine:3.7  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/pipeline-client /bin  
ENTRYPOINT ["/bin/pipeline-client"]  

