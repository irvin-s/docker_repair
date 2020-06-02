#This is a custom ubuntu image with SSH already installed  
FROM ubuntu:xenial  
MAINTAINER ericm  
RUN apt-get update  
RUN apt-get -y install openssh-server  
EXPOSE 22  
RUN mkdir /var/run/sshd  
CMD ["/usr/sbin/sshd", "-D"]  
  

