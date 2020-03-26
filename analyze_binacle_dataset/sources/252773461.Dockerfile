# comments in a dockerfile  
FROM ubuntu:latest  
MAINTAINER Bilal Shah <bilal.shah.mail@gmail.com>  
RUN apt-get -y update && \  
apt-get -y upgrade && \  
apt-get -y install \  
apt-utils \  
iputils-ping \  
lsb \  
net-tools \  
wget \  
curl \  
vim \  
sudo \  
tree  
#  
# password is chefuser  
# echo "chefuser" | openssl passwd -crypt -stdin  
#  
RUN useradd -m -G sudo -p "pa8/1qs2vUg9U" chefuser  
#  
# use sudo -s to change root pw and login as root  
# we start off as chefuser and its in sudo  
# actually we need to be root to build some more on this image  
# so chefuser is created but not really used here  
#  
WORKDIR /home/chefuser  
WORKDIR chef-repo  
WORKDIR ../learn-chef  
WORKDIR /root  
USER root  

