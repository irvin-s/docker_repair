FROM boutch/archlinux  
RUN pacman -Syu --needed --noconfirm base-devel git rsync python2 go go-tools  
RUN pacman -Syu --noconfirm && pacman -Scc --noconfirm  

