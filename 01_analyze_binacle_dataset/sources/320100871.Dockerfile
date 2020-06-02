FROM selenium/standalone-chrome-debug

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

USER root

#===================
# Timezone settings
# Possible alternative: https://github.com/docker/docker/issues/3359#issuecomment-32150214
#===================
ENV TZ "Asia/Tokyo"
RUN echo "Asia/Tokyo" | sudo tee /etc/timezone \
        && dpkg-reconfigure --frontend noninteractive tzdata

#===================
# Japanese settings
#===================
# RUN apt-get update -qqy \
#  && apt-get -qqy install fonts-takao-pgothic fonts-takao-gothic fonts-takao-mincho language-pack-ja \
#  && update-locale LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja \
#  && rm -rf /var/lib/apt/lists/*
# 
# ENV LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LC_CTYPE=ja_JP.UTF-8
#
RUN wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | apt-key add - \
&& wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | apt-key add - \
&& wget https://www.ubuntulinux.jp/sources.list.d/quantal.list -O /etc/apt/sources.list.d/ubuntu-ja.list \
&& apt-get -qqy update \
&& apt-get -qqy install fonts-takao-pgothic fonts-takao-gothic fonts-takao-mincho language-pack-ja \
&& rm -rf /var/lib/apt/lists/*

USER seluser
