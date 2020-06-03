FROM bagol/arch-blank  
RUN sed -i 's/#en_US/en_US/g' /etc/locale.gen && \  
locale-gen && echo 'LANG=en_US.UTF-8' > /etc/locale.conf  
ENV LANG en_US.UTF-8  
RUN pacman -Syu --noconfirm  

