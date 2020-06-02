# Pull base image
FROM resin/rpi-raspbian:jessie
MAINTAINER Malte Delfs <dev@maltedelfs.de>

# Install dependencies
RUN apt-get update && apt-get install -y wget
RUN wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/wheezy.list
RUN apt-get update && apt-get install -y \
mopidy mopidy-spotify mopidy-spotify-tunigo \
pulseaudio pulseaudio-utils gstreamer1.0 gstreamer0.10-pulseaudio libsdl1.2debian \
python python-pip

RUN pip install mopidy-musicbox-webclient Mopidy-Local-SQLite

# Copy config files
COPY default.pa /etc/pulse/default.pa
COPY mopidy.conf /etc/mopidy/mopidy.conf

RUN mkdir -p ~/.config/pulse
RUN touch ~/.config/pulse/cookie

EXPOSE 6600 6680

# Run
CMD pulseaudio --start && printf "\n[spotify]\nusername = %s\npassword = %s\n" "$USER" "$PASS"  >> /etc/mopidy/mopidy.conf & mopidy --config /usr/share/mopidy/conf.d:/etc/mopidy/mopidy.conf local scan & mopidy --config /usr/share/mopidy/conf.d:/etc/mopidy/mopidy.conf
