FROM base/archlinux:latest  
  
RUN pacman -Sy --noconfirm  
RUN pacman -S --noconfirm archlinux-keyring  
RUN pacman -Su --noconfirm  
RUN pacman-db-upgrade  
RUN trust extract-compat  
RUN pacman -S wget --noconfirm

