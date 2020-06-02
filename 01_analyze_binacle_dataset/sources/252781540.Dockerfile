FROM golang:1.9.2-alpine3.7  
RUN apk add --no-cache git mercurial  
ADD . /go/src/github.com/banzaicloud/drone-spark-submit-k8s  
WORKDIR /go/src/github.com/banzaicloud/drone-spark-submit-k8s  
RUN go-wrapper download  
RUN go build -o /bin/spark-submit-k8s .  
  
FROM banzaicloud/spark-base:v2.2.1-k8s-1.0.11  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
COPY \--from=0 /bin/spark-submit-k8s /bin  
ENTRYPOINT ["/bin/spark-submit-k8s"]

