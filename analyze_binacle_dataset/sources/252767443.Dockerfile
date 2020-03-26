#IMAGE_NAME: alextucc/xenial_env:base  
FROM alextucc/xenial_env:apt-update  
MAINTAINER Alex Tu  
RUN \  
# useradd -ms /bin/bash user; \  
apt-get install -y sudo tmux vim git zsh  
  
#USER user  
#WORKDIR /home/user  

