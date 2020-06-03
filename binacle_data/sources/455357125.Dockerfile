FROM ubuntu:16.04
MAINTAINER PewZ
LABEL Description="TG17 CTF noread"

# Installation
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat vim gcc openssh-server

RUN adduser --disabled-password --gecos "" noread
RUN chown -R root:noread /home/noread/
RUN chmod 750 /home/noread
RUN chmod 740 /usr/bin/top
RUN chmod 740 /bin/ps
RUN chmod 740 /usr/bin/pgrep
RUN chmod 700 /proc
RUN export TERM=xterm

COPY motd /etc/motd
# remove Ubuntu shit from motd
RUN sed -i '/pam_motd.so/s/^/#/' /etc/pam.d/sshd
COPY noread /home/noread/noread
RUN chmod 001 /home/noread/noread

RUN echo "noread:I_promise_to_be_nice" | chpasswd
RUN chmod 733 /tmp
COPY sshd_config /etc/ssh/
RUN service ssh restart
USER noread
WORKDIR /home/noread

ENTRYPOINT service ssh restart && bash
