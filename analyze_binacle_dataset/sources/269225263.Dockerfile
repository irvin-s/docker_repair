FROM ubuntu
MAINTAINER Thoxvi <A@Thoxvi.com>
COPY ./sources.list /etc/apt/sources.list
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y lib32gcc1 libcurl4-gnutls-dev:i386 curl && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /root/DST && \
    mkdir -p /root/steamcmd && \
    cd /root/steamcmd && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - 
RUN taskset -c 0 /root/steamcmd/steamcmd.sh \
            +login anonymous \
            +force_install_dir /root/DST \
            +app_update 343050  validate \
            +quit
RUN ln -s /root/steamcmd/linux32/libstdc++.so.6 /root/DST/bin/lib32/ && \
    cd /root/DST/bin && \
    echo "/root/steamcmd/steamcmd.sh +@ShutdownOnFailedCommand 1 +@NoPromptForPassword 1 +login anonymous +force_install_dir /root/DST +app_update 343050 +quit" > start.sh && \
    echo "/root/DST/bin/dontstarve_dedicated_server_nullrenderer -only_update_server_mods" >> start.sh && \
    echo "/root/DST/bin/dontstarve_dedicated_server_nullrenderer -shard Master & /root/DST/bin/dontstarve_dedicated_server_nullrenderer -shard Caves" >> start.sh && \
    chmod +x start.sh
VOLUME /root/.klei/DoNotStarveTogether/Cluster_1
VOLUME /root/DST/mods
EXPOSE 10999/udp
EXPOSE 10998/udp
WORKDIR /root/DST/bin
CMD "/root/DST/bin/start.sh"
