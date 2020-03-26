FROM golang:alpine as builder  
  
ENV RESTIC_VERSION master  
  
WORKDIR /go/src/  
  
RUN apk update && \  
apk add --update --no-cache \  
git \  
ca-certificates  
  
RUN git clone https://github.com/restic/restic --branch $RESTIC_VERSION  
  
RUN cd restic && \  
go run build.go  
  
FROM alpine:3.7  
RUN apk update && \  
apk add --update --no-cache \  
ca-certificates  
  
WORKDIR /usr/bin/  
  
ADD . /usr/bin/  
  
COPY \--from=builder /go/src/restic/restic /usr/bin/restic  
  
CMD ["/usr/bin/restic"]  

