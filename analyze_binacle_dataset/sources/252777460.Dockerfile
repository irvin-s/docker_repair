# Copyright 2017 The OpenPitrix Authors. All rights reserved.  
# Use of this source code is governed by a Apache license  
# that can be found in the LICENSE file.  
FROM golang:alpine as builder  
  
RUN apk add --no-cache git  
  
RUN go get github.com/golang/protobuf/protoc-gen-go  
RUN go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway  
RUN go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger  
RUN go get github.com/go-swagger/go-swagger/cmd/swagger  
  
FROM alpine  
  
RUN apk add --no-cache protobuf  
  
COPY \--from=builder /go/bin/protoc-gen-go /usr/local/bin/  
COPY \--from=builder /go/bin/protoc-gen-grpc-gateway /usr/local/bin/  
COPY \--from=builder /go/bin/protoc-gen-swagger /usr/local/bin/  
COPY \--from=builder /go/bin/swagger /usr/local/bin/  
  
CMD ["sh"]  

