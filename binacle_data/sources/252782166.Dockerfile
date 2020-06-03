# BUILDER  
FROM alpine:3.7 as builder  
  
RUN apk upgrade \  
&& apk add --no-cache go musl-dev  
  
ENV GOPATH=/go  
COPY . /go/src/github.com/cilium/starwars-docker/  
RUN go install -v github.com/cilium/starwars-docker/  
  
# RUNTIME  
FROM alpine:3.7  
LABEL maintainer "Thomas Graf <tgraf@tgraf.ch>"  
COPY \--from=builder /go/bin/starwars-docker /  
EXPOSE 80  
ENTRYPOINT ["/starwars-docker", "--port", "80", "--host", "0.0.0.0"]  

