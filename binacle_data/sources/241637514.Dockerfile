FROM debian:stretch
MAINTAINER Jacob Chen "jacob2.chen@rock-chips.com"

# setup multiarch enviroment
RUN dpkg --add-architecture armhf
RUN echo "deb-src http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org stretch/updates main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y crossbuild-essential-armhf

# perpare build dependencies
RUN apt-get update && apt-get install -y \
	sudo git fakeroot devscripts cmake vim qemu-user-static binfmt-support dh-make dh-exec \
	pkg-kde-tools device-tree-compiler bc cpio parted dosfstools mtools libssl-dev g++-arm-linux-gnueabihf

RUN apt-get update && apt-get build-dep -y -a armhf libdrm
RUN apt-get update && apt-get build-dep -y -a armhf xorg-server

RUN apt-get update && apt-get install -y libgstreamer-plugins-bad1.0-dev:armhf libgstreamer-plugins-base1.0-dev:armhf libgstreamer1.0-dev:armhf \
libgstreamermm-1.0-dev:armhf libqt5gstreamer-dev:armhf libqtgstreamer-dev:armhf \
libxfont1-dev:armhf libxxf86dga-dev:armhf libunwind-dev:armhf  libnetcdf-dev:armhf

RUN cp /usr/lib/pkgconfig/xf86dgaproto.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/xf86dgaproto.pc 

## qt-multimedia
RUN apt-get update && apt-get install -y qt5-qmake qt5-qmake:armhf qtbase5-dev:armhf qttools5-dev-tools:armhf qtbase5-dev-tools:armhf libpulse-dev:armhf \
	qtbase5-private-dev:armhf qtbase5-dev:armhf libasound2-dev:armhf libqt5quick5:armhf libqt5multimediaquick-p5:armhf qtdeclarative5-dev:armhf \
	libopenal-dev:armhf qtmultimedia5-examples:armhf libqt5multimediawidgets5:armhf qtmultimedia5-dev:armhf qtconnectivity5-dev:armhf

## opencv 
RUN apt-get update && apt-get install -y libhighgui-dev:armhf libopencv-calib3d-dev:armhf libopencv-calib3d2.4v5:armhf \
libopencv-contrib-dev:armhf libopencv-core-dev:armhf libopencv-core2.4v5:armhf libopencv-features2d-dev:armhf \
libopencv-features2d2.4v5:armhf libopencv-flann-dev:armhf libopencv-gpu-dev:armhf libopencv-highgui-dev:armhf \
libopencv-imgproc-dev:armhf libopencv-legacy-dev:armhf libopencv-ml-dev:armhf libopencv-objdetect-dev:armhf \
libopencv-ocl-dev:armhf libopencv-photo-dev:armhf libopencv-stitching-dev:armhf libopencv-superres-dev:armhf \
libopencv-ts-dev:armhf libopencv-video-dev:armhf libopencv-videostab-dev:armhf libopencv-calib3d2.4v5:armhf
RUN apt-get download libopencv-dev:armhf 
RUN dpkg -x libopencv*.deb /

## gstreamer-plugin-good
RUN apt-get update && apt-get install -y libgstreamer1.0-dev:armhf libraw1394-dev:armhf libiec61883-dev:armhf libavc1394-dev:armhf libv4l-dev:armhf \
libgudev-1.0-dev:armhf libgstreamer-plugins-base1.0-dev:armhf libcairo2-dev:armhf liborc-0.4-dev:armhf libcaca-dev:armhf libspeex-dev:armhf libpng-dev:armhf \
libshout3-dev:armhf libjpeg-dev:armhf libaa1-dev:armhf libflac-dev:armhf libdv4-dev:armhf libdv4-dev:armhf libxdamage-dev:armhf libxext-dev:armhf \
libxfixes-dev:armhf libxv-dev:armhf libgtk-3-dev:armhf libwavpack-dev:armhf libtag1-dev:armhf libsoup2.4-dev:armhf libpulse-dev:armhf \
libbz2-dev:armhf libjack-jackd2-dev:armhf libvpx-dev:armhf cdbs gtk-doc-tools:armhf libzvbi-dev:armhf libxvidcore-dev:armhf \
libxml2-dev:armhf libx265-dev:armhf libx11-dev:armhf libwildmidi-dev:armhf libwebrtc-audio-processing-dev:armhf libwebp-dev:armhf \
libvo-amrwbenc-dev:armhf libvo-aacenc-dev:armhf libssl-dev:armhf libsrtp0-dev:armhf libspandsp-dev:armhf libsoundtouch-dev:armhf \
libsndfile1-dev:armhf librtmp-dev:armhf librsvg2-dev:armhf libpng-dev:armhf liborc-0.4-dev:armhf libopus-dev:armhf libopenjp2-7-dev:armhf \
libopenal-dev:armhf libofa0-dev:armhf libmpcdec-dev:armhf libmodplug-dev:armhf libmms-dev:armhf \
libmjpegtools-dev:armhf liblilv-dev:armhf libkate-dev:armhf libiptcdata0-dev:armhf libgsm1-dev:armhf libgnutls28-dev:armhf \
libsbc-dev:armhf libgme-dev:armhf libglu1-mesa-dev:armhf libglib2.0-dev:armhf libgles2-mesa-dev:armhf libgl1-mesa-dev:armhf \
libfluidsynth-dev:armhf libfaad-dev:armhf libexif-dev:armhf libexempi-dev:armhf libegl1-mesa-dev:armhf \
libdvdnav-dev:armhf libde265-dev:armhf libdca-dev:armhf libcurl4-gnutls-dev:armhf libchromaprint-dev:armhf libcairo2-dev:armhf \
libbs2b-dev:armhf libass-dev:armhf ladspa-sdk:armhf libwayland-dev:armhf

