FROM golang:1.8.1-alpine  
  
RUN apk add --no-cache ca-certificates  
  
ARG GOPATH=/mygo  
RUN apk add --no-cache --virtual build-dependencies \  
curl \  
git \  
go \  
&& go get github.com/tools/godep \  
&& git clone https://github.com/EagerIO/Stout.git /go/src/Stout \  
&& cd /go/src/Stout \  
&& /go/bin/godep go build -o /usr/local/bin/stout /go/src/Stout/src/*.go \  
&& apk del build-dependencies  
  
COPY entrypoint.sh /  
  
WORKDIR /workdir  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["help"]  

