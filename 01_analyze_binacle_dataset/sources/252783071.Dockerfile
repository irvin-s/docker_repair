FROM docker.io/alpine:3.6  
MAINTAINER David Barroso <dbarrosop@dravetech.com>  
  
RUN apk update && \  
apk add bash openssh && \  
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa && \  
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa && \  
echo 'root:docker' | chpasswd && \  
echo -e "PermitRootLogin yes\n" >> /etc/ssh/sshd_config && \  
echo -e "Port 22\n" >> /etc/ssh/sshd_config && \  
rm -rf /var/cache/apk/*  
  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]  

