FROM golang:1.7beta2-alpine  
MAINTAINER Earvin Kayonga <earvin@earvinkayonga.com>  
  
ENV PORT 80  
RUN apk add --update git bash build-base  
  
# Setting up working directory  
WORKDIR /go/src/gin-container  
ADD . /go/src/gin-container  
  
RUN go get github.com/tools/godep  
RUN go get github.com/gin-gonic/gin  
RUN go install github.com/tools/godep  
RUN go install github.com/gin-gonic/gin  
  
# Restore godep dependencies  
#RUN godep restore  
EXPOSE 80  
ENTRYPOINT ["/usr/local/go/bin/go"]  
CMD ["run", "src/main.go"]  

