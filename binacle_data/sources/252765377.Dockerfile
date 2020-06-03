  
# Copyright (c) 2017 0xFireball  
# All rights reserved.  
# Contributors:  
# Nihal Talur (0xFireball) <0xFireball@outlook.com>  
FROM codenvy/ubuntu_jre  
  
MAINTAINER 0xfireball@outlook.com  
  
RUN sudo apt-get update  
RUN sudo apt-get install -y nasm  
RUN sudo apt-get install -y qemu-system-x86  
  
ENV LANG C.UTF-8  
WORKDIR /projects  
CMD tail -f /dev/null  

