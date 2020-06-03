FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y openssh-server sudo  
RUN mkdir /var/run/sshd  
RUN apt-get install -y build-essential  
  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]  

