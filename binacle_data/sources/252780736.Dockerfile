FROM badele/archlinux-mybase  
MAINTAINER Bruno Adelé "bruno@adele.im"  
# Install the gnuradio  
RUN yaourt -Syu  
RUN yaourt -S --noconfirm gnuradio gnuradio-companion ttf-liberation  
  
# Clean the packages cache  
RUN rm -f /var/cache/pacman/pkg/*  
  
CMD bash

