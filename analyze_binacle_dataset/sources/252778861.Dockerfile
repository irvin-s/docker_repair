FROM base/archlinux:latest  
  
RUN pacman -Syu --noconfirm  
RUN pacman -S --noconfirm clang qt5-base boost qbs gtest  
RUN paccache -rk0  

