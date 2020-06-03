FROM golang:1.6.3  
MAINTAINER Billy Ray Teves <billyteves@gmail.com>  
  
ADD ./run-ssh /usr/local/bin/run-ssh  
  
RUN curl https://glide.sh/get | sh  
  
WORKDIR /go/src/app  
  

