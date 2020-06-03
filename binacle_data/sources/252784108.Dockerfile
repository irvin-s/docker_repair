FROM golang:1.9.1-stretch  
  
COPY run.go /opt/  
COPY src/bmeg /opt/src/bmeg  
  
ENV GOPATH /opt  
RUN go get github.com/blachlylab/gff3  
RUN go get github.com/golang/protobuf/jsonpb  
RUN go get github.com/golang/protobuf/proto

