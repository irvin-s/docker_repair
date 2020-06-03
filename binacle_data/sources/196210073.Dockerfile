FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN wget https://github.com/magcius/keylog/archive/master.tar.gz
RUN tar xf master.tar.gz
RUN cd keylog-master; make

ADD init.sh .
CMD ["sh", "init.sh"]
