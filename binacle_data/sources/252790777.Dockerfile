FROM casimir/blinux:latest  
MAINTAINER Martin Chaine <chaine_a@epitech.eu>  
  
RUN zypper -n install \  
emacs \  
nano \  
vim  
  
RUN useradd -md /home/bill bill  
USER bill  
WORKDIR /home/bill/workspace  
ENTRYPOINT exec /bin/bash  

