FROM centos:7  
MAINTAINER CoMSES Net <dev@comses.net>  
  
USER root  
ENV UID=2000 USERNAME=comses  
RUN useradd -U -m -u $UID -s /bin/bash $USERNAME  

