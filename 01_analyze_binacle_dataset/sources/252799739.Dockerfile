FROM debian:wheezy  
  
RUN apt-get update && apt-get install -y sudo libpulse0 pulseaudio  
  
# create chromium user  
RUN \  
adduser --disabled-password --gecos '' chromium \  
&& adduser chromium sudo \  
&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
# install chromium browser  
RUN apt-get update && apt-get install -y chromium-browser  
  
ADD bin/* /app/bin/  
  
USER chromium  
CMD ["/app/bin/chromium", "/data/.chromium"]  

