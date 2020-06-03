FROM golang:1.7-alpine  
  
MAINTAINER llitfkitfk <llitfkitfk@gmail.com>  
  
RUN apk add --no-cache git  
  
RUN go get github.com/tools/godep  
  
ENTRYPOINT ["godep"]  
CMD ["version"]  

