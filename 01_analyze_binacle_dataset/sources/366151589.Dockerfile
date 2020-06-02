FROM resin/rpi-raspbian:wheezy-2015-09-02

ENV VERSION v0.14.9

RUN useradd -m syncthing

RUN apt-get update && \
    apt-get dist-upgrade -y && \
    apt-get install -y wget xmlstarlet ca-certificates && \
    wget -O syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/$VERSION/syncthing-linux-arm-$VERSION.tar.gz && \
    tar -xvf syncthing.tar.gz && \
    mv syncthing-linux-arm-$VERSION/syncthing /home/syncthing/syncthing && \
    chown syncthing:syncthing /home/syncthing/syncthing && \
    rm -rf syncthing.tar.gz syncthing-linux-arm-$VERSION && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean

ADD start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /home/syncthing

RUN mkdir -p /home/syncthing/Sync && chown -R syncthing /home/syncthing/Sync
RUN mkdir -p /home/syncthing/.config/syncthing && chown -R syncthing /home/syncthing/.config/syncthing

VOLUME ["/home/syncthing/.config/syncthing", "/home/syncthing/Sync"]

EXPOSE 8384 22000 21025/udp

CMD ["/start.sh"]

