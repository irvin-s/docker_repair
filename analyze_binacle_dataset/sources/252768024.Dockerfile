FROM golang:1.9.2-alpine3.7 AS build  
  
RUN apk add --update --no-cache \  
protobuf \  
protobuf-dev \  
git \  
&& go get -u github.com/golang/protobuf/protoc-gen-go  
  
ADD . /src/  
  
RUN set -x \  
&& cd /src \  
&& mkdir staticwebsite \  
&& protoc --go_out=staticwebsite *.proto \  
&& go build -o /in-memory-website-http-server  
  
FROM alpine:3.7 AS production  
  
EXPOSE 80  
COPY \--from=build /in-memory-website-http-server /usr/bin/  
  
CMD [ "/usr/bin/in-memory-website-http-server" ]  

