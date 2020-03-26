FROM ubuntu:14.04  
MAINTAINER Walter Moreira <wmoreira@tacc.utexas.edu>  
  
RUN apt-get update -y && \  
apt-get install -y python python-dev python-pip ssh sshpass  
RUN pip install ansible  
COPY roles /roles  
COPY alias.sh /alias  
COPY ansible.cfg /ansible.cfg  
RUN echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config  
  
ENV ANSIBLE_CONFIG=/ansible.cfg  
  
WORKDIR /deploy  

