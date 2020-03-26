FROM base/archlinux  
  
MAINTAINER Acidhub - acidhub@craft.net.br  
  
LABEL Description="Acidhub's docker image for builds testing"  
LABEL Vendor="Acidhub - contact@acidhub.click"  
LABEL Version="2.4.2"  
  
RUN sed -i 's/Required/Never/g' /etc/pacman.conf && \  
pacman -Syyu --noconfirm --force --ignore systemd && \  
pacman-db-upgrade && \  
pacman -S base-devel git curl --noconfirm && \  
pacman -Rcns systemd --noconfirm && \  
pacman -Scc --noconfirm && \  
rm -rf /home /srv /mnt /opt /boot /root /tmp/* /var/tmp/*  

