FROM progrium/busybox  
  
MAINTAINER Amajd Masad <amjad.masad@gmail.com>  
  
ADD go1.4.linux-amd64.tar.gz /  
ENV PATH $PATH:/go/bin  
ENV GOROOT /go  

