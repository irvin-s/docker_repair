FROM ubuntu  
  
ENV PATH="~/.local/bin:${PATH}"  
  
RUN apt update  
  
RUN apt-get install -y automake autopoint build-essential ccache check \  
doxygen faenza-icon-theme git imagemagick libasound2-dev libblkid-dev \  
libbluetooth-dev libbullet-dev libcogl-gles2-dev libfontconfig1-dev \  
libfreetype6-dev libfribidi-dev libgif-dev libgstreamer1.0-dev \  
libgstreamer-plugins-base1.0-dev libharfbuzz-dev libibus-1.0-dev \  
libiconv-hook-dev libinput-dev libjpeg-dev libblkid-dev libluajit-5.1-dev \  
liblz4-dev libmount-dev libopenjp2-7-dev libpam0g-dev libpoppler-cpp-dev \  
libpoppler-dev libpoppler-private-dev libproxy-dev libpulse-dev \  
libraw-dev librsvg2-dev libscim-dev libsndfile1-dev libspectre-dev \  
libssl-dev libsystemd-dev libtiff5-dev libtool libudev-dev \  
libudisks2-dev libunibreak-dev libunwind-dev libvlc-dev libwebp-dev \  
libxcb-keysyms1-dev libxcursor-dev libxine2-dev libxinerama-dev \  
libxkbfile-dev libxrandr-dev libxss-dev libxtst-dev \  
linux-tools-common texlive-base unity-greeter-badges \  
valgrind xserver-xephyr ninja-build python3-pip git clang lua5.2  
  
RUN pip3 install --user meson  
  
RUN git clone http://git.enlightenment.org/core/efl.git  

