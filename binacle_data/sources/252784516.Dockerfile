FROM pritunl/archlinux:latest  
MAINTAINER Bjorn Stange <bjorn248@gmail.com>  
  
# Install vim git sudo  
RUN pacman -S vim git sudo --noconfirm  
RUN useradd -m -g users -s /bin/bash chef  
RUN usermod -aG wheel chef  
  
ADD sudoers /etc/sudoers  
  
RUN pacman -S --needed base-devel --noconfirm  
  
ADD install_chef.sh /home/chef/install_chef.sh  
  
RUN chmod +x /home/chef/install_chef.sh  
  
RUN su chef -s /bin/bash -c "/home/chef/install_chef.sh"  

