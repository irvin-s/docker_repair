FROM gliderlabs/alpine:latest  
  
MAINTAINER codequest team <hello@codequest.com>  
  
ADD . /src  
WORKDIR /src  
  
ENV PROTOBUF_TAG v3.0.0-beta-3.2  
RUN ./build.sh  
  
ENTRYPOINT ["protoc"]  

