FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN apt-get install --assume-yes thunderbird

ADD init.sh .
CMD ["sh", "init.sh"]
