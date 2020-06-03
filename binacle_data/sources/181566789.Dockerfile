FROM ubuntu:12.04

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV USER=skype
ENV VNC_PASSWORD=123
ENV HTTP_PASSWORD=123

WORKDIR /home/skype
RUN groupadd -r skype && useradd -r -g skype skype && mkdir -p /home/skype

RUN apt-get update --quiet > /dev/null && \
  apt-get install --assume-yes --force-yes -qq \
  xvfb fluxbox x11vnc dbus libasound2 libqt4-dbus \
  libqt4-network libqtcore4 libqtgui4 libxss1 libpython2.7 \
  libqt4-xml libaudio2 libmng1 fontconfig liblcms1 \
  lib32stdc++6 lib32asound2 ia32-libs libc6-i386 lib32gcc1 \
  nano python-virtualenv wget net-tools \
  python-gobject-2 curl git && \
  wget http://www.skype.com/go/getskype-linux-beta-ubuntu-64 -O skype-linux-beta.deb && \
  dpkg -i skype-linux-beta.deb && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/opensourcehacker/sevabot.git sevabot
COPY bin/passwd /home/skype/.x11vnc/passwd

WORKDIR /home/skype/sevabot
RUN cp settings.py.example settings.py && \
    sed -i "s/HTTP_HOST = \"localhost\"/HTTP_HOST = \"0.0.0.0\"/g" settings.py  && \
    sed -i "s/SHARED_SECRET = \"koskela\"/SHARED_SECRET = \"${HTTP_PASSWORD}\"/g" settings.py && \
    virtualenv venv && \
    . venv/bin/activate && \
    python setup.py develop

RUN chmod -R 777 /home/skype/ && chown -R skype:skype /home/skype

ADD bin/init.sh /init.sh
RUN chmod +x /*.sh

USER skype

# VNC
EXPOSE 5900
# Xvfb
EXPOSE 6001
# HTTP interface
EXPOSE 5000
# Skype
EXPOSE 59307

CMD ["/init.sh"]
