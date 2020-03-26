FROM golang:1.9.6-alpine3.7  
LABEL maintainer="Siddhartha Basu <siddhartha-basu@northwestern.edu>"  
RUN apk add --no-cache git build-base \  
&& go get github.com/golang/dep/cmd/dep \  
&& mkdir -p /go/src/github.com  
WORKDIR /go/src/github.com  
RUN git clone https://github.com/dictybase-docker/arangomanager.git \  
&& cd arangomanager \  
&& dep ensure \  
&& go build -o app  
  
FROM alpine:3.7  
RUN apk --no-cache add ca-certificates  
COPY \--from=0 /go/src/github.com/arangomanager/app /usr/local/bin/  
RUN mkdir -p /usr/src/appdata  
COPY *.yaml /usr/src/appdata/  
ENTRYPOINT ["/usr/local/bin/app"]  

