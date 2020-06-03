FROM codekoala/arch  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN pacman -Sy --noconfirm --needed salt-zmq  

