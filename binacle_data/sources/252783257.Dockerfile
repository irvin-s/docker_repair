FROM ubuntu:xenial  
ENV DEBIAN_FRONTEND noninteractive  
COPY docker/fdr.list /etc/apt/sources.list.d/fdr.list  
COPY docker/linux_deploy.key /tmp/linux_deploy.key  
RUN apt-key add /tmp/linux_deploy.key \  
&& rm /tmp/linux_deploy.key  
RUN apt-get update \  
&& apt-get -y install fdr  

