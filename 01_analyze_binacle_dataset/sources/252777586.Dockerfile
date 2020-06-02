FROM golang:1.9  
  
RUN apt-get update -qq && apt-get install -y libglpk-dev protobuf-compiler  
  
RUN go get gopkg.in/alecthomas/gometalinter.v1 \  
&& ln -s `which gometalinter.v1` $GOPATH/bin/gometalinter \  
&& gometalinter --install  

