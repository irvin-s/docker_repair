FROM mini/base  
  
RUN apk-install bash  
  
ENV GOLANG_VERSION 1.3.3-r1  
  
RUN apk-install go=$GOLANG_VERSION  
  
RUN mkdir -p /go/src  
ENV GOPATH /go  
ENV PATH /go/bin:$PATH  
WORKDIR /go  
  
COPY go-wrapper /usr/local/bin/  

