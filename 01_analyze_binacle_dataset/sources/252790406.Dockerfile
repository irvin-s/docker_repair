FROM golang:1.7  
MAINTAINER Craig Peterson <hello@captncraig.io>  
  
RUN apt-get update && apt-get install -y upx-ucl  

