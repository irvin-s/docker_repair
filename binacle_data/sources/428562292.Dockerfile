FROM debian:jessie

ADD https://download-cdn.getsyncapp.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz /tmp/

RUN tar -xzf /tmp/BitTorrent-Sync_x64.tar.gz -C /tmp/ \
 && mv /tmp/btsync /usr/local/bin/ \
 && rm -rf /tmp/*

VOLUME /btsync

ADD btsync.json /btsync/config.json

RUN mkdir /btsync/.sync
EXPOSE 8888 5555

CMD ["btsync", "--nodaemon", "--config", "/btsync/config.json"]
