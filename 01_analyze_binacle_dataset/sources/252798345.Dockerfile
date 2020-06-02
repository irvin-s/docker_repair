FROM debian:stretch-slim  
  
MAINTAINER daemonsthere@gmail.com  
ONBUILD RUN apt-get update --fix-missing  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm  
  
EXPOSE 8080  
VOLUME /data  
  
RUN apt-get update &&\  
apt-get install -y qbittorrent-nox &&\  
apt-get -y autoremove &&\  
apt-get -y clean &&\  
rm -rf /var/lib/apt/lists/* &&\  
mkdir -p /root/.config/qBittorrent  
  
ADD files/qBittorrent.conf /root/.config/qBittorrent/qBittorrent.conf  
  
WORKDIR /data  
ENTRYPOINT ["qbittorrent-nox"]  

