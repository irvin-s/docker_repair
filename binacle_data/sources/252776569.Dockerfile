FROM golang:1.8-alpine  
MAINTAINER Ivan Porto Carrero <ivan@flanders.co.nz> (@casualjim)  
  
ADD upx /usr/bin/upx  
  
RUN \  
set -e &&\  
apk add --no-cache git bzr subversion mercurial bash musl-dev gcc  

