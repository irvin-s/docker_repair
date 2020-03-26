FROM ubuntu:xenial  
  
RUN apt-get -y update  
  
RUN apt-get -y install vim git emacs openssl gpgv2 nload nmap tcpdump  

