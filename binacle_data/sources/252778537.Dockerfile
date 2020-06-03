FROM phusion/baseimage:latest  
MAINTAINER Ardjan Zwartjes  
  
# sshd needs this directory to run  
RUN mkdir -p /ssh-git  
RUN chmod 775 /ssh-git  
  
RUN apt-get update  
  
RUN apt-get install -qy git  
  
COPY sshd_config /etc/ssh/sshd_config  
  
COPY entrypoint /usr/sbin/entrypoint  
  
RUN chmod 755 /usr/sbin/entrypoint  
  
RUN mkdir -p /etc/ssh  
  
RUN ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ''  
  
EXPOSE 22  
VOLUME ["/config"]  
  
ENTRYPOINT ["/usr/sbin/entrypoint"]  

