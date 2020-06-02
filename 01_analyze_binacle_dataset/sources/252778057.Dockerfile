FROM golang:1.7-alpine  
  
ADD bin /bin/  
ADD Gofile /  
# protoc: download source, build and install (required by protoc-gen-go)  
RUN install-protoc  
  
WORKDIR /go/src  
  
WORKDIR /go/src  
ENTRYPOINT [ "protoc" ]  
CMD [ "--go_out=plugins=grpc:." ]

