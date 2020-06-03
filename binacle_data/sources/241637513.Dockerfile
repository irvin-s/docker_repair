FROM debian:stretch
MAINTAINER Jacob Chen "jacob2.chen@rock-chips.com"

# setup multiarch enviroment
RUN dpkg --add-architecture arm64
RUN echo "deb-src http://deb.debian.org/debian stretch main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org stretch/updates main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y crossbuild-essential-arm64

# perpare build dependencies
RUN apt-get update && apt-get install -y \
	sudo git fakeroot devscripts cmake vim qemu-user-static binfmt-support dh-make dh-exec \
	pkg-kde-tools device-tree-compiler bc cpio parted dosfstools mtools libssl-dev g++-aarch64-linux-gnu

RUN apt-get update && apt-get build-dep -y -a arm64 libdrm
RUN apt-get update && apt-get build-dep -y -a arm64 xorg-server

RUN apt-get update && apt-get install -y libgstreamer-plugins-bad1.0-dev:arm64 libgstreamer-plugins-base1.0-dev:arm64 libgstreamer1.0-dev:arm64 \
libgstreamermm-1.0-dev:arm64 libqt5gstreamer-dev:arm64 libqtgstreamer-dev:arm64 \
libxfont1-dev:arm64 libxxf86dga-dev:arm64 libunwind-dev:arm64  libnetcdf-dev:arm64

RUN cp /usr/lib/pkgconfig/xf86dgaproto.pc /usr/lib/aarch64-linux-gnu/pkgconfig/xf86dgaproto.pc

## qt-multimedia
RUN apt-get update && apt-get install -y qt5-qmake qt5-qmake:arm64 qtbase5-dev:arm64 qttools5-dev-tools:arm64 qtbase5-dev-tools:arm64 libpulse-dev:arm64 \
	qtbase5-private-dev:arm64 qtbase5-dev:arm64 libasound2-dev:arm64 libqt5quick5:arm64 libqt5multimediaquick-p5:arm64 qtdeclarative5-dev:arm64 \
	libopenal-dev:arm64 qtmultimedia5-examples:arm64 libqt5multimediawidgets5:arm64 qtmultimedia5-dev:arm64 qtconnectivity5-dev:arm64

## opencv
#
RUN apt-get update && apt-get install -y libhighgui-dev:arm64 libopencv-calib3d-dev:arm64 libopencv-calib3d2.4v5:arm64 \
libopencv-contrib-dev:arm64 libopencv-core-dev:arm64 libopencv-core2.4v5:arm64 libopencv-features2d-dev:arm64 \
libopencv-features2d2.4v5:arm64 libopencv-flann-dev:arm64 libopencv-gpu-dev:arm64 libopencv-highgui-dev:arm64 \
libopencv-imgproc-dev:arm64 libopencv-legacy-dev:arm64 libopencv-ml-dev:arm64 libopencv-objdetect-dev:arm64 \
libopencv-ocl-dev:arm64 libopencv-photo-dev:arm64 libopencv-stitching-dev:arm64 libopencv-superres-dev:arm64 \
libopencv-ts-dev:arm64 libopencv-video-dev:arm64 libopencv-videostab-dev:arm64
RUN apt-get download libopencv-dev:arm64
RUN dpkg -x libopencv*.deb /

## gstreamer-plugin-good
RUN apt-get update && apt-get install -y libgstreamer1.0-dev:arm64 libraw1394-dev:arm64 libiec61883-dev:arm64 libavc1394-dev:arm64 libv4l-dev:arm64 \
libgudev-1.0-dev:arm64 libgstreamer-plugins-base1.0-dev:arm64 libcairo2-dev:arm64 liborc-0.4-dev:arm64 libcaca-dev:arm64 libspeex-dev:arm64 libpng-dev:arm64 \
libshout3-dev:arm64 libjpeg-dev:arm64 libaa1-dev:arm64 libflac-dev:arm64 libdv4-dev:arm64 libdv4-dev:arm64 libxdamage-dev:arm64 libxext-dev:arm64 \
libxfixes-dev:arm64 libxv-dev:arm64 libgtk-3-dev:arm64 libwavpack-dev:arm64 libtag1-dev:arm64 libsoup2.4-dev:arm64 libpulse-dev:arm64 \
libbz2-dev:arm64 libjack-jackd2-dev:arm64 libvpx-dev:arm64 cdbs gtk-doc-tools:arm64 libzvbi-dev:arm64 libxvidcore-dev:arm64 \
libxml2-dev:arm64 libx265-dev:arm64 libx11-dev:arm64 libwildmidi-dev:arm64 libwebrtc-audio-processing-dev:arm64 libwebp-dev:arm64 \
libvo-amrwbenc-dev:arm64 libvo-aacenc-dev:arm64 libssl-dev:arm64 libsrtp0-dev:arm64 libspandsp-dev:arm64 libsoundtouch-dev:arm64 \
libsndfile1-dev:arm64 librtmp-dev:arm64 librsvg2-dev:arm64 libpng-dev:arm64 liborc-0.4-dev:arm64 libopus-dev:arm64 libopenjp2-7-dev:arm64 \
libopenal-dev:arm64 libofa0-dev:arm64 libmpcdec-dev:arm64 libmodplug-dev:arm64 libmms-dev:arm64 \
libmjpegtools-dev:arm64 liblilv-dev:arm64 libkate-dev:arm64 libiptcdata0-dev:arm64 libgsm1-dev:arm64 libgnutls28-dev:arm64 \
libsbc-dev:arm64 libgme-dev:arm64 libglu1-mesa-dev:arm64 libglib2.0-dev:arm64 libgles2-mesa-dev:arm64 libgl1-mesa-dev:arm64 \
libfluidsynth-dev:arm64 libfaad-dev:arm64 libexif-dev:arm64 libexempi-dev:arm64 libegl1-mesa-dev:arm64 \
libdvdnav-dev:arm64 libde265-dev:arm64 libdca-dev:arm64 libcurl4-gnutls-dev:arm64 libchromaprint-dev:arm64 libcairo2-dev:arm64 \
libbs2b-dev:arm64 libass-dev:arm64 ladspa-sdk:arm64 libwayland-dev:arm64

