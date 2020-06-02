FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN apt-get install --assume-yes ffmpeg libgstreamer-plugins-good1.0-0

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install --assume-yes google-chrome-stable

ADD init.sh .
CMD ["sh", "init.sh"]
