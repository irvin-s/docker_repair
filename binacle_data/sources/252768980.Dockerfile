#----------------------------------------------------------------------------  
# sql-runner  
#----------------------------------------------------------------------------  
FROM golang:1.5  
MAINTAINER Alessandro Andrioni <alessandro.andrioni@dafiti.com.br>  
  
RUN mkdir /dist  
VOLUME /dist  
  
ADD . /sql-runner  
WORKDIR /sql-runner  
RUN go get github.com/tools/godep  
RUN go get github.com/snowplow/sql-runner || true  
CMD godep go build && mv sql-runner /dist  

