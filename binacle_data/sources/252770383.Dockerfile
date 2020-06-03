FROM archlinux/base  
RUN pacman -Syu --noconfirm meson clang  
ENV CC=clang CXX=clang++  

