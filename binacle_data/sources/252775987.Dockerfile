FROM ubuntu:16.04  
MAINTAINER Bogdan Mustiata <bogdan.mustiata@gmail.com>  
  
ENV REFRESHED_AT 2016.12.12-10:47:08  
  
RUN apt-get update -y && \  
apt-get install -y mercurial git vim byobu wget curl xutils-dev && \  
cd && \  
git clone --recursive https://github.com/bmustiata/dotfiles dotfiles && \  
cd /root/dotfiles/bin && \  
./initial-setup.sh && \  
./sync-dotfiles.sh && \  
echo ". /root/.ciplogicprofilerc" >> /root/.bashrc  
  

