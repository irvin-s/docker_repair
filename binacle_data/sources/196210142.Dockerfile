FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.1.0-amd64.deb
RUN dpkg -i slack-desktop-2.1.0-amd64.deb || true
RUN apt-get install --assume-yes -f

ADD init.sh .
CMD ["sh", "init.sh"]
