FROM birchwoodlangham/ubuntu-base:latest  
  
MAINTAINER Tan Quach <tan.quach@birchwoodlangham.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install -y -qq --fix-missing libxext-dev libxrender-dev libxslt1.1 \  
libxtst-dev libgtk2.0-0 libcanberra-gtk-module libxss1 libxkbfile1 \  
gconf2 gconf-service libnotify4 libnss3 gvfs-bin xdg-utils && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  

