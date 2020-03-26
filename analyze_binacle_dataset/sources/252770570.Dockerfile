FROM base/archlinux  
  
WORKDIR /root  
  
RUN pacman -Sy && pacman -S --noconfirm cmake make gcc boost  
  
COPY . ./  
  
RUN mkdir -p build/release  
  
WORKDIR /root/build/release  
  
RUN cmake ../.. && make  
  
EXPOSE 11191  
CMD src/aeon_pocket 0.0.0.0 11191 ${DAEMON_HOST} ${DAEMON_PORT}

