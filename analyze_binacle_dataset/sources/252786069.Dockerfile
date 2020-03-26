FROM ubuntu:16.04  
#ENV http_proxy=http://172.17.0.1:3128  
#ENV https_proxy=http://172.17.0.1:3128  
RUN sed -i 's%archive.ubuntu.com%mirror.network32.net%' /etc/apt/sources.list  
  
RUN apt-get update && apt-get install -y \  
curl  
  
RUN mkdir -p /local_environment\  
&& mkdir -p /scripts/remote_environment\  
&& mkdir -p /remote_environment\  
&& mkdir -p /scripts/setup  
  
ADD roles/base /roles/base  
  
ADD roles/confd /roles/confd  
RUN /roles/confd/install.sh  
  
WORKDIR /mnt/workdir  
  
ENTRYPOINT ["/roles/base/entrypoint.sh"]  

