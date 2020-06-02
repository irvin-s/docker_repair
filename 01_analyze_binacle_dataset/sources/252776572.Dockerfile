FROM golang:1.8-alpine  
MAINTAINER Ivan Porto Carrero <ivan@flanders.co.nz> (@casualjim)  
  
RUN set -e &&\  
apk add --no-cache --virtual .buildDeps git &&\  
go get -u github.com/aktau/github-release &&\  
mkdir -p /dist &&\  
apk del .buildDeps  
  
VOLUME ["/dist"]  
  
ENTRYPOINT ["github-release"]  
CMD ["--help"]  

