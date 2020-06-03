FROM golang:1.9  
ENV ANTHA_BRANCH master  
  
RUN apt-get update -qq && apt-get install -y libglpk-dev protobuf-compiler  
  
RUN go get github.com/antha-lang/antha/... \  
&& (cd /go/src/github.com/antha-lang/antha && git checkout $ANTHA_BRANCH)  
  
ADD . /go/src/github.com/antha-lang/elements  
RUN make -C /go/src/github.com/antha-lang/elements  

