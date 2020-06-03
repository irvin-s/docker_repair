FROM golang:1.10-alpine AS build  
  
RUN mkdir -p /go/src/github.com/benjdewan/m3rger  
WORKDIR /go/src/github.com/benjdewan/m3rger  
COPY . /go/src/github.com/benjdewan/m3rger  
  
RUN apk add --no-cache \  
make \  
git  
  
RUN make  
  
FROM alpine:latest as m3rger  
COPY \--from=build /go/src/github.com/benjdewan/m3rger/m3rger-linux /m3rger  
ENTRYPOINT [ "/m3rger" ]  
CMD [ "--help" ]  
  

