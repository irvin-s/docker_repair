FROM pritunl/archlinux  
MAINTAINER Kim Nordmo <kim.nordmo@gmail.com>  
  
RUN pacman -Syu --noconfirm && pacman -S --noconfirm \  
cmake \  
cmocka \  
gcc \  
make  

