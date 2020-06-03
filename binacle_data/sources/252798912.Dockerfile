FROM ubuntu:14.04  
MAINTAINER Anthony Lapenna <lapenna.anthony@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBCONF_NONINTERACTIVE_SEEN true  
  
RUN apt-get install -y git zsh wget curl nano emacs  
  
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \  
&& chsh -s /bin/zsh  
  
ADD zshrc /root/.zshrc  

