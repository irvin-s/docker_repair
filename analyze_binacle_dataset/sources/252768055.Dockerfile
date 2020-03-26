FROM linuxserver/baseimage  
MAINTAINER LinuxServer.io  
  
ENV APTLIST="qbittorrent-nox"  
# install packages  
RUN apt-get update -q && \  
apt-get install $APTLIST -qy && \  
  
# cleanup  
apt-get clean -y && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
  
#Create symbolic links to simplify mounting  
&& useradd --system --uid 520 -m --shell /usr/sbin/nologin qbittorrent \  
  
&& mkdir -p /home/qbittorrent/.config/qBittorrent \  
&& ln -s /home/qbittorrent/.config/qBittorrent /config \  
  
&& mkdir -p /home/qbittorrent/.local/share/data/qBittorrent \  
&& ln -s /home/qbittorrent/.local/share/data/qBittorrent /torrents \  
  
&& chown -R qbittorrent:qbittorrent /home/qbittorrent/ \  
  
&& mkdir /downloads \  
&& chown qbittorrent:qbittorrent /downloads  
  
ADD qBittorrent.conf /default/qBittorrent.conf  
ADD entrypoint.sh /  
  
RUN chmod -v +x /entrypoint.sh  
  
VOLUME /config  
VOLUME /torrents  
VOLUME /downloads  
  
EXPOSE 8080  
EXPOSE 6881  
USER qbittorrent  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["qbittorrent-nox -d"]  