# xf86-video-armsorc
RUN apt-get update && apt-get install -y xserver-xorg-dev:armhf
RUN cp /usr/lib/pkgconfig/* /usr/lib/arm-linux-gnueabihf/pkgconfig/

# FFmpeg
RUN apt-get update && apt-get install -y frei0r-plugins-dev:armhf flite1-dev:armhf libzmq3-dev:armhf \
ladspa-sdk:armhf libass-dev:armhf libbluray-dev:armhf libbs2b-dev:armhf libbz2-dev:armhf libcaca-dev:armhf libxvmc-dev:armhf \
libcdio-paranoia-dev:armhf libchromaprint-dev:armhf libdc1394-22-dev:armhf libdrm-dev:armhf libfontconfig1-dev:armhf \
libfreetype6-dev:armhf libfribidi-dev:armhf libgme-dev:armhf libgsm1-dev:armhf libiec61883-dev:armhf libxvidcore-dev:armhf \
libavc1394-dev:armhf libjack-jackd2-dev:armhf libleptonica-dev:armhf liblzma-dev:armhf libmp3lame-dev:armhf libxcb-xfixes0-dev:armhf \
libopenal-dev:armhf libomxil-bellagio-dev:armhf libopencore-amrnb-dev:armhf libzvbi-dev:armhf libxv-dev:armhf libxcb-shm0-dev:armhf \
libopencore-amrwb-dev:armhf libopencv-imgproc-dev:armhf libopenjp2-7-dev:armhf libopenmpt-dev:armhf libxml2-dev:armhf \
libopus-dev:armhf libpulse-dev:armhf librubberband-dev:armhf librsvg2-dev:armhf libsctp-dev:armhf libxcb-shape0-dev:armhf \
libsdl2-dev:armhf libshine-dev:armhf libsnappy-dev:armhf libsoxr-dev:armhf libspeex-dev:armhf libssh-gcrypt-dev:armhf \
libtesseract-dev:armhf libtheora-dev:armhf libtwolame-dev:armhf libva-dev:armhf libvdpau-dev:armhf libx265-dev:armhf \
libvo-amrwbenc-dev:armhf libvorbis-dev:armhf libvpx-dev:armhf libwavpack-dev:armhf libwebp-dev:armhf libx264-dev:armhf \
doxygen cleancss node-less

# Mpv
RUN apt-get update && apt-get install -y libasound2-dev:armhf libass-dev:armhf libavcodec-dev:armhf libavdevice-dev:armhf \
libavfilter-dev:armhf libavformat-dev:armhf libavresample-dev:armhf libavutil-dev:armhf libbluray-dev:armhf libcaca-dev:armhf \
libcdio-paranoia-dev:armhf libdvdnav-dev:armhf libdvdread-dev:armhf libegl1-mesa-dev:armhf libgbm-dev:armhf \
libgl1-mesa-dev:armhf libjack-dev:armhf libjpeg-dev:armhf liblcms2-dev:armhf liblua5.2-dev:armhf libpulse-dev:armhf \
librubberband-dev:armhf libsdl2-dev:armhf libsmbclient-dev:armhf libsndio-dev:armhf libswscale-dev:armhf \
libuchardet-dev:armhf libva-dev:armhf libvdpau-dev:armhf libwayland-dev:armhf libx11-dev:armhf libxinerama-dev:armhf \
libxkbcommon-dev:armhf libxrandr-dev:armhf libxss-dev:armhf libxv-dev:armhf

## yocto
RUN apt-get update && apt-get install -y gawk wget git-core diffstat unzip texinfo  build-essential chrpath socat  xterm locales

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8    

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ADD ./overlay/  /

RUN echo "Update Headers!"
RUN dpkg -i /packages/armhf/mpp/*.deb
RUN find /packages/armhf/libdrm -name '*.deb' | sudo xargs -I{} dpkg -x {} /

RUN apt-get update && apt-get install -y -f

# switch to a no-root user
RUN useradd -c 'rk user' -m -d /home/rk -s /bin/bash rk
RUN sed -i -e '/\%sudo/ c \%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN usermod -a -G sudo rk

USER rk


