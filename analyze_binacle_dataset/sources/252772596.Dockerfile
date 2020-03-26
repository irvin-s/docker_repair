FROM golang:1.10-alpine AS build  
  
RUN mkdir -p /go/src/github.com/benjdewan/pachelbel  
WORKDIR /go/src/github.com/benjdewan/pachelbel  
COPY . /go/src/github.com/benjdewan/pachelbel  
  
RUN apk add --no-cache \  
make \  
git  
  
RUN make \  
&& rm -rf /app \  
&& mkdir -p /app/etc/ssl/certs \  
&& cp /go/src/github.com/benjdewan/pachelbel/pachelbel-linux /app/pachelbel \  
&& cp /etc/ssl/certs/ca-certificates.crt /app/etc/ssl/certs/  
  
FROM scratch AS pachelbel  
COPY \--from=build /app /  
  
ENTRYPOINT [ "/pachelbel" ]  
CMD [ "--help" ]  
  

