FROM golang:1.9-alpine AS builder  
  
RUN \  
apk update \  
&& apk add curl git \  
&& rm -rf /var/cache/apk/*  
  
RUN curl https://glide.sh/get | sh  
  
RUN mkdir -p /root/.glide  
  
ENV GLIDE_HOME /root/.glide  
  
RUN mkdir -p /go/src/github.com/ALSAD-project/smoke-test  
WORKDIR /go/src/github.com/ALSAD-project/smoke-test  
  
COPY . /go/src/github.com/ALSAD-project/smoke-test  
RUN \  
glide mirror set \  
https://gonum.org/v1/gonum \  
https://github.com/gonum/gonum \  
&& glide install  
  
RUN \  
go build \  
-o /usr/local/bin/randfeeder \  
github.com/ALSAD-project/smoke-test/cmd/randfeeder  
  
FROM alpine:3.6  
ENV PORT 6010  
EXPOSE 6010  
COPY \  
\--from=builder \  
/usr/local/bin/randfeeder \  
/usr/local/bin/randfeeder  
  
CMD randfeeder  

