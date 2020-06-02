FROM golang:latest  
  
MAINTAINER Dao Anh Dung <dung13890@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y graphviz  
  
RUN go get -u github.com/golang/dep/cmd/dep  

