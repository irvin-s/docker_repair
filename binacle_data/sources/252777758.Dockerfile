FROM base/archlinux  
  
RUN pacman -Syyu -q --noconfirm  
RUN pacman -S chromium -q --noconfirm  
RUN pacman -S socat -q --noconfirm  
RUN pacman -Sc --noconfirm  
RUN rm -rf /tmp/*  
  
RUN useradd -m chromium  
  
USER chromium  
WORKDIR /home/chromium  
  
COPY start.sh /home/chromium/  
  
ENTRYPOINT ["sh", "/home/chromium/start.sh"]  

