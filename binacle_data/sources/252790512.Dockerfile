FROM golang:1.6-alpine  
  
EXPOSE 5001  
ENTRYPOINT ["auth_server"]  
CMD ["/config/auth_config.yml"]  
  
RUN apk add --update git curl  
RUN go get -v -u -f github.com/tools/godep github.com/jteeuwen/go-bindata/...  
  
COPY . /go/src/github.com/cesanta/docker_auth/auth_server  
WORKDIR /go/src/github.com/cesanta/docker_auth/auth_server  
RUN go get -v -d .  
RUN go install -v .  

