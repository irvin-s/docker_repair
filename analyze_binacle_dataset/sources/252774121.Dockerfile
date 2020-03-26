FROM golang:alpine  
MAINTAINER Amane Katagiri  
RUN apk add --update --no-cache make git  
CMD [""]  
ENTRYPOINT ["kick-kick-go"]  
WORKDIR /go/src/github.com/amane-katagiri/kick-kick-go  
COPY glide.yaml Makefile /go/src/github.com/amane-katagiri/kick-kick-go/  
RUN make deps  
COPY example /app  
COPY . /go/src/github.com/amane-katagiri/kick-kick-go/  
RUN make && make install  
WORKDIR /app  

