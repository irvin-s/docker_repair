FROM debian:jessie  
  
MAINTAINER axeclbr <axeclbr@posteo.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY dotfiles/bashrc /root/.bashrc  
  
CMD /bin/bash  

