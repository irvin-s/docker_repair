FROM ubuntu:wily
MAINTAINER Jakob Jarosch <dev@jakobjarosch.de>

RUN apt-get update && \
    apt-get install -y wget lib32gcc1 lib32tinfo5 unzip nginx

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam
USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf /tmp/steamcmd_linux.tar.gz && \
    rm /tmp/steamcmd_linux.tar.gz

# Install CSGO once to speed up container startup
RUN ./steamcmd.sh +login anonymous +force_install_dir ./csgo +app_update 740 validate +quit # Update to date as of 2016-02-02

ENV CSGO_HOSTNAME Counter-Strike Source Dedicated Server
ENV CSGO_PASSWORD ""
ENV RCON_PASSWORD mysup3rs3cr3tpassw0rd
ENV STEAM_ACCOUNT_TOKEN ""

EXPOSE 27015/udp
EXPOSE 27015

RUN mkdir /home/steam/.steam
RUN ln -s /home/steam/linux32 /home/steam/.steam/sdk32

ADD ./entrypoint.sh entrypoint.sh

# Add Source Mods
ADD mods/ /temp
RUN cd /home/steam/csgo/csgo && \
    tar zxvf /temp/mmsource-1.10.6-linux.tar.gz && \
    tar zxvf /temp/sourcemod-1.7.3-git5275-linux.tar.gz && \
    unzip /temp/quake_sounds_v3.zip && \
    unzip /temp/mapchooser_extended_1.10.2.zip

# Add default configuration files
ADD cfg/ /home/steam/csgo/csgo/cfg

CMD ./entrypoint.sh
