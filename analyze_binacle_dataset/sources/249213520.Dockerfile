FROM ubuntu:16.04
MAINTAINER Seth Morabito <web@loomcom.com>

ENV TERM vt100

RUN apt-get update

RUN apt-get install -y tightvncserver mwm sudo \
    curl inetutils-inetd xterm telnet nfs-kernel-server

RUN mkdir -p /home/genera && \
    mkdir -p /home/genera/.vnc &&\
    mkdir -p /home/genera/bin && \
    mkdir -p /home/genera/worlds

COPY genera /home/genera/bin
COPY run.sh /home/genera
COPY run-vnc.sh /home/genera
COPY lispm-init.lisp /home/genera
COPY dot-VLM /home/genera/.VLM
COPY Genera-8-5-A.vlod /home/genera/worlds/Genera-8-5-A.vlod
COPY VLM_debugger /home/genera/VLM_debugger
COPY Xsession /home/genera/.Xsession
COPY symbolics.tar.gz /var/lib
COPY exports /etc/exports

RUN pwunconv

RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    echo "genera:x:${uid}:${gid}:Genera,,,:/home/genera:/bin/bash" >> /etc/passwd && \
    echo "genera:x:${uid}:" >> /etc/group && \
    echo "genera ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/genera && \
    chmod 0440 /etc/sudoers.d/genera && \
    echo "daytime stream tcp nowait root internal" >> /etc/inetd.conf && \
    echo "time  stream tcp nowait root internal" >> /etc/inetd.conf && \
    echo "daytime dgram udp wait root internal" >> /etc/inetd.conf && \
    echo "time dgram udp wait root internal" >> /etc/inetd.conf && \
    cd /var/lib && tar xvf symbolics.tar.gz && \
    cd /home/genera && \
    echo "genera" | vncpasswd -f > /home/genera/.vnc/passwd && \
    chmod 0600 /home/genera/.vnc/passwd && \
    chmod 0700 /home/genera/.vnc && \
    chown ${uid}:${gid} -R /home/genera

USER genera

ENV HOME /home/genera
ENV USER genera

ENTRYPOINT /home/genera/run.sh
