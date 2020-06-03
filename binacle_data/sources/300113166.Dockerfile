FROM ubuntu:16.04
MAINTAINER bogdan@insomnihack.ch
LABEL Description="Insomni'hack 2017 Skybot" VERSION='1.0'

# Installation
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential socat openssh-server
# RUN sysctl -w kernel.dmesg_restrict=1 \
#         && echo "kernel.dmesg_restrict=1" >> /etc/sysctl.conf \
#         && sysctl -p
# RUN mount -o remount,hidepid=2 /proc
RUN chmod 1733 /tmp /var/tmp /dev/shm

# User
RUN adduser --disabled-password --gecos '' skybot
RUN chown -R root:skybot /home/skybot/
RUN chmod 0750 /home/skybot
RUN touch /home/skybot/flag.txt
RUN export TERM=xterm

# Copy files
ADD skybot /home/skybot
ADD flag.txt /home/skybot
ADD banners/ /home/skybot/banners
ADD spam/ /home/skybot/spam
ADD libc-2.23.so /lib/x86_64-linux-gnu/libc-2.23.so

RUN chown root:skybot /home/skybot/skybot && chmod 0510 /home/skybot/skybot \
        && chown -R root:root /home/skybot/banners && chmod -R 0555 /home/skybot/banners \
        && chown -R root:root /home/skybot/spam && chmod -R 0555 /home/skybot/spam \
        && chown root:skybot /home/skybot/flag.txt && chmod 440 /home/skybot/flag.txt \
        && service ssh start \
        && update-rc.d ssh enable

EXPOSE 22 1337

# USER skybot
WORKDIR /home/skybot/
CMD su skybot -c "socat -T9 TCP4-LISTEN:1337,reuseaddr,fork EXEC:/home/skybot/skybot"
