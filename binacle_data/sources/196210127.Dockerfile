FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN apt-get install --assume-yes ffmpeg libgstreamer-plugins-good1.0-0
RUN apt-get install --assume-yes chromium-browser

ADD init.sh .
CMD ["sh", "init.sh"]
