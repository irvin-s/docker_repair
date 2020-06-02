FROM ubuntu:16.04  
  
RUN apt-get update  
RUN apt-get install -y software-properties-common  
RUN add-apt-repository ppa:ubuntu-elisp/ppa  
RUN apt-get update  
RUN apt-get install -y emacs-snapshot  

