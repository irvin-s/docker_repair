FROM golang:1.9.2  
MAINTAINER Shaun Crampton <shaun@tigera.io>  
  
ADD . /src  
WORKDIR /src  
  
ENV PROTOBUF_TAG v3.5.1  
RUN ./build.sh  
  
ENTRYPOINT ["protoc"]  

