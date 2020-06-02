FROM ubuntu  
  
MAINTAINER foo <foo@bar.com>  
  
RUN apt-get update && apt-get install -y openssh-server  
  
RUN mkdir -p /var/run/sshd  
ONBUILD ADD sshd_config /etc/ssh/sshd_config  
  
CMD /usr/sbin/sshd -D  
  
USER nobody  
WORKDIR /tmp  
ENV foobar "hello world"  
EXPOSE 2222  