# xf86-video-armsorc
RUN apt-get update && apt-get install -y xserver-xorg-dev:arm64
RUN cp /usr/lib/pkgconfig/* /usr/lib/aarch64-linux-gnu/pkgconfig/

# FFmpeg
RUN apt-get update && apt-get install -y frei0r-plugins-dev:arm64 flite1-dev:arm64 libzmq3-dev:arm64 \
ladspa-sdk:arm64 libass-dev:arm64 libbluray-dev:arm64 libbs2b-dev:arm64 libbz2-dev:arm64 libcaca-dev:arm64 libxvmc-dev:arm64 \
libcdio-paranoia-dev:arm64 libchromaprint-dev:arm64 libdc1394-22-dev:arm64 libdrm-dev:arm64 libfontconfig1-dev:arm64 \
libfreetype6-dev:arm64 libfribidi-dev:arm64 libgme-dev:arm64 libgsm1-dev:arm64 libiec61883-dev:arm64 libxvidcore-dev:arm64 \
libavc1394-dev:arm64 libjack-jackd2-dev:arm64 libleptonica-dev:arm64 liblzma-dev:arm64 libmp3lame-dev:arm64 libxcb-xfixes0-dev:arm64 \
libopenal-dev:arm64 libomxil-bellagio-dev:arm64 libopencore-amrnb-dev:arm64 libzvbi-dev:arm64 libxv-dev:arm64 libxcb-shm0-dev:arm64 \
libopencore-amrwb-dev:arm64 libopencv-imgproc-dev:arm64 libopenjp2-7-dev:arm64 libopenmpt-dev:arm64 libxml2-dev:arm64 \
libopus-dev:arm64 libpulse-dev:arm64 librubberband-dev:arm64 librsvg2-dev:arm64 libsctp-dev:arm64 libxcb-shape0-dev:arm64 \
libsdl2-dev:arm64 libshine-dev:arm64 libsnappy-dev:arm64 libsoxr-dev:arm64 libspeex-dev:arm64 libssh-gcrypt-dev:arm64 \
libtesseract-dev:arm64 libtheora-dev:arm64 libtwolame-dev:arm64 libva-dev:arm64 libvdpau-dev:arm64 libx265-dev:arm64 \
libvo-amrwbenc-dev:arm64 libvorbis-dev:arm64 libvpx-dev:arm64 libwavpack-dev:arm64 libwebp-dev:arm64 libx264-dev:arm64 \
doxygen cleancss node-less

# Mpv
RUN apt-get update && apt-get install -y libasound2-dev:arm64 libass-dev:arm64 libavcodec-dev:arm64 libavdevice-dev:arm64 \
libavfilter-dev:arm64 libavformat-dev:arm64 libavresample-dev:arm64 libavutil-dev:arm64 libbluray-dev:arm64 libcaca-dev:arm64 \
libcdio-paranoia-dev:arm64 libdvdnav-dev:arm64 libdvdread-dev:arm64 libegl1-mesa-dev:arm64 libgbm-dev:arm64 \
libgl1-mesa-dev:arm64 libjack-dev:arm64 libjpeg-dev:arm64 liblcms2-dev:arm64 liblua5.2-dev:arm64 libpulse-dev:arm64 \
librubberband-dev:arm64 libsdl2-dev:arm64 libsmbclient-dev:arm64 libsndio-dev:arm64 libswscale-dev:arm64 \
libuchardet-dev:arm64 libva-dev:arm64 libvdpau-dev:arm64 libwayland-dev:arm64 libx11-dev:arm64 libxinerama-dev:arm64 \
libxkbcommon-dev:arm64 libxrandr-dev:arm64 libxss-dev:arm64 libxv-dev:arm64

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
#RUN dpkg -i /packages/mpp/*.deb
RUN dpkg -i /packages/arm64/mpp/*.deb
RUN dpkg -i /packages/arm64/gstreamer/*.deb
RUN dpkg -i /packages/arm64/libmali/*.deb
RUN dpkg -i /packages/arm64/qt/*.deb
RUN find /packages/arm64/libdrm -name '*.deb' | sudo xargs -I{} dpkg -x {} /

RUN apt-get update && apt-get install -y -f

# switch to a no-root user
RUN useradd -c 'rk user' -m -d /home/rk -s /bin/bash rk
RUN sed -i -e '/\%sudo/ c \%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN usermod -a -G sudo rk

USER rk
