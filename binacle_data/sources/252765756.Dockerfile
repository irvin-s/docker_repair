FROM debian:jessie-slim  
  
ADD install.sh /  
RUN chmod 755 /install.sh && /install.sh && rm -f /install.sh  
  
RUN useradd -s /bin/bash user && \  
usermod -d /config user && \  
passwd -d user  
  
VOLUME /config  
EXPOSE 9117  
  
ADD services.conf /etc/supervisor/conf.d/  
ADD my_init /  
RUN chmod 755 /my_init  
CMD ["/my_init"]  

