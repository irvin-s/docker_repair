FROM debian:8.1  
MAINTAINER @abdul <abdul.qabiz@gmail.com>  
  
RUN apt-get update && apt-get -y dist-upgrade  
RUN apt-get install -y golang git  
  
ENV GOPATH /usr/go  
RUN mkdir $GOPATH  
ENV PATH $GOPATH/bin:$PATH  
  
RUN go get github.com/yudai/gotty  
  
# Install whatever program you want to run through gotty:  
# RUN apt-get install -y bsdgames  
# ENV PATH /usr/games/:$PATH  
ENTRYPOINT ["gotty"]  

