FROM base/archlinux  
MAINTAINER ddub  
ADD pacman.conf /etc/pacman.conf  
RUN pacman -Syu --noconfirm  
RUN pacman --noconfirm -S liquidsoap festival-english sox  
  
# Telnet control  
EXPOSE 1337  
# live harbour  
EXPOSE 8000  
VOLUME ["/config"]  
  
USER 140  
CMD ["/usr/sbin/liquidsoap /config/radio.liq"]  

