FROM ubuntu:14.04
MAINTAINER Aleksey Krasnobaev <https://github.com/krasnobaev>

# building wine32

RUN dpkg --add-architecture i386 && apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y dpkg-dev:i386
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential:i386 gcc:i386 g++:i386 g++-4.8:i386 gcc-4.8:i386 binutils:i386
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc-multilib:i386 g++-multilib:i386 g++:i386 g++-4.8-multilib:i386 gcc-4.8-multilib:i386 gcc:i386 g++-4.8:i386 gcc-4.8:i386 binutils:i386

#RUN wget http://winezeug.googlecode.com/svn/trunk/install-wine-deps.sh
# from install-wine-deps.sh#ubuntu_common_pkgs
# removed: git-core libtasn1-3-dev fontforge:i386
# installed before: gcc:i386
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y bison:i386 ccache:i386 cvs:i386 flex:i386 gettext:i386 libasound2-dev:i386 libaudio-dev:i386 libc6-dev:i386 libcapi20-3:i386 libcapi20-dev:i386 libdbus-1-dev:i386 libesd0-dev:i386 libexif-dev:i386 libexpat1-dev:i386 libfontconfig1-dev:i386 libfreetype6-dev:i386 libgcrypt11-dev:i386 libgl1-mesa-dev:i386 libglib2.0-dev:i386 libglu1-mesa-dev:i386 libgnutls-dev:i386 libgpg-error-dev:i386 libgphoto2-2-dev:i386 libgsm1-dev:i386 libgstreamer0.10-dev:i386 libgstreamer-plugins-base0.10-dev:i386 libice-dev:i386 libieee1284-3-dev:i386 liblcms1-dev:i386 libldap2-dev:i386 libmad0:i386 libmad0-dev:i386 libmpg123-dev:i386 libncurses5-dev:i386 libogg-dev:i386 libopenal-dev:i386 libopenal1:i386 libpng12-dev:i386 libpopt-dev:i386 libsm-dev:i386 libssl-dev:i386 libusb-dev:i386 libvorbis-dev:i386 libvorbisfile3:i386 libx11-dev:i386 libxau-dev:i386 libxcomposite-dev:i386 libxcursor-dev:i386 libxdmcp-dev:i386 libxext-dev:i386 libxfixes-dev:i386 libxft-dev:i386 libxi-dev:i386 libxinerama-dev:i386 libxml2-dev:i386 libxmu-dev:i386 libxmu-headers:i386 libxrandr-dev:i386 libxrender-dev:i386 libxslt1-dev:i386 libxt-dev:i386 libxv-dev:i386 libxxf86vm-dev:i386 linux-libc-dev:i386 m4:i386 make:i386 mesa-common-dev:i386 unixodbc:i386 unixodbc-dev:i386 x11proto-composite-dev:i386 x11proto-core-dev:i386 x11proto-fixes-dev:i386 x11proto-input-dev:i386 x11proto-kb-dev:i386 x11proto-randr-dev:i386 x11proto-video-dev:i386 x11proto-xext-dev:i386 x11proto-xf86vidmode-dev:i386 x11proto-xinerama-dev:i386 xtrans-dev:i386 zlib1g-dev:i386 libelfg0:i386 libgif-dev:i386 libjack-dev:i386

# from install-wine-deps.sh#ubuntu_trusty_pkgs
# removed oss4-dev:386 winbind:386
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcups2-dev:i386 libjpeg-turbo8-dev:i386 liblcms2-dev:i386 libosmesa6-dev:i386 libsane-dev:i386 libtiffxx5:i386 libtiff5-dev:i386 libv4l-dev:i386 prelink:i386

# again???
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gcc-multilib:i386 g++-multilib:i386 g++:i386 g++-4.8-multilib:i386 gcc-4.8-multilib:i386 gcc:i386 g++-4.8:i386 gcc-4.8:i386 binutils:i386

# looks like it requires amd64 package
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libgettextpo0:amd64

COPY ./run.sh /usr/bin/
RUN chmod 755 /usr/bin/*.sh

WORKDIR /usr/src/wine32

CMD run.sh

