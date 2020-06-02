FROM ubuntu:16.04
LABEL maintainer "lucas.pires.mattos@gmail.com"

ENV SERVER_MAP=de_dust2
ENV SERVER_MAXPLAYERS=16
ENV SERVER_PORT=27015
ENV SERVER_CLIENT_PORT=27005
ENV SERVER_IP=0.0.0.0
ENV SERVER_NAME="CS 1.6 Server"

RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install -y \
    mailutils \
    postfix \
    curl \
    wget \
    file \
    bzip2 \
    gzip \
    unzip \
    bsdmainutils \
    python \
    util-linux \
    ca-certificates \
    tmux \
    lib32gcc1 \
    libstdc++6 \
    libstdc++6:i386 \
    binutils

RUN useradd -ms /bin/bash csserver

USER csserver
WORKDIR /home/csserver

RUN wget https://raw.githubusercontent.com/flyingluscas/cs16-server-docker/master/csserver
RUN chmod +x csserver
RUN ./csserver auto-install

EXPOSE ${SERVER_PORT}/udp
EXPOSE ${SERVER_CLIENT_PORT}/udp
EXPOSE ${SERVER_PORT}

ENTRYPOINT ["./csserver"]

CMD ["start"]
