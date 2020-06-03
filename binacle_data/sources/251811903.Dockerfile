FROM redis:latest
MAINTAINER easter1021(Charles) <mufasa.hsu@gmail.com>

# 改為台北時區
RUN echo "Asia/Taipei" > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
