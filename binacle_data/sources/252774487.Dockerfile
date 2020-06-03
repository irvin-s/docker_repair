FROM ubuntu  
  
RUN apt-get update  
RUN apt-get -y install openssh-server  
RUN mkdir -p /var/run/sshd  
  
CMD /usr/bin/sshd -D  
  
WORKDIR /tmp  
  
EXPOSE 22  

