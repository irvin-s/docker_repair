FROM armhf/alpine:3.4  
MAINTAINER Robert Doering <rdoering.info@gmail.com>  
  
ENV QEMU_EXECVE 1  
COPY . /usr/bin  

