# steamcmd run as user steam
# https://developer.valvesoftware.com/wiki/SteamCMD#Linux

FROM ubuntu:19.04

RUN apt update && apt install --no-install-recommends -y \
    ca-certificates \
    lib32gcc1 \
    net-tools \
    lib32stdc++6 \
    lib32z1 \
    lib32z1-dev \
    curl

RUN mkdir -p /home/steam/steamcmd  && \
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -v -C /home/steam/steamcmd -zx && \
    chown -R 1000:1000 /home/steam

WORKDIR /home/steam/steamcmd
USER 1000

ONBUILD ADD install.txt /home/steam/steamcmd/install.txt
ONBUILD RUN ./steamcmd.sh +runscript install.txt
