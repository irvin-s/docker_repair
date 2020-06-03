FROM ubuntu  
MAINTAINER akarsh  
RUN apt-get -y update && apt-get -y upgrade  
RUN apt-get -y install openssh-server  
RUN mkdir /var/sshkeys/  

