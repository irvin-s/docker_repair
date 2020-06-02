FROM resin/armv7hf-debian-qemu  
  
VOLUME ["/config", "/torrents", "/downloads"]  
  
EXPOSE 8080 6881 4433 4434  
COPY ["qBittorrent.conf", "/"]  
  
RUN ["cross-build-start"]  
  
RUN apt-get update && \  
apt-get install -y qbittorrent-nox && \  
apt-get clean && apt-get autoclean && apt-get autoremove && \  
rm -rf /var/cache/apk/* && \  
mkdir -p ~/.config/qbittorrent/ && ln -sf ~/.config/qbittorrent/ /config && \  
mv /qBittorrent.conf /config/qBittorrent.conf  
  
RUN ["cross-build-end"]  
  
ENTRYPOINT ["qbittorrent-nox"]  

