FROM debian:buster

RUN dpkg --add-architecture i386 && apt update -y && apt install -y curl git build-essential pkg-config ccache autoconf automake apt-utils python2.7 python2.7-dev python3 python3-venv python3-dev python3-apt mesa-common-dev libgl1-mesa-dev cmake zlib1g zlib1g-dev openjdk-8-jdk zip unzip libncurses5 libncurses5:i386 libidn11 libidn11:i386 zlib1g:i386 libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 libpangox-1.0-0:i386 libtool libevent-2.1-6 libevent-dev gettext libffi6 libffi-dev
RUN git clone https://github.com/darosior/c-simple /opt/c-simple
